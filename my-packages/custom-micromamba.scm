(define-module (my-packages custom-micromamba)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix licenses))

(define custom-micromamba
 (let
   ((commit "946ea168f610f3d8f7cdb25c12561ba286a59d75")  
   (revision "1"))
  (package
   (name "custom-micromamba")
   (version (git-version "1.5.6-0" revision commit))

   ;; SOURCE
   (source
    (origin
     (method git-fetch) ;; git-fetch expects url + commit
     (uri
      (git-reference
       (url "https://github.com/mamba-org/micromamba-releases/")
       (commit commit)))
     (file-name (git-file-name name version)) ;; ensure that the source code from the Git repository is stored in a directory with a descriptive name - example : libgit2-version
     (sha256 (base32 "0iyl0cicqry5nkxbdac2gjqy28rnigz0n6vp1s43sv6mwcxy4g3y"))
        ;; obtained with :
#!
	;; git clone BASE_REPO_WITHOUT_DOT_GIT
	;; cd REPO
	;; git checkout VERSION ;; Change the branch to the required one. It can be on format 'vVERSION' or just 'VERSION' depending on the package.
	;; guix hash -rx .     ;; Get the hash without including the '.git*' dirs.
!#
     
     ;; SNIPPETS
     ;; No snippets here.
     ;; (snippet '(HERE))))
     )) ;; 'source' end

     ;; OUTPUTS
     ;; No outputs here.

     ;; INPUTS
     ;; No inputs here.
     ;; 'inputs' : Installed in the store but not in the profile, as well as being present at build time.
     ;;(inputs (list HERE HERE HERE))
     ;; 'native-inputs' are required for build but not for runtime -  installing a package through a substitute won’t install these inputs (it will only install the 'inputs' and 'propagated-inputs').
     ;;(native-inputs (list HERE HERE HERE))
     ;; 'propagated-inputs' : Installed in the store and in the profile, as well as being present at build time.
     ;;(propagated-inputs (list HERE HERE HERE)) ;;

    ;; BUILD SYSTEM ARGUMENTS
    (build-system python-build-system)
    (arguments
     ;;`(#:tests? #true
     ;; #:configure-flags '("FLAGS_HERE")
     ;; #:make-flags '("FLAGS_HERE")
     
     ;; BUILD PHASES
     `(#:phases
       (modify-phases %standard-phases))
     #:python ,python-3); Use the Python version provided by Guix

    ;; COMMON PACKAGE INFO
    (home-page "https://github.com/mamba-org/micromamba-releases")
    (synopsis "A small installer for conda packages")
    (description "Micromamba is a standalone installer for conda packages.")
    (license license:asl2.0))))
