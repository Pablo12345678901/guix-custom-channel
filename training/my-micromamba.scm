(define-module (my-packages my-micromamba)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  
  #:use-module (nonguix build-system binary) ;; Not ethical - to be changed 
 )


(define-public my-micromamba
  (package
    (name "my-micromamba")
    (version "1.5.6-0") ;; The latest available on the 27.02.24
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/mamba-org/micromamba-releases/releases/download/"
	     version
             "/micromamba-linux-64.tar.bz2")) ;; Direct download of the binary as per the script on the git repo.
       (sha256
        (base32
         "0g33ff6knp035b893fcanihgr36lx261cyyxqwwb7s6azz3n5r7g")))) ;; hash obtained with 'guix hash FILENAME.tar.bz2')
    
    (build-system binary-build-system) ;; Not ethical - to be changed
    ;; Special git repo - contains a script to download the binary so no need to build it.
    (arguments
     `(#:install-plan
       `(("bin" "/")
         ("info" "/share/"))
       #:patchelf-plan
       `(("bin/micromamba" ("glibc")))
       #:phases
       (modify-phases %standard-phases
         (delete 'binary-unpack)
         (replace 'unpack
           (lambda* (#:key inputs #:allow-other-keys)
		    (invoke "tar" "-xvf" (assoc-ref inputs "source")))))))
    (inputs
     `(("glibc" ,glibc)))
    (native-inputs
     `(("gzip" ,gzip)))
    (synopsis "micromamba is a tiny version of the mamba package manager.")
    (description "micromamba is a tiny version of the mamba package manager. It is a statically linked C++ executable with a separate command line interface. It does not need a base environment and does not come with a default version of Python.")
    (home-page "https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html")
    (license license:bsd-3)))
