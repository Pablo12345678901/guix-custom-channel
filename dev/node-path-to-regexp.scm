(define-module (my-packages node-path-to-regexp)
  #:use-module (gnu packages node-xyz)
  #:use-module (gnu packages version-control) ; for 'git' package
  #:use-module (guix build-system node)
  #:use-module (guix download) ; for 'url-fetch'
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download) ; for 'git-fetch'
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

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

node-path-to-regexp ; During development test.
