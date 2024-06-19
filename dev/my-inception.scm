(define-module (my-packages my-inception)
  #:use-module (gnu packages libusb) ; for python-pyusb
  #:use-module (gnu packages python-build) ; for python-wheel
  #:use-module (gnu packages python-xyz) ; for python-msgpack
  #:use-module (gnu packages serialization) ; for msgpack
  #:use-module (guix build-system python)
  #:use-module (guix git-download)
  #:use-module (guix gexp) ; for #~
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
  #:use-module (my-packages my-libforensic1394) ; My own definition of the library build.
)

(define-public my-inception
  (let ((revision "1")
   (commit "4df32316acd87b15a0aad34ba5737cae366b018a")) ; As of 240619
  (package
    (name "my-inception")
    (version "1.0") ;; No versioning
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://github.com/carmaa/inception")
	    (commit commit)))
      (file-name (git-file-name name version))
       (sha256
        (base32
         "0hz556xp9i0gzjy4rabv59vrmplzbngxgfqc2yg250lxpsz0bav9"))))
    (build-system python-build-system)
    (inputs
     (list
      my-libforensic1394
      python-pyusb
      python-msgpack
      python-wheel
      ))
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
           (add-before 'wrap 'patch-requirements
		(lambda* (#:key inputs #:allow-other-keys)
	     (substitute* '("setup.py")
		     (("msgpack-python")
		      "msgpack"))
		    )))))
    (synopsis "DEBUG SYNOPSIS TO DO.")
    (description "DEBUG DESCRIPTION TO DO.")
    (home-page "https://github.com/carmaa/inception/")
    ;; DEBUG no license available
    (license license:gpl3))))

my-inception ;; Development purpose

