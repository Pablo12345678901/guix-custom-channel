(define-module (my-packages my-opencv)
  #:use-module (gnu packages image-processing) ; for 'opencv' package
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg) ; for 'xorg-server-for-tests'
  #:use-module (guix git-download) ; for 'git-fetch' procedure
  #:use-module (guix packages) ; for 'package' procedure
 )

(define-public my-opencv
  (package
    (inherit opencv)
    ;; Renamed to differenciate between the Guix and my custom package.
    (name "my-opencv")
    ; Updated the version.
    (version "4.9.0") ; Latest available on the 240317
    ; Modified the hash below with the one corresponding to the new version.
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/opencv/opencv")
                    (commit version)))
              (file-name (git-file-name "opencv" version))
              (modules '((guix build utils)))
              (snippet
               '(begin
                  ;; Remove external libraries.  Almost all of them are
                  ;; available in Guix.
                  (with-directory-excursion "3rdparty"
                    (for-each delete-file-recursively
                              '("carotene"
                                "cpufeatures"
                                "flatbuffers"
                                "ffmpeg"
                                "include"
                                "ippicv"
                                "ittnotify"
                                "libjasper"
                                "libjpeg"
                                "libjpeg-turbo"
                                "libpng"
                                ;"libtengine" ; Removed from this 'remove-list' because cause error 'no such file'.
                                "libtiff"
                                "libwebp"
                                "openexr"
                                "openjpeg"
                                "openvx"
                                "protobuf"
                                ;;"quirc"
                                "tbb"
                                "zlib")))

                  ;; Delete any bundled .jar files.
                  (for-each delete-file (find-files "." "\\.jar$"))))
              (sha256
               (base32
                "1s3d2bzf74biz18flb33533dfx3j31305ddh4gzgvg55hpr1zp55"))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; Copied native inputs in order to build them against updated version
    ; Only for the native-inputs that are built depending on the version - it does not affect the others that are built against a commit hash.
    ; So only for : 'opencv_extra' and 'opencv_contrib'
    (native-inputs
     `(("pkg-config" ,pkg-config)
       ("xorg-server" ,xorg-server-for-tests) ;For running the tests
       ;; These are files that are derived from the binary descriptors that
       ;; are part of the BinBoost package.  The BinBoost package is released
       ;; under GPLv2+.  See
       ;; https://www.epfl.ch/labs/cvlab/research/descriptors-and-keypoints/research-detect-binboost/
       ;; See xfeatures2d/cmake/download_boostdesc.cmake for commit hash.
       ("opencv-3rdparty-boost"
        ,(let ((commit "34e4206aef44d50e6bbcd0ab06354b52e7466d26"))
           (origin
             (method git-fetch)
             (uri (git-reference (url "https://github.com/opencv/opencv_3rdparty")
                                 (commit commit)))
             (file-name (git-file-name "opencv_3rdparty" commit))
             (sha256
              (base32
               "13yig1xhvgghvxspxmdidss5lqiikpjr0ddm83jsi0k85j92sn62")))))
       ;; These are the Visual Geometry Group descriptors, released under
       ;; BSD-3.  They are generated files produced by the DLCO framework.
       ;; See xfeatures2d/cmake/download_vgg.cmake for commit hash.
       ("opencv-3rdparty-vgg"
        ,(let ((commit "fccf7cd6a4b12079f73bbfb21745f9babcd4eb1d"))
           (origin
             (method git-fetch)
             (uri (git-reference (url "https://github.com/opencv/opencv_3rdparty")
                                 (commit commit)))
             (file-name (git-file-name "opencv_3rdparty" commit))
             (sha256
              (base32
               "0r9fam8dplyqqsd3qgpnnfgf9l7lj44di19rxwbm8mxiw0rlcdvy")))))
       ("opencv-extra"
        ,(origin
           (method git-fetch)
           (uri (git-reference
                 (url "https://github.com/opencv/opencv_extra")
                 (commit version)))
           (file-name (git-file-name "opencv_extra" version))
           (sha256
            (base32
             "1x095sgc0fkl8zzpxlswpnmxkf80cvzab1ddcq792dys5qm2s1x4"))))
       ("opencv-contrib"
        ,(origin
           (method git-fetch)
           (uri (git-reference (url "https://github.com/opencv/opencv_contrib")
                               (commit version)))
           (file-name (git-file-name "opencv_contrib" version))
           (sha256
            (base32
             "17xrvzllbcrprxn6c0g4x25i2wa7yqa0ycv177wah3if9s30dgib"))))))
    ))

my-opencv ;; Uncomment this line during tests. Re-comment after.
