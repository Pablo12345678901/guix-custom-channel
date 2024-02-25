;;(define-module (gnu packages version-control)
(define-module (my-packages complex-module)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages web))

(define-public custom-complex-libgit2
 (let
   ((commit "e98d0a37c93574d2c6107bf7f31140b548c6a7bf")
   ;;((commit "99018a0f35e7a85001626d7038185cbdec712192") ;; latest on the 24.02.24 20:40   
   (revision "1"))
  (package
   (name "custom-complex-libgit2")
   (version (git-version "0.26.6" revision commit))
   ;;(version (git-version "1.7.2" revision commit)) ;; latest on the 24.02.24

   ;; SOURCE
   (source
    (origin
     (method git-fetch) ;; git-fetch expects url + commit
     (uri
      (git-reference
       (url "https://github.com/libgit2/libgit2/")
       (commit commit)))
     (file-name (git-file-name name version)) ;; ensure that the source code from the Git repository is stored in a directory with a descriptive name - example : libgit2-version
     (sha256 (base32 "17pjvprmdrx4h6bb1hhc98w9qi6ki7yl57f090n9kbhswxqfs7s3"))
     ;; (sha256 (base32 "0i95jwrwx4svh5l4dpa5r4a99f813hlm7nzzkbqzmnw4pkyxhlvx")) ;; for v1.7.2 obtained with :
#!
	;; git clone https://github.com/libgit2/libgit2/
	;; cd libgit2
	;; git checkout v1.7.2
	;; guix hash -rx .     
!#
     ;;
     (patches (search-patches "libgit2-mtime-0.patch"))
     (modules '((guix build utils)))
     
     ;; SNIPPETS
     ;; The below snippet is quoted (i.e non-evaluated) - it is an alternative to the '.patch' files and the code will be evaluated ONLY when passed to the guix daemon for building.
     (snippet '(delete-file-recursively "deps")))) ;; Remove bundled software.

   ;; OUTPUTS
   ;; Each output is a directory in the /gnu/store.
   (outputs '("out" "debug")) ;; "out" is the complete package

   ;; BUILD SYSTEM ARGUMENTS
   (build-system cmake-build-system)
   ;; 'arguments' : keyword-value list used to configure the build process.
   (arguments
    `(#:tests? #true                         ;; Able/disable the test suite when building the package. Default to true.

      ;; Reminder : usually, a package is build with :
      ;; ./configure && make && make install' - for more details see : https://stackoverflow.com/questions/10961439/why-always-configure-make-make-install-as-3-separate-steps
      
      #:configure-flags '("-DUSE_SHA1DC=ON") ;; Set the flag for './configure'
      ;; Here : SHA-1 collision detection
      
      ;; #:make-flags ;; Set the flag for 'make'. Here, no flag is specified.

      ;; BUILD PHASES
      #:phases ;; List the sequential steps of the build system
      ;; Typically phases include unpack, configure, build, install and check.
      ;; To know more about those phases, you need to work out the appropriate build system definition in ‘$GUIX_CHECKOUT/guix/build/gnu-build-system.scm’
      (modify-phases %standard-phases ;; Customize the standard-phases
#!
      ;; Those are the available macro :
      ;; (add-before phase new-phase procedure): Run procedure named new-phase before phase.
      ;; (add-after phase new-phase procedure): Same, but afterwards.
      ;; (replace phase procedure)
      ;; (delete phase)

      ;; The 'procedures' support the keywords arguments 'inputs' and 'outputs' - see cookbook for examples.
      ;; The procedure must return #true on success.
!#
       
       (add-after 'unpack 'fix-hardcoded-paths
        (lambda _
  	 (substitute* "tests/repo/init.c" (("#!/bin/sh") (string-append "#!" (which "sh")))) ;; substitute* = sed-like function       
         (substitute* "tests/clar/fs.h" (("/bin/cp") (which "cp")) (("/bin/rm") (which "rm")))))

       ;; Run checks more verbosely.
       (replace 'check
        (lambda*
	 (#:key tests? #:allow-other-keys)
         (when tests? (invoke "./libgit2_clar" "-v" "-Q"))))
       
       (add-after 'unpack 'make-files-writable-for-tests
		  (lambda _ (for-each make-file-writable (find-files ".")))))))

   ;; INPUTS
   ;; 'inputs' : Installed in the store but not in the profile, as well as being present at build time.
   (inputs (list libssh2 http-parser python-wrapper))
   ;; 'native-inputs' are required for build but not for runtime -  installing a package through a substitute won’t install these inputs (it will only install the 'inputs' and 'propagated-inputs').
   (native-inputs (list pkg-config))
   ;; 'propagated-inputs' : Installed in the store and in the profile, as well as being present at build time.
   (propagated-inputs (list openssl zlib)) ;; These two libraries are in 'Requires.private' in libgit2.pc.

   ;; COMMON PACKAGE INFO
   (home-page "https://libgit2.github.com/")
   (synopsis "Library providing Git core methods")
   (description "Libgit2 is a portable, pure C implementation of the Git core methods provided as a re-entrant linkable library with a solid API, allowing you to write native speed custom Git applications in any language with bindings.")
   (license license:gpl2)))) ;; GPLv2 with linking exception - to avoid names conflict with eventual packages named the same way as the licence
