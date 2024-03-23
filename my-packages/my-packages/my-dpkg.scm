(define-module (my-packages my-dpkg)
  #:use-module (gnu packages debian) ; for dpkg
  #:use-module (guix build utils)
  #:use-module (guix git-download)
  #:use-module (guix packages) 
)

(define-public my-dpkg
  (package
    (inherit dpkg)
    (name "my-dpkg")
    (version "1.22.1")
    (source
     (origin
        (method git-fetch)
        (uri (git-reference
               (url "https://git.dpkg.org/git/dpkg/dpkg")
               (commit version)))
        (file-name (git-file-name name version))
        (sha256
         (base32 "1s6dzcczmpkr9pla25idymfdjz10gck0kphpp0vqbp92vmfskipg"))))

))

;;my-dpkg ;; Uncomment this line while developping / Re-comment it after.
