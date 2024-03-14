(define-module (my-packages my-gneural-network)
  #:use-module (guix build-system gnu)
  #:use-module (guix download) ; for the procedure 'url-fetch'
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition 
)
 		 
(define-public my-gneural-network
  (package
    (name "my-gneural-network")
    (version "0.9.1")
    (source
     (origin
      (method url-fetch)
      ; The package is not maintained anymore so cannot git download it.
       (uri (string-append
	     "https://cvs.savannah.gnu.org/viewvc/*checkout*/gneuralnetwork/gneuralnetwork/gneural_network-0.9.1.tar.gz"))
       (sha256
        (base32
         "1qj3z1c4c88c9jq3sxrkhmgj4mpvzysllgakqimw9lfzv1dwj2yn"))
       ))
    
    (build-system gnu-build-system)
    (arguments '())
    (inputs '())
    (native-inputs '())
    (propagated-inputs '())
    
    (synopsis "Gneural Network is the GNU package which implements a programmable neural network.")
    (description "Gneural Network is the GNU package which implements a programmable neural network.")
    (home-page "https://www.gnu.org/software/gneuralnetwork/")
    (license license:gpl3)))


;;my-gneural-network  ;; Uncomment this line during development tests. Comment it when finished.
