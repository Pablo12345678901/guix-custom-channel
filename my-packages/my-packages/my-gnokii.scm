(define-module (my-packages my-gnokii)
  #:use-module (gnu packages autotools) ; for libtool, automake (for aclocal)
  #:use-module (gnu packages base) ; for gnu-make (make)
  #:use-module (gnu packages compression) ; for xz (to apply custom patch)
  #:use-module (gnu packages build-tools) ; for gnulib-tool
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages version-control) ; For git
  #:use-module (gnu packages wget)
  #:use-module (guix build utils) ; for 'substitute' definition, and for 'set-path-environment-variable'
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp) ; for regex in snippet
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
  #:use-module (ice-9 regex) ; for the 'match:substring' procedure 
)

#!
;; LIST OF MISSING FILE TO INSTALL KEPT IN CASE A BUG OCCURS DURING THE INSTALLATION.
;; SO FAR THE BUILD IS OK.
       "codeset.m4" ; OK in gnulib - INSTALLED MANUALLY
       "gettext.m4" ; OK in gnulib
       "glibc21.m4" ; NOT OK not in gnulib so to be found
       "iconv.m4" ; OK in gnulib
       "isc-posix.m4" ; NOT OK not in gnulib so to be found
       "lcmessage.m4" ; OK in gnulib
       "progtest.m4" ; OK in gnulib
       "config.guess" ; NOT OK to be taken from ftp://ftp.gnu.org/pub/gnu/config/
       "config.sub" ; NOT OK to be taken from ftp://ftp.gnu.org/pub/gnu/config/
!#
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; DEFINING MISSING FILES MANUALLY BY COPY/PASTING THEIR CONTENT ;;;;;;;;;;;;;;;;;;;;;;;;;
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
       (modules '((guix build utils))) ; for the 'set-path-environment-variable' procedure
       (snippet
	#~(begin
       ;; Adding the content of missing files manually by copy/pasting their content into string variable that I call
	      (with-output-to-file (string-append "m4/codeset.m4")
		(lambda* (#:key codeset-m4-content #:allow-other-keys)
			 (format #t "~a~%" #+codeset-m4-content)))
	      ))))
    
    (build-system gnu-build-system)

    ;; It is after unpack, but cannot be before bootstrap - so within it.
    (arguments
     (list
      #:modules
      `((ice-9 regex) ; for the 'match:substring' procedure
         ,@%gnu-build-system-modules)
       #:phases
       #~(modify-phases %standard-phases		
            (replace 'bootstrap
                (lambda* (#:key inputs #:allow-other-keys)
		 (let* ((script "./autogen.sh")
			(sh-path (which "sh"))
			;; Get the list of each part of the path splitted by '/'
			(list-of-path-parts (list (map match:substring (list-matches "[-\\.a-z0-9]+" sh-path))))
			;; Get each part one by one
			(part-of-path-0 (list-ref (map match:substring (list-matches "[-\\.a-z0-9]+" sh-path)) 0))
			(part-of-path-1 (list-ref (map match:substring (list-matches "[-\\.a-z0-9]+" sh-path)) 1))
			(part-of-path-2 (list-ref (map match:substring (list-matches "[-\\.a-z0-9]+" sh-path)) 2))
			(part-of-path-3 (list-ref (map match:substring (list-matches "[-\\.a-z0-9]+" sh-path)) 3))
			(part-of-path-4 (list-ref (map match:substring (list-matches "[-\\.a-z0-9]+" sh-path)) 4)))
		;; Replacing the sheband in the configure file through the autoconf file by adding a replacement command with sed. Mandatory to be done here because before running the 'autogen.sh' script, the file 'configure' does not exist.
                (substitute* '("autogen.sh")
			     (("autoconf")
			      (string-append "autoconf && sed -i 's/\\/bin\\/sh/"
				  "\\/" part-of-path-0
				  "\\/" part-of-path-1
				  "\\/" part-of-path-2
				  "\\/" part-of-path-3
				  "\\/" part-of-path-4
				  "/g' configure")))
		 (patch-shebang script)		    
		 (invoke script)
	         ;; Let's clean up after ourselves.
                 (unsetenv "NOCONFIGURE") ; This line was in the 'bootstrap' definition so left it.
		)
		 ))
	    
	    ;; IN DEVELOPMENT HERE : trying to replace a line in a file to avoid the bug 'local_atoi' is undefined
	    ;; See : Patch from gnokii github : https://github.com/pld-linux/gnokii/blob/master/gnokii-gcc7.patch
	    (add-after 'configure 'patch-gsm-file-to-avoid-local-atoi-error
		       (lambda* (#:key inputs #:allow-other-keys) ; Test
			;; Substitute* is by default in UTF-8 and the file was not - so issue while trying to replace the line.
			(with-fluids ((%default-port-encoding "ISO-8859-1"))
			(substitute* "common/gsm-filetypes.c"
			     ((".*inline[[:space:]]int[[:space:]]local_atoi") "static int local_atoi")))
		  ))

	)))

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
      )
     )
    (native-inputs '())
    (propagated-inputs '())
    
    (synopsis "gnokii provides tools and a user space driver for use with mobile phones under various operating systems (most testing is done under Linux but also Solaris, *BSD family and MS Windows families are known to work). If you wonder whether your phone is supported or not, it is safe to assume it is supported, at least when the phone is fairly modern. However there are rare cases that make phone support very limited. You may refer to our wiki pages for hints in the gnokii configuration.")
     (description "gnokii provides tools and a user space driver for use with mobile phones under various operating systems (most testing is done under Linux but also Solaris, *BSD family and MS Windows families are known to work). If you wonder whether your phone is supported or not, it is safe to assume it is supported, at least when the phone is fairly modern. However there are rare cases that make phone support very limited. You may refer to our wiki pages for hints in the gnokii configuration.")
    (home-page "https://gnokii.org/")
    (license license:gpl1)))

;;my-gnokii ;; Uncomment this line during development tests. Comment it when finished.

