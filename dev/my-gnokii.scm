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
         "1iphhjsz9v1pk0a3p2zq09k44x7pyg1a6m3dcpf6n0bpyfgskpsn"))))

    
    (build-system gnu-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'bootstrap 'replace-commands-by-absolute-paths
	      (lambda* (#:key outputs inputs #:allow-other-keys)
		; replace the command 'glib-gettextize' by its path in the store
	        (substitute* "autogen.sh"  
		(("glib-gettextize")
		 (string-append (assoc-ref inputs "glib") "/bin/glib-gettextize")
		 ))))
	  (add-before 'bootstrap 'copy-missing-files-with-macros
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
		      (lambda* (#:key outputs inputs #:allow-other-keys)
			       (let*
				   (
				    (file-1 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/codeset.m4"))
				    (file-2 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/gettext.m4"))
				    (file-3 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/iconv.m4"))
				    (file-4 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/lcmessage.m4"))
				    (file-5 (string-append (assoc-ref inputs "gnulib") "/src/gnulib/m4/progtest.m4"))
				    (list-of-files (list file-1 file-2 file-3 file-4 file-5))
				    (target-directory (string-append (assoc-ref outputs "out") "/m5"))
				    ; WARNING : For debugging, the /gnu/store hash in the name changes each time that a new directory/file is added.
				    ; So it has to be printed each time to know it. 
				   )
				 (for-each (lambda (missing-file)
					      (install-file missing-file target-directory))
					   list-of-files)
				   )))
			  			       
		         ;(string-append source-directory "/codeset.m4")
		         ;(string-append (assoc-ref outputs "out"))     
			      )))
		       ;(let
		;	   ((target-directory (string-append (assoc-ref inputs "glib") "/m4")))
		;	 ('())
		;	 )))
			    ;(target-directory (assoc-ref outputs "out"))
		            ;(filename "codeset.m4")
		       ;(
		        ;(mkdir-p target-directory)
	                ;(install-file
		         ;(string-append source-directory "/codeset.m4")
		         ;(string-append (assoc-ref outputs "out"))
		        ;(copy-recursively source-directory target-directory) ; Works partially, copy X files and then ERRO
	  
    (inputs
     (list
          autoconf ; for 'autom4te'
          automake ; for 'aclocal'
          flex
          gcc
	  `(,glib "bin") ; for 'glib-gettextize' in autogen.sh
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

