(define-module (my-packages my-glib2)
  #:use-module (gnu packages) ; for 'search-patches
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash) ; for bash-completion
  #:use-module (gnu packages build-tools) ; for meson/newer
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf) ; for libelf
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages instrumentation) ; for systemtap
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux) ; for util-linux
  #:use-module (gnu packages selinux)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pth)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz) ; for python-packaging
  #:use-module (gnu packages valgrind)
  #:use-module (gnu packages xml) ; for xmllint
  #:use-module (guix build-system meson) ;; for glib
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix store) ; for 'text-file'
  #:use-module (guix utils)
 )

;; Custom meson is required for building glib2 (>=1.2)
(define-public meson-1.3
  (package
    (inherit meson/newer)
    (version "1.3.2")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/mesonbuild/meson/"                                  "releases/download/" version  "/meson-"
                                  version ".tar.gz"))
              (sha256
               (base32
                "1ajvkcyly1nsxwjc2vly1vlvfjrwpfnza5prfr104wxhr18b8bj9"))))))




; My custom diff file by removing one more line than the patch from source code ("glib-skip-failing-test.patch").
; Created with 'git diff --no-index PATH1 PATH2
; And then adapted a few to looks like the one from the source code (top of the file adapted)
(define-public replacement-patch.patch (plain-file "replacement-patch.patch"
"This test timed out on powerpc-linux even after extending the
test_timeout_slow to 1800 seconds. Previously we tried to work around
this test by extending test_timeout_slow by 1.5 its previous value.

---
 gio/tests/meson.build | 5 ----
 1 file changed, 5 deletions(-)
					    
diff --git a/gio/tests/meson.build b/gio/tests/meson.build
index 4c70465..0fcc836 100644
--- a/gio/tests/meson.build
+++ b/gio/tests/meson.build
@@ -495,11 +495,6 @@ if host_machine.system() != 'windows'
         'c_args' : ['-DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_32'],
         'suite': ['gdbus-codegen'],
       },
-      'gdbus-threading' : {
-        'extra_sources' : extra_sources,
-        'extra_programs': extra_programs,
-        'suite' : ['slow'],
-      },
       'gmenumodel' : {
         'extra_sources' : extra_sources,
         'suite' : ['slow'],
"
))

;; A separated code to execute my custom patch (based on "glib-skip-failing-test.patch")
(define apply-custom-patch-glib-skip-failing-test.patch
   #~(begin
       (let
	   ; BINDING
	   ((dummy-binding "dummy-binding"))
	   ; BODY
	   (set-path-environment-variable
	    "PATH" '("bin")
	    (list #+patch #+xz)) ; xz is required for using 'tar' in order to use 'patch'
          (force-output)
      (invoke "patch" "--force" "--no-backup-if-mismatch" "-p1" "--input" #+replacement-patch.patch)
      )
       ))
	  
(define-public my-glib2
  (package
   (inherit glib)
   (name "my-glib2")
   (version "2.80.0") ;; The latest available on the 10.03.24
   (source
     ;; My lines modified
     (origin
       (method url-fetch)
       (uri (string-append
	     "https://download.gnome.org/sources/glib/2.80/glib-2.80.0.tar.xz"))
       (sha256
        (base32
         "07ang9cgy8dy1qaszdd76i2g4a5x8miqprls2c5ic4m4j8psja42"))

       ;; (some part of) Original code
       (patches
        (search-patches
	                 "glib-appinfo-watch.patch"
                        ;"glib-skip-failing-test.patch" ;; To be replaced by snippet(s) because the file to patch has an additional line so the patch does not work
			))
			
       
       (modules '((guix build utils)))
       ;; Snippets adapted from original code with a path modification (first) and a replacement from an original patch ("glib-skip-failing-test.patch") by my custom one (second)
       (snippet
        #~(begin
           (substitute* "glib/tests/spawn-test.c" ;; PATH adapted else file not found. 
			(("/bin/sh") "sh"))
	  ;; applying my custom patch here
	  #+apply-custom-patch-glib-skip-failing-test.patch)))) 
       
  (arguments
   (list
      ;; My lines added
      #:meson meson-1.3
    
      ;; The other arguments from the package - the rest of the 'arguments' field was not modified
      #:disallowed-references
      (cons tzdata-for-tests
            ;; Verify glib-mkenums, gtester, ... use the cross-compiled
            ;; python.
            (if (%current-target-system)
                (map (cut gexp-input <> #:native? #t)
                     `(,(this-package-native-input "python")
                       ,(this-package-native-input "python-wrapper")))
                '()))
      #:configure-flags #~(list "--default-library=both"
                                "-Dman=false"
                                "-Dselinux=disabled"
                                (string-append "--bindir="
                                               #$output:bin "/bin"))
      #:phases
      #~(modify-phases %standard-phases
          ;; Needed to pass the test phase on slower ARM and i686 machines.
          (add-after 'unpack 'increase-test-timeout
            (lambda _
              (substitute* "meson.build"
                (("(test_timeout.*) = ([[:digit:]]+)" all first second)
                 (string-append first " = " second "0")))))
          (add-after 'unpack 'disable-failing-tests
            (lambda _
              (substitute* "gio/tests/meson.build"
                ((".*'testfilemonitor'.*") ;marked as flaky
                 ""))
              (with-directory-excursion "glib/tests"
                (substitute* '("unix.c" "utils.c")
                  (("[ \t]*g_test_add_func.*;") "")))
              (with-directory-excursion "gio/tests"
                (substitute* '("contenttype.c" "gdbus-address-get-session.c"
                               "gdbus-peer.c" "appinfo.c" "desktop-app-info.c")
                  (("[ \t]*g_test_add_func.*;") "")))

              #$@(if (target-x86-32?)
                     ;; Comment out parts of timer.c that fail on i686 due to
                     ;; excess precision when building with GCC 10:
                     ;; <https://gitlab.gnome.org/GNOME/glib/-/issues/820>.
                     '((substitute* "glib/tests/timer.c"
                         (("^  g_assert_cmpuint \\(micros.*" all)
                          (string-append "//" all "\n"))
                         (("^  g_assert_cmpfloat \\(elapsed, ==.*" all)
                          (string-append "//" all "\n"))))
                     '())
              #$@(if (system-hurd?)
                     '((with-directory-excursion "gio/tests"
                         ;; TIMEOUT after 600s
                         (substitute* '("actions.c"
                                        "dbus-appinfo.c"
                                        "debugcontroller.c"
                                        "gdbus-bz627724.c"
                                        "gdbus-connection-slow.c"
                                        "gdbus-exit-on-close.c"
                                        "gdbus-export.c"
                                        "gdbus-introspection.c"
                                        "gdbus-method-invocation.c"
                                        "gdbus-non-socket.c"
                                        "gdbus-proxy-threads.c"
                                        "gdbus-proxy-unique-name.c"
                                        "gdbus-proxy-well-known-name.c"
                                        "gdbus-proxy.c"
                                        "gdbus-test-codegen.c"
                                        "gmenumodel.c"
                                        "gnotification.c"
                                        "stream-rw_all.c")
                           (("return (g_test_run|session_bus_run)" all call)
                            (string-append "return 0;// " call))
                           ((" (ret|rtv|result) = (g_test_run|session_bus_run)"
                             all var call)
                            (string-append " " var " = 0;// " call))
                           (("[ \t]*g_test_add_func.*;") ""))

                         ;; commenting-out g_assert, g_test_add_func, g_test_run
                         ;; does not help; special-case short-circuit.
                         (substitute* "gdbus-connection-loss.c" ;; TODO?
                           (("  gchar \\*path;.*" all)
                            (string-append all "  return 0;\n")))

                         ;; FAIL
                         (substitute* '("appmonitor.c"
                                        "async-splice-output-stream.c"
                                        "autoptr.c"
                                        "contexts.c"       
                                        "converter-stream.c"
                                        "file.c"
                                        "g-file-info.c"
                                        "g-file.c"
                                        "g-icon.c"
                                        "gapplication.c"
                                        "gdbus-connection-flush.c"
                                        "gdbus-connection.c"
                                        "gdbus-names.c"    
                                        "gdbus-server-auth.c"
                                        "gsocketclient-slow.c"
                                        "gsubprocess.c"
                                        "io-stream.c"
                                        "live-g-file.c"
                                        "memory-monitor.c" 
                                        "mimeapps.c"
                                        "network-monitor-race.c"
                                        "network-monitor.c"
                                        "pollable.c"
                                        "power-profile-monitor.c"
                                        "readwrite.c"
                                        "resources.c"
                                        "socket-service.c"
                                        "socket.c"
                                        "tls-bindings.c"
                                        "tls-certificate.c"
                                        "tls-database.c"
                                        "trash.c"
                                        "vfs.c")
                           (("return (g_test_run|session_bus_run)" all call)
                            (string-append "return 0;// " call))
                           ((" (ret|rtv|result) = (g_test_run|session_bus_run)"
                             all var call)
                            (string-append " " var " = 0;// " call))
                           (("[ \t]*g_test_add_func.*;") ""))

                         ;; commenting-out g_test_add_func, g_test_run does
                         ;; not help; special-case short-circuit.
                         (substitute* "gsettings.c"
                           (("#ifdef TEST_LOCALE_PATH" all)
                            (string-append "  return 0;\n" all)))

                         ;; commenting-out g_test_add_func, ;; g_test_run does
                         ;; not help; special-case short-circuit.
                         (substitute* "proxy-test.c"
                           (("  gint result.*;" all)
                            (string-append all "  return 0;\n")))

                         ;; commenting-out g_test_add_func, g_test_run
                         ;; does not help; special-case short-circuit.
                         (substitute* "volumemonitor.c"
                           (("  gboolean ret;" all)
                            (string-append all "  return 0;\n"))))

                       (with-directory-excursion "glib/tests"
                         ;; TIMEOUT after 600s
                         (substitute* "thread-pool.c"
                           (("[ \t]*g_test_add_func.*;") ""))

                         ;; FAIL
                         (substitute* "fileutils.c"
                           (("[ \t]*g_test_add_func.*;") ""))))
                     '())))
          ;; Python references are not being patched in patch-phase of build,
          ;; despite using python-wrapper as input. So we patch them manually.
          ;;
          ;; These python scripts are both used during build and installed,
          ;; so at first, use a python from 'native-inputs', not 'inputs'. When
          ;; cross-compiling, the 'patch-shebangs' phase will replace
          ;; the native python with a python from 'inputs'.
          (add-after 'unpack 'patch-python-references
            (lambda* (#:key native-inputs inputs #:allow-other-keys)
              (substitute* '("gio/gdbus-2.0/codegen/gdbus-codegen.in"
                             "glib/gtester-report.in"
                             "gobject/glib-genmarshal.in"
                             "gobject/glib-mkenums.in")
                (("@PYTHON@")
                 (search-input-file (or native-inputs inputs)
                                    (string-append
                                     "/bin/python"
                                     #$(version-major+minor
                                        (package-version python))))))))
          (add-before 'check 'pre-check
            (lambda* (#:key native-inputs inputs outputs #:allow-other-keys)
              ;; For tests/gdatetime.c.
              (setenv "TZDIR"
                      (search-input-directory (or native-inputs inputs)
                                              "share/zoneinfo"))
              ;; Some tests want write access there.
              (setenv "HOME" (getcwd))
              (setenv "XDG_CACHE_HOME" (getcwd))))
          (add-after 'install 'move-static-libraries
            (lambda _
              (mkdir-p (string-append #$output:static "/lib"))
              (for-each (lambda (a)
                          (rename-file a (string-append #$output:static "/lib/"
                                                        (basename a))))
                        (find-files #$output "\\.a$"))))
          (add-after 'install 'patch-pkg-config-files
            (lambda* (#:key outputs #:allow-other-keys)
              ;; Do not refer to "bindir", which points to "${prefix}/bin".
              ;; We don't patch "bindir" to point to "$bin/bin", because that
              ;; would create a reference cycle between the "out" and "bin"
              ;; outputs.
              (substitute*
                  (list (search-input-file outputs "lib/pkgconfig/gio-2.0.pc")
                        (search-input-file outputs "lib/pkgconfig/glib-2.0.pc"))
                (("^bindir=.*")
                 "")
                (("=\\$\\{bindir\\}/")
                 "=")))))))
  
  (inputs
     ;; Original code
     (list ;; "python", "python-wrapper" and "bash-minimal"
      ;; are for the 'patch-shebangs' phase, to make
      ;; sure the installed scripts end up with a correct shebang
      ;; when cross-compiling.
      bash-minimal
      python
      python-wrapper

      ;; My additional inputs 
      bash-completion
      cmake
      gcc
      gnu-gettext ; for gettext
      gobject-introspection
      libelf
      libffi
      libiconv
      libxml2 ; for xmllint
      libxml2-xpath0 ; for xmllint with an additional patch
      pcre2
      pkg-config
      pth ; for 'posix thread'
      ;;python ; already in
      python-packaging
      libselinux
      systemtap
      util-linux ; for 'mount' - MOUNT IS STILL MISSING
      valgrind
      xmlsec ; for xmllint
      zlib
      ))
  ))  

#!
missing :
Program valgrind found: NO -> should be corrected
Program xmllint found: NO -> should be corrected
Run-time dependency libelf found: NO (tried pkgconfig and cmake)
Library elf found: NO
!#

;; Comment this line after development tests.
my-glib2
