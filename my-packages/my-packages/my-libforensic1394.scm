(define-module (my-packages my-libforensic1394)
  #:use-module (guix build-system cmake)
  #:use-module (guix gexp) ; for #~
  #:use-module (guix git-download) ; for 'git-fetch' procedure
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

; This library is required to build inception -> See https://github.com/carmaa/inception

(define-public my-libforensic1384
  (let ((revision "1")
    (commit "75a4e8c16c1f139380667eea1e20495b0e205528"))
  (package
    (name "my-libforensic1384")
    (version "1.0") ; No versioning available.
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://github.com/FreddieWitherden/libforensic1394")
	    (commit commit)))
       (sha256
        (base32
         "14z17fcbqfirf028mpx23nbvq6spk65whdr7sr8aywv5rdl7l3zx"))
       (file-name (git-file-name name version))))
    (build-system cmake-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
	   ;; No tests available for this package.
	   (delete 'check)
	   )))
    (inputs '())
    (synopsis "DEBUG SYNOPSIS TO DO.")
    (description "DEBUG DESCRIPTION TO DO.")
    (home-page "https://freddie.witherden.org/tools/libforensic1394/")
    (license license:gpl3)))) 

;;my-libforensic1394 ; For development purpose

