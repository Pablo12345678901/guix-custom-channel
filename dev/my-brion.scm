(define-module (my-packages my-brion)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download) ; for 'git-fetch' procedure
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' procedure 
)

;; At each commit, adust the commit and the hash below in order to download and build updated package.
(define-public my-brion
  (let ((revision "1")
    (commit "7251f13ffe4db18524df026a83f60603da43e955"))
  (package
    (name "my-brion")
    (version "3.3.14")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://github.com/BlueBrain/Brion")
	    (commit commit)))
       (sha256
        (base32 "1zhha6g7dpw059a6g14fb7gjj3libfn5avmmvp612vb0alrcrblq"))
       (file-name (git-file-name name version))))
    (build-system cmake-build-system)
    (arguments '())
    (inputs '())
    (native-inputs '())
    (propagated-inputs '())
    (synopsis "DEBUG SYNOPSIS TODO")
    (description "DEBUG DESCRIPTION TODO")
    (home-page "https://github.com/BlueBrain/Brion")
    (license license:gpl3))))

my-brion ; For dev
