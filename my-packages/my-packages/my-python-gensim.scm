(define-module (my-packages my-python-gensim)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages python-science) ;; for python-scipy
  #:use-module (gnu packages python-web) ;; for python-smart-open
  #:use-module (gnu packages python-xyz) ;; for python-numpy
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

(define-public my-python-gensim
  (package
   (name "my-python-gensim")
    (version "4.3.2")
    (source
     (origin
      (method url-fetch)
      (uri (pypi-uri "gensim" version))
      (sha256
        (base32
         "1aq8nghmxsj3schg22mmkzaq8hxzxj99zvam07kq41nlzzv6mb4r")))) ;; Obtained from the pypi website -> download source file -> guix hash FILENAMEDOWNLOADED
    
    (build-system python-build-system)
    
    (arguments '(#:tests? #f)) ;; No tests available
    (propagated-inputs (list python-numpy python-scipy python-smart-open)) ;; Just for build time.
    
    (home-page "https://github.com/piskvorky/gensim")
    (synopsis "My python-gensim package defined in my custom channel.")
    (description "Gensim is a Python library for topic modelling, document indexing and similarity retrieval with large corpora. Target audience is the natural language processing (NLP) and information retrieval (IR) community.")
    (license license:lgpl2.1)
))
