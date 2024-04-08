(define-module (my-packages node-koa-router)
  #:use-module (gnu packages node-xyz)
  #:use-module (gnu packages version-control) ; for 'git' package
  #:use-module (guix build-system node)
  #:use-module (guix download) ; for 'url-fetch'
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download) ; for 'git-fetch'
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

(define-public node-ms
  (package
    (name "node-ms")
    (version "2.1.2")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/ms/-/ms-2.1.2.tgz")
       (sha256
        (base32 "0j7vrqxzg2fxip3q0cws360wk3cz2nprr8zkragipziz1piscmqi"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("eslint" "expect.js" "husky"
                                              "lint-staged" "mocha")))))))
    (home-page "https://github.com/zeit/ms#readme")
    (synopsis "Tiny millisecond conversion utility")
    (description "Tiny millisecond conversion utility")
    (license license:expat)))

(define-public node-debug
  (package
    (name "node-debug")
    (version "4.3.4")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/debug/-/debug-4.3.4.tgz")
       (sha256
        (base32 "1kwbyb5m63bz8a2bvhy4gsnsma6ks5wa4w5qya6qb9ip5sdjr4h4"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("brfs" "browserify"
                                              "coveralls"
                                              "istanbul"
                                              "karma"
                                              "karma-browserify"
                                              "karma-chrome-launcher"
                                              "karma-mocha"
                                              "mocha"
                                              "mocha-lcov-reporter"
                                              "xo")))))))
    (inputs (list node-ms ;-2.1.2
		  ))
    (home-page "https://github.com/debug-js/debug#readme")
    (synopsis "Lightweight debugging utility for Node.js and the browser")
    (description "Lightweight debugging utility for Node.js and the browser")
    (license license:expat)))

(define-public node-depd
  (package
    (name "node-depd")
    (version "2.0.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/depd/-/depd-2.0.0.tgz")
       (sha256
        (base32 "19yl2piwl0ci2lvn5j5sk0z4nbldj6apsrqds3ql2d09aqh8m998"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("benchmark" "beautify-benchmark"
                                              "eslint"
                                              "eslint-config-standard"
                                              "eslint-plugin-import"
                                              "eslint-plugin-markdown"
                                              "eslint-plugin-node"
                                              "eslint-plugin-promise"
                                              "eslint-plugin-standard"
                                              "istanbul"
                                              "mocha"
                                              "safe-buffer"
                                              "uid-safe")))))))
    (home-page "https://github.com/dougwilson/nodejs-depd#readme")
    (synopsis "Deprecate all the things")
    (description "Deprecate all the things")
    (license license:expat)))

(define-public node-setprototypeof
  (package
    (name "node-setprototypeof")
    (version "1.2.0")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/setprototypeof/-/setprototypeof-1.2.0.tgz")
       (sha256
        (base32 "1qnzx8bl8h1vga28pf59mjd52wvh1hf3ma18d4zpwmijlrpcqfy8"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("mocha" "standard")))))))
    (home-page "https://github.com/wesleytodd/setprototypeof")
    (synopsis "A small polyfill for Object.setprototypeof")
    (description "A small polyfill for Object.setprototypeof")
    (license license:isc)))

(define-public node-statuses
  (package
    (name "node-statuses")
    (version "2.0.1")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/statuses/-/statuses-2.0.1.tgz")
       (sha256
        (base32 "0nig6ygf53sj8vcqvbcwrzm4ln986rcz16kn5qjv1y4s9m1l164i"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("csv-parse" "eslint"
                                              "eslint-config-standard"
                                              "eslint-plugin-import"
                                              "eslint-plugin-markdown"
                                              "eslint-plugin-node"
                                              "eslint-plugin-promise"
                                              "eslint-plugin-standard"
                                              "mocha"
                                              "nyc"
                                              "raw-body"
                                              "stream-to-array")))))))
    (home-page "https://github.com/jshttp/statuses#readme")
    (synopsis "HTTP status utility")
    (description "HTTP status utility")
    (license license:expat)))

(define-public node-toidentifier
  (package
    (name "node-toidentifier")
    (version "1.0.1")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/toidentifier/-/toidentifier-1.0.1.tgz")
       (sha256
        (base32 "021fp42m51qbqbqabwhxky8bkfkkwza65lqiz7d2gqwd91vwqvqq"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("eslint"
                                              "eslint-config-standard"
                                              "eslint-plugin-import"
                                              "eslint-plugin-markdown"
                                              "eslint-plugin-node"
                                              "eslint-plugin-promise"
                                              "eslint-plugin-standard"
                                              "mocha"
                                              "nyc")))))))
    (home-page "https://github.com/component/toidentifier#readme")
    (synopsis "Convert a string of words to a JavaScript identifier")
    (description "Convert a string of words to a JavaScript identifier")
    (license license:expat)))

(define-public node-http-errors
  (package
    (name "node-http-errors")
    (version "2.0.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/http-errors/-/http-errors-2.0.0.tgz")
       (sha256
        (base32 "1dypd936i09cvjyxx338da0nimbm4cqi2rrxhjch3ix2wmwx6ky1"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("eslint"
                                              "eslint-config-standard"
                                              "eslint-plugin-import"
                                              "eslint-plugin-markdown"
                                              "eslint-plugin-node"
                                              "eslint-plugin-promise"
                                              "eslint-plugin-standard"
                                              "mocha"
                                              "nyc")))))))
    (inputs (list node-toidentifier ;-1.0.1
		  node-statuses ;-2.0.1
                  node-setprototypeof ;-1.2.0
		  node-inherits ;-2.0.4
                  node-depd ;-2.0.0
		  ))
    (home-page "https://github.com/jshttp/http-errors#readme")
    (synopsis "Create HTTP error objects")
    (description "Create HTTP error objects")
    (license license:expat)))

(define-public node-koa-compose
  (package
    (name "node-koa-compose")
    (version "4.2.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/koa-compose/-/koa-compose-4.2.0.tgz")
       (sha256
        (base32 "0s828xc8dryfr5kj9hdrhalv62i0rmlih8g13zin93k6xnghvnc3"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("codecov" "jest" "matcha"
                                              "standard")))))))
    (home-page "https://github.com/koajs/compose#readme")
    (synopsis "compose Koa middleware")
    (description "compose Koa middleware")
    (license license:expat)))

(define-public node-methods
  (package
    (name "node-methods")
    (version "1.1.2")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/methods/-/methods-1.1.2.tgz")
       (sha256
        (base32 "0g50ci0gc8r8kq1i06q078gw7azkakp7j3yw5qfi6gq2qk8hdlnz"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("istanbul" "mocha")))))))
    (home-page "https://github.com/jshttp/methods")
    (synopsis "HTTP methods that node supports")
    (description "HTTP methods that node supports")
    (license license:expat)))

(define-public node-path-to-regexp
  (package
    (name "node-path-to-regexp")
    (version "6.2.2")
    (source
     (origin
       (method url-fetch)
       (uri
        "https://registry.npmjs.org/path-to-regexp/-/path-to-regexp-6.2.2.tgz")
       (sha256
        (base32 "04llmkn2spqypixmbsv8sklghg5nq2ixcrrqx5mlkq89id26gwfi"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("@borderless/ts-scripts"
                                              "@size-limit/preset-small-lib"
                                              "@types/node"
                                              "@types/semver"
                                              "@vitest/coverage-v8"
                                              "semver"
                                              "size-limit"
                                              "typescript")))))))
    (home-page "https://github.com/pillarjs/path-to-regexp#readme")
    (synopsis "Express style path to RegExp utility")
    (description "Express style path to RegExp utility")
    (license license:expat)))

(define-public node-koa-router
  (package
    (name "node-koa-router")
    (version "12.0.1")
    (source
     (origin
       (method url-fetch)
       (uri "https://registry.npmjs.org/@koa/router/-/router-12.0.1.tgz")
       (sha256
        (base32 "07bmr8ayix7n5cnvjszx3dvqq3768sqfd4b66iljsck9y0i71g5b"))))
    (build-system node-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases #~(modify-phases %standard-phases
                   (delete 'build)
                   (add-after 'patch-dependencies 'delete-dev-dependencies
                     (lambda _
                       (delete-dependencies '("@commitlint/cli"
                                              "@commitlint/config-conventional"
                                              "@ladjs/env"
                                              "ava"
                                              "cross-env"
                                              "eslint"
                                              "eslint-config-xo-lass"
                                              "expect.js"
                                              "fixpack"
                                              "husky"
                                              "jsdoc-to-markdown"
                                              "koa"
                                              "lint-staged"
                                              "mocha"
                                              "nyc"
                                              "remark-cli"
                                              "remark-preset-github"
                                              "should"
                                              "supertest"
                                              "wrk"
                                              "xo"))))
      (replace 'configure
	(lambda* (#:key outputs inputs #:allow-other-keys)
  (let ((npm (string-append (assoc-ref inputs "node") "/bin/npm")))
    (invoke npm "--verbose" "--offline" "--ignore-scripts" "--install-links" "install")
    #t)))
      )))
    (inputs (list node-path-to-regexp	;-6.2.2
		  node-methods		;-1.1.2
                  node-koa-compose	;-4.2.0
		  node-http-errors	;-2.0.0
                  node-debug		;-4.3.4
		  ))
    (home-page "https://github.com/koajs/router")
    (synopsis
     "Router middleware for koa. Maintained by Forward Email and Lad.")
    (description
     "Router middleware for koa. Maintained by Forward Email and Lad.")
    (license license:expat)))

node-koa-router ; During development tests
