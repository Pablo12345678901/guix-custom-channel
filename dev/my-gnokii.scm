(define-module (my-packages my-gnokii)
  #:use-module (gnu packages autotools) ; for libtool, automake (for aclocal)
  #:use-module (gnu packages base) ; for gnu-make (make)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages version-control) ; For git
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
	      (lambda* (#:key inputs #:allow-other-keys)
		; replace the command by the bash path in the store
	        (substitute* "autogen.sh"  
		(("glib-gettextize")
	         (string-append (assoc-ref inputs "glib") "/bin/glib-gettextize")
		  ))
					)))))
    (inputs
     (list
          autoconf ; for 'autom4te'
          automake ; for 'aclocal'
          flex
          gcc
	  `(,glib "bin") ; for 'glib-gettextize' in autogen.sh
          git
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

;; Comment this line after finishing the development tests.
my-gnokii

