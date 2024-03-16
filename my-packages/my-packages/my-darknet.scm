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
				    (let* (
					   (cfg-dir (string-append (assoc-ref outputs "out") "/cfg"))
					   (bin-dir (string-append (assoc-ref outputs "out") "/bin"))
					   (lib-dir (string-append (assoc-ref outputs "out") "/lib"))
					  )
					      
				    ;; Manually write the version of package as it is taken from the git tags that are not available during the build.
                                    (substitute* '("CM_version.cmake")
                                     (("EXECUTE_PROCESS.*\n$") ; Command that should get the git version. But does not work as the '.git' directory is not copied/pasted during the build.
                                      (string-append "SET (DARKNET_VERSION_STRING " #+version ")\n")))
				    ;; Change the directory of installation of 'cfg' files as '/opt/...' path is not available on Guix.
				    (substitute* '("cfg/CMakeLists.txt")
						 (("\\/opt\\/darknet\\/cfg\\/") cfg-dir))

#!
;; In test				    
                                    (substitute* '("src-lib/CMakeLists.txt")
						 (("LIBRARY DESTINATION lib")
						  (string-append "LIBRARY DESTINATION " lib-dir)))
!#
#!
;; In test...
				    ;; Change the directory of installation of all binaries
				    (substitute* '("src-cli/CMakeLists.txt")
						 (("DESTINATION bin")
						  (string-append "DESTINATION " bin-dir)))
!#
		       )))
#!
;; In test...
		       (add-before 'build 'libraries-patch
				    (lambda* (#:key outputs #:allow-other-keys)
					    (let* ((lib-dir (string-append (assoc-ref outputs "out") "/lib")))
                                    (substitute* '("../build/Makefile")
                                     (("CMAKE_BINARY_DIR = .*\n$") ; Command that should get the git version. But does not work as the '.git' directory is not copied/pasted during the build.
                                      (string-append "CMAKE_BINARY_DIR = " lib-dir "\n"))))))
!#

		       ;; No tests available for this package.
		       (delete 'check)
		       )))
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

;my-darknet ; Uncomment this line during development tests. Comment it when finished.


#!
Phase build :
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/gnu/store/gl26kr5v6ch5lc3ignly61kb224drijc-cmake-minimal-3.24.2/bin/cmake
-S/tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/source ; -S <path-to-source> = Explicitly specify a source directory.
-B/tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/build ; -B <path-to-build>  = Explicitly specify a build directory.
--check-build-system CMakeFiles/Makefile.cmake 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/gnu/store/gl26kr5v6ch5lc3ignly61kb224drijc-cmake-minimal-3.24.2/bin/cmake
-E cmake_progress_start
/tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/build/CMakeFiles
/tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/build//CMakeFiles/progress.marks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cd /tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/build/src-lib &&
/gnu/store/5lqhcv91ijy82p92ac6g5xw48l0lwwz4-gcc-11.3.0/bin/c++
-DOPENMP

-I/tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/source/src-cli
-I/tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/source/src-lib

-isystem /gnu/store/0wslrcp8lnv8xc9sgczzwbm5cf7qxvpq-opencv-4.8.1/include/opencv4
-O2 -g -DNDEBUG -fPIC -fopenmp -ffp-contract=fast -mavx -mavx2 -msse3 -msse4.1 -msse4.2 -msse4a -Wall -Wextra -Wno-unused-parameter -Wno-write-strings -Wno-unused-result -Wno-missing-field-initializers -Wno-ignored-qualifiers -Wno-sign-compare -std=gnu++17 -MD

-MT src-lib/CMakeFiles/darknetobjlib.dir/Chart.cpp.o
-MF CMakeFiles/darknetobjlib.dir/Chart.cpp.o.d
-o CMakeFiles/darknetobjlib.dir/Chart.cpp.o
-c /tmp/guix-build-my-darknet-v2.0-117-g9bb62860.drv-0/source/src-lib/Chart.cpp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,
Makefile
 $(MAKE) $(MAKESILENT) -f src-lib/CMakeFiles/darknetobjlib.dir/build.make src-lib/CMakeFiles/darknetobjlib.dir/build
!#









!#
#!
(modify-phases %standard-phases
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (bin (string-append out "/bin"))
                    (lib (string-append out "/lib")))
               (copy-recursively (string-append source "/include/ableton")
                                 (string-append out "/include/ableton"))
               (install-file (string-append source "/AbletonLinkConfig.cmake")
                             lib)
               (install-file (string-append source
                                            "/cmake_include/AsioStandaloneConfig.cmake")
                             (string-append lib-cmake "/cmake_include"))
               #t))))
!#
