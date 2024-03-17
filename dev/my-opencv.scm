(define-module (my-packages my-opencv)
  #:use-module (gnu packages image-processing) ; for 'opencv' package
  #:use-module (guix download)
  #:use-module (guix build utils) ; TEST
  #:use-module (guix gexp) ; TEST
  #:use-module (guix git-download) ; for 'git-fetch' procedure
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils) ; TEST
 )

(define-public my-opencv
  (package
    (inherit opencv)
    (version "4.9.0") ; Latest available on the 240317
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
                "1s3d2bzf74biz18flb33533dfx3j31305ddh4gzgvg55hpr1zp55"))))))

my-opencv ;; Uncomment this line during tests. Re-comment after.
