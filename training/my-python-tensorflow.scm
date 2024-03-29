(define-module (my-packages my-python-tensorflow)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages machine-learning)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (my-packages my-python-gensim) ;; From this channel
)

(define-public my-python-tensorflow
  (package
   (name "my-python-tensorflow")
    (version "2.15.0") ;; version name on pypi.org
    (source
     (origin
      (method url-fetch)
      (uri (pypi-uri "tensorflow" version))
      (sha256
        (base32
         "1aq8nghmxsj3schg22mmkzaq8hxzxj99zvam07kq41nlzzv6mb4r")))) ;; Obtained from the pypi website -> download source file -> guix hash FILENAMEDOWNLOADED

    ;; "14r5yw3q87czbp3pfyhxzfk2v5g64m6100cgh4g8mq2r6xm95cyl"
    
    (build-system python-build-system)
    
    (arguments '(#:tests? #f)) ;; No tests available
    
    (propagated-inputs
     (list
      my-python-gensim
      python-keras-preprocessing
      python-numpy
      python-opt-einsum
      python-pip
      python-requests
      python-wheel
     )) ;; For build and after build
 
    (home-page "https://github.com/tensorflow/tensorflow")
    (synopsis "Package defined in my custom channel.")
    (description "TensorFlow is an open source software library for high performance numerical computation. Its flexible architecture allows easy deployment of computation across a variety of platforms (CPUs, GPUs, TPUs), and from desktops to clusters of servers to mobile and edge devices.")
    (license license:asl2.0)
))

;;my-python-tensorflow ;; uncomment this line during test of build with 'guix build -f THISFILE
