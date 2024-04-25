(define-module (my-packages my-sqltutor)
  ;;#:use-module (gnu packages autotools) ; for libtool, automake (for aclocal)
  ;;#:use-module (gnu packages base) ; for gnu-make (make)
  ;;#:use-module (gnu packages compression) ; for xz (to apply custom patch)
  ;;#:use-module (gnu packages build-tools) ; for gnulib-tool
  ;;#:use-module (gnu packages flex)
  ;;#:use-module (gnu packages gcc)
  ;;#:use-module (gnu packages glib)
  #:use-module (gnu packages databases) ; for libpqxx & postgresql
  #:use-module (gnu packages geo) ; for postgis
  #:use-module (gnu packages pkg-config)
  ;;#:use-module (gnu packages version-control) ; For git
  ;;#:use-module (gnu packages wget)
  ;;#:use-module (guix build utils) ; for 'substitute' definition, and for 'set-path-environment-variable'
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp) ; for #~
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
  ;;#:use-module (ice-9 regex) ; for the 'match:substring' procedure 
)

(define-public my-sqltutor
  (package
    (name "my-sqltutor")
    (version "1.0") ;; 240425
    (source
     (origin
       (method url-fetch)
       (uri
	(string-append
	 "https://ftp.gnu.org/gnu/sqltutor/sqltutor-" version ".tar.gz"))
       (sha256
        (base32
         "1qda46q4d437am667903r5pkszzc1ijq9zrap25nhw3n32yyn7fi"))))
    (build-system gnu-build-system)
    (arguments '())
    ;; DEBUG : code for arguments if needed
#!
    (arguments
     (list #:make-flags #~'("VERBOSE=1")   ;pass flags to 'make'
	   ))
!#
    (inputs
     (list
      libpqxx
      pkg-config))
;; DEBUG : Below = to test : if it works without installing those propagated inputs 
#!
    (propagated-inputs
     (list
      postgis
      postgresql))
!#
    (synopsis "DEBUG : SYNOPSIS TO WRITE")
    (description "DEBUG : DESCRIPTION TO WRITE")
    (home-page "https://savannah.gnu.org/projects/sqltutor/")
    (license license:gpl3)))

my-sqltutor ;; Development purpose

