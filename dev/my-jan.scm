(define-module (my-packages my-jan)
  #:use-module (guix build-system node)
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

#!
;; ERROR MESSAGE :
npm ERR! code EUNSUPPORTEDPROTOCOL
npm ERR! Unsupported URL Type "link:": link:./core
!#

(define-public my-jan
  (package
    (name "my-jan")
    (version "0.4.9") ;; Latest available on the 240320
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/janhq/jan")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0ip5n14i82nns8rlddhw3j7safn29mbw9kqzi3ak08j2g5zjax46"))))
    (build-system node-build-system)
    (arguments '())
    (home-page "https://jan.ai/")
    (synopsis "Jan is an open-source ChatGPT alternative that runs 100% offline on your computer.")
    (description "Jan is an open-source ChatGPT alternative that runs 100% offline on your computer.")
    (license license:agpl3)))

my-jan ;; Uncomment this line while developping / Re-comment it after.
