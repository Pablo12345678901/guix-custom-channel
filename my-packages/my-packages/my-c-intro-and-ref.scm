(define-module (my-packages my-c-intro-and-ref)
  #:use-module (gnu packages autotools) ; For 'autoconf', 'automake'
  #:use-module (gnu packages version-control) ; For 'git'
  #:use-module (gnu packages texinfo) ; For 'texinfo' (contains 'makeinfo')
  #:use-module (gnu packages texlive) ; For 'texlive' (TeX)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

(define-public my-c-intro-and-ref
  (let ((revision "1")
   (commit "61fc722320445b4ab56e90bf0964b8a21c1cfa3a")) ; As of 240331
  (package
    (name "my-c-intro-and-ref")
    (version "0.0-git") ;; As of 240331
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://git.savannah.gnu.org/git/c-intro-and-ref")
	    (commit commit)))
      (file-name (git-file-name name version))
       (sha256
        (base32
         "0vdqq3wc749nm7iycakqsy425sg2gmr1wq78ay2ijxjh8wgxlmh5"))))
    (build-system gnu-build-system)
    (arguments '())
    (inputs
     (list
      autoconf
      automake
      texinfo
      texlive
      ))
    (native-inputs '())
    (propagated-inputs '())
    (synopsis "This manual explains the C language for use with the GNU Compiler Collection (GCC) on the GNU/Linux system and other systems.")
     (description "This manual explains the C language for use with the GNU Compiler Collection (GCC) on the GNU/Linux system and other systems.")
    (home-page "https://savannah.gnu.org/projects/c-intro-and-ref/")
    (license license:fdl1.3+))))

;;my-c-intro-and-ref ;; Uncomment this line during development tests. Comment it when finished.

