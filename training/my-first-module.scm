;; This file does not return a package - only define it.
;; If returning a package is wished, then use 'package-name' below its definition - that way, it will call its definition which in turn will return a package.
;; Else use this file that way :
;;    -L, --load-path=DIR    prepend DIR to the package module search path
;; guix show -L FILE-DIR PACKAGE-NAME
;; guix build -L FILE-DIR PACKAGE-NAME

;; Definition of the module containing the package(s)
(define-module
 (my-packages my-first-module) ;; Add 'my-packages' avoid modules name conflict
 ;;#:use-module (guix)
 #:use-module (guix build-system gnu)
 #:use-module (guix download)
 ;,#:use-module (guix git)
 ;;#:use-module (guix git-download)
 #:use-module (guix licenses)
 #:use-module (guix packages)
 ;;#:use-module (guix utils)
)

;; Definition of the package
(define-public my-hello-avanced ;; Definition of public variable which get the value of the package returned by its definition below
 (package
  (name "my-hello-avanced")
  ;;(version "2.12.1")
  (version "2.10") ;; For test to auto upgrade package definition
  (source
   (origin
    (method url-fetch)
    (uri (string-append "mirror://gnu/hello/hello-" version ".tar.gz"))
    (sha256
     ;;(base32 "086vqwk2wl8zfs47sq2xpjc9k066ilmb8z6dn0q6ymwjzlm196cd") ;; v2.12.1
     (base32 "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i") ;; v2.10
    )
   )
  )
  (build-system gnu-build-system)
  (synopsis "Hello, Guix world: An example custom Guix package")
  (description "GNU Hello prints the message \"Hello, world!\" and then exits.  It serves as an example of standard GNU coding practices.  As such, it supports command-line arguments, multiple languages, and so on.")
  (home-page "https://www.gnu.org/software/hello/")
  (license gpl3+)
 )
)


;; my-hello-avanced ;; Uncomment this line to be able to install the package 'my-hello-avanced' with the command 'guix package -f PATH/TO/my-hello-avanced.scm'
