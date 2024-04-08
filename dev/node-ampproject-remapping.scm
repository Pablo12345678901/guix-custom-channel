(define-module (my-packages node-ampproject-remapping)
  #:use-module (gnu packages node-xyz)
  #:use-module (gnu packages version-control) ; for 'git' package
  #:use-module (guix build-system node)
  #:use-module (guix download) ; for 'url-fetch'
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download) ; for 'git-fetch'
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)


(define-public node-jridgewell-set-array
  (package
   (name "node-jridgewell-set-array")
   (version "1.2.1")
   (source
    (origin
     (method url-fetch)
     (uri
      "https://registry.npmjs.org/@jridgewell/set-array/-/set-array-1.2.1.tgz")
     (sha256
      (base32 "0j06py03ffln44c31vcpgzdik0s7lln2fliix6rpyw5cw5yj78kg"))))
   (build-system node-build-system)
   (arguments
    (list
     #:tests? #f
     #:phases #~(modify-phases %standard-phases
			       (delete 'build)
			       (add-after 'patch-dependencies 'delete-dev-dependencies
					  (lambda _
					    (delete-dependencies '("@rollup/plugin-typescript"
								   "@types/mocha"
								   "@types/node"
								   "@typescript-eslint/eslint-plugin"
								   "@typescript-eslint/parser"
								   "c8"
								   "eslint"
								   "eslint-config-prettier"
								   "mocha"
								   "npm-run-all"
								   "prettier"
								   "rollup"
								   "tsx"
								   "typescript")))))))
   (home-page "https://github.com/jridgewell/set-array#readme")
   (synopsis
    "Like a Set, but provides the index of the `key` in the backing array")
   (description
    "Like a Set, but provides the index of the `key` in the backing array")
   (license license:expat)))

(define-public node-jridgewell-gen-mapping
  (package
    (name "node-jridgewell-gen-mapping")
    (version "0.3.5")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/gen-mapping/-/gen-mapping-0.3.5.tgz")
       (sha256
        (base32 "0sqci882wwbchpx06dv21lxd3q7s9sxc8qip9c64iy1mxs46mi15"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("@rollup/plugin-typescript"
                                              "@types/mocha"
                                              "@types/node"
                                              "@typescript-eslint/eslint-plugin"
                                              "@typescript-eslint/parser"
                                              "benchmark"
                                              "c8"
                                              "eslint"
                                              "eslint-config-prettier"
                                              "mocha"
                                              "npm-run-all"
                                              "prettier"
                                              "rollup"
                                              "tsx"
                                              "typescript")))))))
    (inputs (list node-jridgewell-trace-mapping ;-0.3.25

                  node-jridgewell-sourcemap-codec ;-1.4.15

                  node-jridgewell-set-array ;-1.2.1
))
    (home-page "https://github.com/jridgewell/gen-mapping#readme")
    (synopsis "Generate source maps")
    (description "Generate source maps")
    (license license:expat)))

(define-public node-jridgewell-resolve-uri
  (package
    (name "node-jridgewell-resolve-uri")
    (version "3.1.2")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/resolve-uri/-/resolve-uri-3.1.2.tgz")
       (sha256
        (base32 "0c72fqvljvr28rdmg6hjd8zc63vm00r9xlrx6l9spfjq4pvgjlnv"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("@jridgewell/resolve-uri-latest"
                                              "@rollup/plugin-typescript"
                                              "@typescript-eslint/eslint-plugin"
                                              "@typescript-eslint/parser"
                                              "c8"
                                              "eslint"
                                              "eslint-config-prettier"
                                              "mocha"
                                              "npm-run-all"
                                              "prettier"
                                              "rollup"
                                              "typescript")))))))
    (home-page "https://github.com/jridgewell/resolve-uri#readme")
    (synopsis "Resolve a URI relative to an optional base URI")
    (description "Resolve a URI relative to an optional base URI")
    (license license:expat)))

(define-public node-jridgewell-sourcemap-codec
  (package
    (name "node-jridgewell-sourcemap-codec")
    (version "1.4.15")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.4.15.tgz")
       (sha256
        (base32 "1ada9hszqx7aiv2l0sb1lxpkf860czjplxpnc0ybfs934b74jndg"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("@rollup/plugin-typescript"
                                              "@types/node"
                                              "@typescript-eslint/eslint-plugin"
                                              "@typescript-eslint/parser"
                                              "benchmark"
                                              "c8"
                                              "eslint"
                                              "eslint-config-prettier"
                                              "mocha"
                                              "npm-run-all"
                                              "prettier"
                                              "rollup"
                                              "source-map"
                                              "source-map-js"
                                              "sourcemap-codec"
                                              "typescript")))))))
    (home-page "https://github.com/jridgewell/sourcemap-codec#readme")
    (synopsis "Encode/decode sourcemap mappings")
    (description "Encode/decode sourcemap mappings")
    (license license:expat)))

(define-public node-jridgewell-trace-mapping
  (package
    (name "node-jridgewell-trace-mapping")
    (version "0.3.25")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@jridgewell/trace-mapping/-/trace-mapping-0.3.25.tgz")
       (sha256
        (base32 "1va189bi3as5qpm6xk2l1yw5fyw9rb1bgmjqyqka5zqc98lrvw7z"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("@rollup/plugin-typescript"
                                              "@types/mocha"
                                              "@types/node"
                                              "@typescript-eslint/eslint-plugin"
                                              "@typescript-eslint/parser"
                                              "benchmark"
                                              "c8"
                                              "esbuild"
                                              "eslint"
                                              "eslint-config-prettier"
                                              "eslint-plugin-no-only-tests"
                                              "mocha"
                                              "npm-run-all"
                                              "prettier"
                                              "rollup"
                                              "tsx"
                                              "typescript")))))))
    (inputs (list node-jridgewell-sourcemap-codec ;-1.4.15

                  node-jridgewell-resolve-uri ;-3.1.2
))
    (home-page "https://github.com/jridgewell/trace-mapping#readme")
    (synopsis "Trace the original position through a source map")
    (description "Trace the original position through a source map")
    (license license:expat)))

(define-public node-ampproject-remapping
  (package
    (name "node-ampproject-remapping")
    (version "2.3.0")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/@ampproject/remapping/-/remapping-2.3.0.tgz")
       (sha256
        (base32 "0s6kpwcaxxrp6snyh7ydyiv3q6d3rdir91fxhfy5lv3510h73gzq"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("@rollup/plugin-typescript"
                                              "@types/jest"
                                              "@typescript-eslint/eslint-plugin"
                                              "@typescript-eslint/parser"
                                              "eslint"
                                              "eslint-config-prettier"
                                              "jest"
                                              "jest-config"
                                              "npm-run-all"
                                              "prettier"
                                              "rollup"
                                              "ts-jest"
                                              "tslib"
                                              "typescript")))))))
    (inputs (list node-jridgewell-trace-mapping ;-0.3.25

                  node-jridgewell-gen-mapping ;-0.3.5
))
    (home-page "https://github.com/ampproject/remapping#readme")
    (synopsis
     "Remap sequential sourcemaps through transformations to point at the original source code")
    (description
     "Remap sequential sourcemaps through transformations to point at the original source code")
    (license license:asl2.0)))

node-ampproject-remapping ; During development and build tests.
