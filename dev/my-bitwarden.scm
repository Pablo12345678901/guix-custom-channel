(define-module (my-packages my-bitwarden)  
  #:use-module (guix build-system node)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

#!
;Facing the below issue while trying to build :
starting phase `configure'
npm ERR! code ENOTCACHED
npm ERR! request to https://registry.npmjs.org/@angular-devkit%2fbuild-angular failed: cache mode is 'only-if-cached' but no cached response is available.

npm ERR! A complete log of this run can be found in: /tmp/guix-build-bitwarden-client-desktop-v2024.3.0.drv-0/npm-home-0/.npm/_logs/2024-03-20T22_15_27_868Z-debug-0.log
;
; Node.js official website
; to help understanding the way packages and dependencies are installed :
https://nodejs.org/en
!#

(define-public my-bitwarden
  (package
    (name "bitwarden-client")
    (version "desktop-v2024.3.0") ;; Latest available on the 240320
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/bitwarden/clients")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1f3p5yvw3knn5s99jlb1xb4k0i4m19gs9mnlqazjqzd7j7vl2ijw"))))
    (build-system node-build-system)
    (arguments '())
    (native-inputs '())
    (inputs '())
    (propagated-inputs '())
    (home-page "https://bitwarden.com/")
    (synopsis "Bitwarden client applications (web, browser extension, desktop, and cli)")
    (description "Bitwarden client applications (web, browser extension, desktop, and cli)")
    (license license:gpl3)))

my-bitwarden ;; Uncomment this line while developping / Re-comment it after.

