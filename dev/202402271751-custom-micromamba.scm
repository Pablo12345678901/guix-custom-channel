(define-module (my-packages custom-micromamba)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)

  #:use-module (nonguix build-system binary) ;; Not ethical - to be changed 
 )

#!
  #:use-module (guix utils) ;; NEEDED
  #:use-module (gnu packages pkg-config) ;; NEEDED ?
  #:use-module (gnu packages python) ;; NEEDED ?
  #:use-module (gnu packages ssh) ;; NEEDED ?
  #:use-module (gnu packages tls) ;; NEEDED ?
  #:use-module (gnu packages web)) ;; NEEDED ?
!#

(define-public custom-micromamba
 (let
   ((commit "ddc7f24b92a59c1a43fe35460292beecf1c5e21d") 
   (revision "1"))
  (package
    (name "custom-micromamba")
    (version "1.5.6-0") ;; The latest available on the 27.02.24
   (source
    (origin
     (method git-fetch) ;; git-fetch expects url + commit
     (uri
      (git-reference
       (url "https://github.com/mamba-org/micromamba-releases/")
       (commit commit)))
     (file-name (git-file-name name version)) ;; ensure that the source code from the Git repository is stored in a directory with a descriptive name - example : libgit2-version
     (sha256 (base32 "1qhndblazjri3lbfimznk1fmpc5avfihdxzlmzjnmy5wx1kgar30")))) ;; Issue with hash to be rechecked after

#!
;; WORKING VERSION
;;    (source
;;     (origin
;;       (method url-fetch)
;;       (uri (string-append
;;             "https://github.com/mamba-org/micromamba-releases/releases/download/"
;;             version
;;             "/micromamba-linux-64.tar.bz2"))
;;       (sha256
;;        (base32
;;         "11k91i9b0b1whzdp0my2kh2ad6g93s38rl4as2n417x085rk3mwa"))))
!#
   
    (build-system binary-build-system) ;; Not ethical - to be changed
    (arguments
     `(#:install-plan
       `(("bin" "/")
         ("info" "/share/"))
       #:patchelf-plan
       `(("bin/micromamba" ("glibc")))
       #:phases
       (modify-phases %standard-phases
         (delete 'binary-unpack)
#!
         (replace 'unpack
           (lambda* (#:key inputs #:allow-other-keys)
		    (invoke "tar" "-xvf" (assoc-ref inputs "source"))))
!#
	 )))
    (inputs
     `(("glibc" ,glibc)))
    (native-inputs
     `(("gzip" ,gzip)))
    (synopsis "micromamba is a tiny version of the mamba package manager.")
    (description "micromamba is a tiny version of the mamba package manager. It is a statically linked C++ executable with a separate command line interface. It does not need a base environment and does not come with a default version of Python.")
    (home-page "https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html")
    (license license:bsd-3))))
