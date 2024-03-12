(define-module (my-packages my-gnokii)
  #:use-module (gnu packages autotools) ; for libtool, automake (for aclocal)
  #:use-module (gnu packages base) ; for gnu-make (make)
  #:use-module (gnu packages build-tools) ; for gnulib-tool
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages networking) ; TEST
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages version-control) ; For git
  #:use-module (gnu packages wget)
  #:use-module (guix build utils) ; for 'substitute' definition
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp) ; for regex in snippet
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

#!    
(define* (bootstrap #:key (bootstrap-scripts %bootstrap-scripts)
                    #:allow-other-keys)
  "If the code uses Autotools and \"configure\" is missing, run
\"autoreconf\".  Otherwise do nothing."
  ;; Note: Run that right after 'unpack' so that the generated files are
  ;; visible when the 'patch-source-shebangs' phase runs.
  (define (script-exists? file)
    (and (file-exists? file)
         (not (file-is-directory? file))))

  (if (not (script-exists? "configure"))

      ;; First try one of the BOOTSTRAP-SCRIPTS.  If none exists, and it's
      ;; clearly an Autoconf-based project, run 'autoreconf'.  Otherwise, do
      ;; nothing (perhaps the user removed or overrode the 'configure' phase.)
      (let ((script (find script-exists? bootstrap-scripts)))
        ;; GNU packages often invoke the 'git-version-gen' script from
        ;; 'configure.ac' so make sure it has a valid shebang.
        (false-if-file-not-found
         (patch-shebang "build-aux/git-version-gen"))

        (if script
            (let ((script (string-append "./" script)))
              (setenv "NOCONFIGURE" "true")
              (format #t "running '~a'~%" script)
              (if (executable-file? script)
                  (begin
                    (patch-shebang script)
                    (invoke script))
                  (invoke "sh" script))
              ;; Let's clean up after ourselves.
              (unsetenv "NOCONFIGURE"))
            (if (or (file-exists? "configure.ac")
                    (file-exists? "configure.in"))
                (invoke "autoreconf" "-vif")
                (format #t "no 'configure.ac' or anything like that, \
doing nothing~%"))))
      (format #t "GNU build system bootstrapping not needed~%")))
!#
#!
;;LIST OF MISSING FILE TO INSTALL 
       "codeset.m4" ; OK in gnulib
       "gettext.m4" ; OK in gnulib
       "glibc21.m4" ; NOT OK not in gnulib so to be found
       "iconv.m4" ; OK in gnulib
       "isc-posix.m4" ; NOT OK not in gnulib so to be found
       "lcmessage.m4" ; OK in gnulib
       "progtest.m4" ; OK in gnulib
       "config.guess" ; NOT OK to be taken from ftp://ftp.gnu.org/pub/gnu/config/
       "config.sub" ; NOT OK to be taken from ftp://ftp.gnu.org/pub/gnu/config/
!#
#!
     (list
      #:phases
      #~(modify-phases %standard-phases
         (add-after 'unpack 'patch-more-shebangs
           (lambda _
             (substitute* "configure"
               (("#! /bin/sh") (string-append "#! " (which "sh")))))))))
!#
#!
; Block kept in case its is needed - works to replace the path into the 'autogen.sh file and
; this block was replaced by a snippet below
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
        (add-before 'bootstrap 'replace-commands-by-absolute-paths
	      ;(lambda* (#:key outputs inputs #:allow-other-keys) ; uncomment this line when printing the output directory
	      (lambda* (#:key inputs #:allow-other-keys)
		; replace the command 'glib-gettextize' by its path in the store
	        (substitute* "autogen.sh"  
		(("glib-gettextize")
		 (string-append (assoc-ref inputs "glib") "/bin/glib-gettextize")
		 ;(target-directory (string-append (assoc-ref outputs "out") ; uncomment this line to print the output directory
		 ))))
!#
#!
;; Block kept in case, works.
	  (add-before 'bootstrap 'copy-missing-files-with-macros
            (lambda* (#:key outputs inputs #:allow-other-keys)
			       (let*
				   (
				    (file-1 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/codeset.m4"))
				    (file-2 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/gettext.m4"))
				    (file-3 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/iconv.m4"))
				    (file-4 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/lcmessage.m4"))
				    (file-5 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/progtest.m4"))
				    (list-of-files (list file-1 file-2 file-3 file-4 file-5))
				    (target-directory (string-append (assoc-ref outputs "out") "/m4"))
				    ; WARNING : For debugging, the /gnu/store hash in the name changes each time that a new directory/file is added.
				    ; So it has to be printed each time to know it. 
				   )
				 (for-each (lambda (missing-file)
					      (install-file missing-file target-directory))
					   list-of-files)
				   ))))))
!# 
#!
;; Block not working
    (build-system gnu-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
        (add-after 'unpack 'add-missing-files
    		  (lambda* (#:key outputs inputs #:allow-other-keys)
			       (let*
				   (
				    (file-1 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/codeset.m4"))
				    (file-2 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/gettext.m4"))
				    (file-3 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/iconv.m4"))
				    (file-4 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/lcmessage.m4"))
				    (file-5 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/progtest.m4"))
				    (list-of-files (list file-1 file-2 file-3 file-4 file-5))
				    ;(target-directory (string-append (assoc-ref outputs "out") "/m4"))
				    (target-directory  (string-append (assoc-ref outputs "out")"/m4"))
				    )
				    ; WARNING : For debugging, the /gnu/store hash in the name changes each time that a new directory/file is added.
				    ; So it has to be printed each time to know it. 
				   )
				 (for-each (lambda (missing-file)
					      (install-file missing-file target-directory))
					   list-of-files)
				   )))))
!#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; DEFINING A FEW MISSING FILES MANUALLY BY COPY/PASTING THEIR CONTENT;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define codeset-m4-content
  "# codeset.m4 serial 5 (gettext-0.18.2)
dnl Copyright (C) 2000-2002, 2006, 2008-2014, 2016, 2019-2023 Free Software
dnl Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl From Bruno Haible.

AC_DEFUN([AM_LANGINFO_CODESET],
[
  AC_CACHE_CHECK([for nl_langinfo and CODESET], [am_cv_langinfo_codeset],
    [AC_LINK_IFELSE(
       [AC_LANG_PROGRAM(
          [[#include <langinfo.h>]],
          [[char* cs = nl_langinfo(CODESET); return !cs;]])],
       [am_cv_langinfo_codeset=yes],
       [am_cv_langinfo_codeset=no])
    ])
  if test $am_cv_langinfo_codeset = yes; then
    AC_DEFINE([HAVE_LANGINFO_CODESET], [1],
      [Define if you have <langinfo.h> and nl_langinfo(CODESET).])
  fi
])"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; END OF FILES CONTENT DEFINITION  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-public my-gnokii
  (package
    (name "my-gnokii")
    (version "0.6.31") ;; The latest available on the 10.03.24
    (source
     (origin
       (method url-fetch)
       (uri (string-append
	     "https://git.savannah.gnu.org/cgit/gnokii.git/snapshot/gnokii-rel_0_6_31.tar.gz"))
       (sha256
        (base32
         "1iphhjsz9v1pk0a3p2zq09k44x7pyg1a6m3dcpf6n0bpyfgskpsn"))
      ; )
       (snippet
	#~(begin
       ;; Adding the content of missing files manually by copy/pasting their content into string variable that I call
	      (with-output-to-file (string-append "m4/codeset.m4")
		(lambda* (#:key codeset-m4-content #:allow-other-keys)
			 (format #t "~a~%" #+codeset-m4-content)))
                ))))
    
    (build-system gnu-build-system)
;    (arguments '())
;#!
;    # It is after unpack, but cannot be before bootstrap - so within it.
    (arguments
      (list
       #:phases
       #~(modify-phases %standard-phases


#!
                (call-with-output-file "Makefile.config"
                  (lambda (port) (display "" port)))
                (substitute* "Makefile"
                  (("^PACKAGE_VERSION =.*")
                   (string-append "PACKAGE_VERSION = \"" #$version "\"\n")))
!#
			
	 (replace 'bootstrap
           (lambda _
	     (let (
		   (script (string-append "./" "autogen.sh"))
		  )
              (setenv "NOCONFIGURE" "true")
              (format #t "running '~a'~%" script)
              (if (executable-file? script)
		  ; If yes
                  (begin
                    (patch-shebang script)

                     ;(substitute* "autogen.sh"
                     ;  (("autoconf") (string-append "autoconf" "&&" "echo haha")))
		    
                    (invoke script))
		  ; Else
                  (invoke "sh" script))
              ;; Let's clean up after ourselves.
              (unsetenv "NOCONFIGURE"))
	   )
	))))
;!#
    (inputs
     (list
          autoconf ; for 'autom4te'
          automake ; for 'aclocal'
          flex
          gcc
	  `(,glib "bin") ; for 'glib-gettextize' in autogen.sh
	  glib ; for the 'glib-gettext.m4' library containing 'AM_GLIB_GNU_GETTEXT' macro
          git
	  gnulib
          gnu-make
	  intltool ; for 'intltoolize' in autogen.sh
	  libtool
          pkg-config
	  wget ; required for installing missing files : codeset.m4 gettext.m4 glibc21.m4 iconv.m4 isc-posix.m4 lcmessage.m4 progtest.m4
      )
     )
    (native-inputs '())
    (propagated-inputs '())
    
    (synopsis "gnokii provides tools and a user space driver for use with mobile phones under various operating systems (most testing is done under Linux but also Solaris, *BSD family and MS Windows families are known to work). If you wonder whether your phone is supported or not, it is safe to assume it is supported, at least when the phone is fairly modern. However there are rare cases that make phone support very limited. You may refer to our wiki pages for hints in the gnokii configuration.")
     (description "gnokii provides tools and a user space driver for use with mobile phones under various operating systems (most testing is done under Linux but also Solaris, *BSD family and MS Windows families are known to work). If you wonder whether your phone is supported or not, it is safe to assume it is supported, at least when the phone is fairly modern. However there are rare cases that make phone support very limited. You may refer to our wiki pages for hints in the gnokii configuration.")
    (home-page "https://gnokii.org/")
    (license license:gpl1)))

;; Comment this line after finishing the development tests.
my-gnokii

