(define-module (my-packages my-darknet)
  #:use-module (gnu packages image-processing) ; for 'opencv'
  #:use-module (gnu packages python) ; for 'python-wrapper' - needed to patch some files by cmake
  #:use-module (guix build-system cmake)
  #:use-module (guix build cmake-build-system) ; for '%standard-phases'
  #:use-module (guix build utils) ; for 'modify-phases' procedure
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download) ; for 'git-fetch' procedure
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' procedure 
)

;; At each commit, adust the commit and re-compute the hash below in order to download and build updated package.
(define-public my-darknet
  (let ((revision "1")
    (commit "9bb62860b12a55ce55ba5ce12e7a7544417940e8")) ; As of 240316
  (package
    (name "my-darknet")
    (version "v2.0-117-g9bb62860") ; Obtained with 'git describe --tags --dirty' from the git clone - has to be done manually. 
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://github.com/hank-ai/darknet")
	    (commit commit)))
       (sha256
        (base32 "1mi45qv0pbjb9aqqnb45bkp2fip0aghr1kmzhg6ypsa8a0d7dx1v"))
       (file-name (git-file-name name version))
       ))
    (build-system cmake-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
           (add-before 'configure 'miscellaneous-patches
	       (lambda* (#:key outputs #:allow-other-keys)
		(let* ((cfg-dir (string-append (assoc-ref outputs "out") "/cfg")))  
		    ;; Manually write the version of package as it is taken from the git tags that are not available during the build.
		    (substitute* '("CM_version.cmake")
		     (("EXECUTE_PROCESS.*\n$") ; Command that should get the git version. But does not work as the '.git' directory is not copied/pasted during the build.
		      (string-append "SET (DARKNET_VERSION_STRING " #+version ")\n")))
	            ;; Change the directory of installation of 'cfg' files as '/opt/...' path is not available on Guix.    
		    (substitute* '("cfg/CMakeLists.txt")
				 (("\\/opt\\/darknet\\/cfg\\/") cfg-dir)))))
	   ;; Copy the 'cfg' and 'artwork' directories content within the package directory.
	   (add-before 'configure 'copy-some-dirs
	       (lambda* (#:key outputs #:allow-other-keys)
			(let* ((old-artwork-dir "artwork/")
			       (new-artwork-dir (string-append (assoc-ref outputs "out") "/artwork"))
			       (old-cfg-dir "cfg/")
		               (new-cfg-dir (string-append (assoc-ref outputs "out") "/cfg")))
		      (mkdir-p new-artwork-dir)
		      (copy-recursively old-artwork-dir new-artwork-dir)
		      (mkdir-p new-cfg-dir)
		      (copy-recursively old-cfg-dir new-cfg-dir))))
	   ;; Copy the cpp files within the package directory because they are required for the library on the which is based the binary.
	   (add-before 'build 'copy-cpp-files
	       (lambda* (#:key outputs #:allow-other-keys)
		(let* ((old-cpp-dir "../source/src-lib/")
		   (new-cpp-dir (string-append (assoc-ref outputs "out") "/src-lib/")))
		      (mkdir-p new-cpp-dir)
		      (copy-recursively old-cpp-dir new-cpp-dir))))
	   ;; Adapt the CMakeLists of the src-lib directory to reflect the change of path for those 'cpp' files.
	   (add-after 'copy-cpp-files 'patch-cmakelists-file
	       (lambda* (#:key outputs #:allow-other-keys)
		(let* ((new-cpp-dir (string-append (assoc-ref outputs "out") "/src-lib")))
		  (substitute* '("../source/src-lib/CMakeLists.txt")
		  (("FILE \\(GLOB LIBSRC \\*\\.cpp\\)")
		   (string-append "FILE (GLOB LIBSRC " new-cpp-dir "/*.cpp)"))))))		      
	   ;; No tests available for this package.
	   (delete 'check)
	   )))
           ; End of modifying phases
    (inputs
     (list
      opencv
      python-wrapper ; for python3 including the 'python' executable
     ))
    (native-inputs '())
    (propagated-inputs '())
    (synopsis "Darknet is an open source neural network framework written in C, C++, and CUDA. YOLO (You Only Look Once) is a state-of-the-art, real-time, object detection system, which runs in the Darknet framework.")
    (description "Darknet is an open source neural network framework written in C, C++, and CUDA. YOLO (You Only Look Once) is a state-of-the-art, real-time, object detection system, which runs in the Darknet framework.")
    (home-page "https://darknetcv.ai/")
    (license license:asl2.0))))

;;my-darknet ; Uncomment this line during development tests. Comment it when finished.

