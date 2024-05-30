(define-module (my-packages my-tcc)
  #:use-module (gnu packages base) ; for 'glibc'
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages texinfo) ; for 'makeinfo'
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp) ; for #~
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

;; DEBUG :
;; Facing this issue :
;; bcheck.c:740: error: '__malloc_hook<' undeclared
;; Due to remove from libc in earlier version.
;; Can be resolve by patching the C file with a redefinition - change in some part of the code.
;; or by re-building libc 

(define-public my-tcc
  (package
    (name "my-tcc")
    (version "0.9.27")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "http://download-mirror.savannah.gnu.org/releases/tinycc/tcc-" version ".tar.bz2"))
       (sha256
        (base32 "177bdhwzrnqgyrdv1dwvpd04fcxj68s5pm1dzwny6359ziway8yy"))))
    (build-system gnu-build-system)
    (inputs
     `(("glibc:debug" ,glibc)
       ("perl" ,perl)
       ("texinfo" ,texinfo)))
    (arguments
     (list
      #:phases #~(modify-phases %standard-phases
         (add-before 'build 'patch-include-lib-malloc
           (lambda* (#:key inputs #:allow-other-keys)
             (substitute* '("lib/bcheck.c")
               (("#include <string.h>") "#include <string.h>\n#include <malloc.h>\n")))))))
    (synopsis "DEBUG SYNOPSIS TO DO.")
    (description "DEBUG DESCRIPTION TO DO.")
    (home-page "https://www.bellard.org/tcc/")
    (license license:gpl3)))

my-tcc ;; Development purpose

