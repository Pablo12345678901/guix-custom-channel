;; This file does not return a package - only define it.
;; If returning a package is wished, then use 'package-name' below its definition - that way, it will call its definition which in turn will return a package.
;; Else use this file that way :
;;    -L, --load-path=DIR    prepend DIR to the package module search path
;; guix show -L FILE-DIR PACKAGE-NAME
;; guix build -L FILE-DIR PACKAGE-NAME

(define-module (my-hello-avanced)
   #:use-module (guix licenses)
   #:use-module (guix packages)
   #:use-module (guix build-system gnu)
   #:use-module (guix download))

 (define-public my-hello-avanced ;; Definition of public variable which get the value of the package returned by its definition below
   (package
     (name "my-hello-avanced")
     (version "2.12.1")
     (source (origin
	       (method url-fetch)
	       (uri (string-append "mirror://gnu/hello/hello-" version
				   ".tar.gz"))
	       (sha256
		(base32
		 "086vqwk2wl8zfs47sq2xpjc9k066ilmb8z6dn0q6ymwjzlm196cd"))))
     (build-system gnu-build-system)
     (synopsis "Hello, Guix world: An example custom Guix package")
     (description
      "GNU Hello prints the message \"Hello, world!\" and then exits.  It
 serves as an example of standard GNU coding practices.  As such, it supports
 command-line arguments, multiple languages, and so on.")
     (home-page "https://www.gnu.org/software/hello/")
     (license gpl3+))
   )


;; my-hello-avanced ;; Uncomment this line to be able to install the package 'my-hello-avanced' with the command 'guix package -f PATH/TO/my-hello-avanced.scm'
