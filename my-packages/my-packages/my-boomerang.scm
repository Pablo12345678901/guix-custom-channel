(define-module (my-packages my-boomerang)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download) ; for 'git-fetch' procedure
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
  #:use-module (gnu packages bison)
  #:use-module (gnu packages ccache)
  #:use-module (gnu packages documentation) ; for 'doxygen'
  #:use-module (gnu packages engineering) ; for 'capstone'
  #:use-module (gnu packages flex) 
  #:use-module (gnu packages lxqt) ; for 'libqtxdg' -> 'libqt'
  #:use-module (gnu packages python) 
)

(define-public my-boomerang
  (let ((revision "1")
    (commit "411041305f90d1d7c994f67255b5c03ea8666e60"))
  (package
    (name "my-boomerang")
    (version "0.5.2")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://github.com/BoomerangDecompiler/boomerang")
	    (commit commit)))
       (sha256
        (base32
         "0rvya525fx55k5hb7vgdwc71mqyf8mqiyglba88vqrx78945prdd"))
       (file-name (git-file-name name version))))
    (build-system cmake-build-system)
    (arguments
     `(#:configure-flags
       (list (string-append "-DCCACHE_DIR=" (assoc-ref %build-inputs "ccache")))
       #:phases
       (modify-phases %standard-phases
	  (add-after 'unpack 'set-ccache-directory
	     (lambda* (#:key outputs #:allow-other-keys)
	       (let ((ccache-dir (string-append (assoc-ref outputs "out") "/.ccache")))
		 (mkdir-p ccache-dir)
		 (setenv "CCACHE_DIR" ccache-dir))))
	  (delete 'check)))) ; No tests available for this package
    (inputs
     (list
      bison
      ccache ; optional, for recompilation speed
      capstone
      doxygen ; optional, for documentation
      flex
      libqtxdg
      python-minimal
      ))
    (synopsis "This project is an attempt to develop a real decompiler for machine code programs through the open source community.")
    (description "This project is an attempt to develop a real decompiler for machine code programs through the open source community. A decompiler takes as input an executable file, and attempts to create a high level, compilable, possibly even maintainable source file that does the same thing. It is therefore the opposite of a compiler, which takes a source file and makes an executable. However, a general decompiler does not attempt to reverse every action of the decompiler, rather it transforms the input program repeatedly until the result is high level source code. It therefore won't recreate the original source file; probably nothing like it. It does not matter if the executable file has symbols or not, or was compiled from any particular language. (However, declarative languages like ML are not considered.)")
    (home-page "https://boomerang.sourceforge.net/")
    ;; The real license should be a combination of GPL and BSD-like licenses.
    ;;"The overall effect is that some parts of the source code are released under the BSD-like license, others under the GPL, and the overall product is bound by the combination of the requirements of the two licences."
    (license license:gpl3)))) 

;;my-boomerang ;; Development purpose

