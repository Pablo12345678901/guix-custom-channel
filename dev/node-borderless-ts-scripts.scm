(define-module (my-packages node-bitwarden-cli)
  #:use-module (gnu packages node-xyz)
  #:use-module (gnu packages version-control) ; for 'git' package
  #:use-module (guix build-system node)
  #:use-module (guix download) ; for 'url-fetch'
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download) ; for 'git-fetch'
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; WARNING : THIS IS THE MERE DEFINITION  ;;;;;;;;;;
;;; ALL THE INPUTS DEFINITION ARE MISSING ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-public node-borderless-ts-scripts
  (package
   (name "node-borderless-ts-scripts")
   (version "0.15.0")
   (source
    (origin
     (method url-fetch)
     (uri
      "https://registry.npmjs.org/@borderless/ts-scripts/-/ts-scripts-0.15.0.tgz")
     (sha256
      (base32 "0d3b7y16rkhmwfhmx0czvvnqig157686qzhaznxz93yfh7zg4fbv"))))
   (build-system node-build-system)
   (arguments
    (list
     #:tests? #f
     #:phases #~(modify-phases %standard-phases
			       (delete 'build)
			       (add-after 'patch-dependencies 'delete-dev-dependencies
					  (lambda _
					    (delete-dependencies '("@types/node"
								   "@vitest/coverage-v8"
								   "bun-types" "tsx" "typescript"
								   "vitest")))))))
   (inputs (list node-zod			  ;-3.22.4
                 node-rimraf			  ;-5.0.5
                 node-prettier-plugin-packagejson ;-2.4.14
                 node-prettier			  ;-3.2.5
                 node-pkg-conf			  ;-4.0.0
                 node-lint-staged		  ;-15.2.2
                 node-husky			  ;-8.0.3
                 node-find-up			  ;-6.3.0
                 node-ci-info			  ;-3.9.0
                 node-arg			  ;-5.0.2
                 node-typescript		  ;-5.4.4
		 ))
   (home-page "https://github.com/borderless/ts-scripts")
   (synopsis
    "Simple, mostly opinionated, scripts to build TypeScript modules")
   (description
    "Simple, mostly opinionated, scripts to build TypeScript modules")
   (license license:expat)))

node-borderless-ts-scripts ; During development and build tests.
