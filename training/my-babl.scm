;; Not using this package, just debugged it for the fun !
(define-module (my-packages my-babl)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages)
  #:use-module (gnu packages ghostscript) ;; for 'lcms'
  #:use-module (gnu packages glib) ;; for 'gobject-introspection'
  #:use-module (gnu packages gnome) ;; for 'vala'
  #:use-module (gnu packages pkg-config) ;; for 'pkg-config'
  )

(define-public my-babl
  (package
    (name "my-babl")
    (version "0.1.108")
    (source (origin
              (method url-fetch)
              (uri (list (string-append "https://download.gimp.org/pub/babl/"
                                        (version-major+minor version)
                                        "/babl-" version ".tar.xz")
                         (string-append "https://ftp.gtk.org/pub/babl/"
                                        (version-major+minor version)
                                        "/babl-" version ".tar.xz")
                         (string-append "ftp://ftp.gtk.org/pub/babl/"
                                        (version-major+minor version)
                                        "/babl-" version ".tar.xz")))
              (sha256
               (base32
                "0x8lxvnhfpssj84x47y3y06vsvhd5afb9jknw38c8ymbxafzxpi6"))))
    (build-system meson-build-system)
    (arguments
     `(#:configure-flags
       (list "-Dwith-docs=false")
       #:phases
       (modify-phases %standard-phases
         ;; Adding a custom phase because else pkgconfig from other packages with inputs = babl does not find the 'babl.pc' file and exit with error.
                  (add-after 'install 'symlink-to-pkgconfig-file
                    (lambda* (#:key outputs #:allow-other-keys)
                   ;;(lambda* (#:key inputs #:allow-other-keys)
                      (let* (
                            ;;(out (assoc-ref outputs "out"))
                          (output-directory (assoc-ref outputs "out"))
                            (lib-pkg-config (string-append output-directory "/lib/pkgconfig/")))
                       (symlink
                        (string-append lib-pkg-config "babl-0.1.pc")
                        (string-append lib-pkg-config "babl.pc")))))
        )))
    (native-inputs
     (list gobject-introspection
           pkg-config
           vala))
    (propagated-inputs
     ;; Propagated to satisfy ‘babl.pc’.
     (list lcms))
    (home-page "https://gegl.org/babl/")
    (synopsis "Image pixel format conversion library")
    (description
     "Babl is a dynamic, any-to-any pixel format translation library.
It allows converting between different methods of storing pixels, known as
@dfn{pixel formats}, that have different bit depths and other data
representations, color models, and component permutations.

A vocabulary to formulate new pixel formats from existing primitives is
provided, as well as a framework to add new color models and data types.")
    (license license:lgpl3+)))
