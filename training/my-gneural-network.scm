(define-module (my-packages my-gneural-network)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download) ; for 'git-fetch' procedure
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' procedure 
)

;; At each commit, adust the commit and the hash below in order to download and build updated package.
(define-public my-gneural-network
  (let ((revision "1")
    (commit "232786c69cd47b24d8ce6afcdd1441acd4607a64")) ; As of 240314
  (package
    (name "my-gneural-network")
    (version "0.9.1")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://github.com/Pablo12345678901/gneural_network")
	    (commit commit)))
       (sha256
        (base32 "1qzx2wvvsvzh3j5cb5k33pwz9g8kmfwgsri5dqgvw6cymfgaf9vn"))
       (file-name (git-file-name name version))))
    (build-system gnu-build-system)
    (arguments '())
    (inputs '())
    (native-inputs '())
    (propagated-inputs '())
    (synopsis "Gneural Network is the GNU package which implements a programmable neural network.")
    (description "Gneural Network is the GNU package which implements a programmable neural network.")
    (home-page "https://www.gnu.org/software/gneuralnetwork/")
    (license license:gpl3))))

;;my-gneural-network ; Uncomment this line during development tests. Comment it when finished.
