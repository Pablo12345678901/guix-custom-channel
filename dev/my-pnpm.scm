(define-module (my-packages my-pnpm)
  #:use-module (guix build-system node)
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

#!
;ERROR MESSAGE :
starting phase `configure'
npm ERR! code EUNSUPPORTEDPROTOCOL
npm ERR! Unsupported URL Type "workspace:": workspace:*
!#

(define-public my-pnpm
  ; commit 
  (package
    (name "my-pnpm")
    (version "v8.15.15") ;; Latest available on the 240320
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/pnpm/pnpm")
             (commit "5eeaff4120a03b6bd2c6460425a12ae2935c1251")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1rj7gr4x71hh4cvbvwl63igfxnzqzp24avpg7shrmik6p7pspmv9"))))
    (build-system node-build-system)
    (arguments '()) ; Let this line while development.
    (native-inputs '())
    (inputs '())
    (propagated-inputs '())
    (home-page "DEBUG HOME-PAGE TO DO")
    (synopsis "DEBUG SYNOPSIS TO DO")
    (description "DEBUG DESCRIPTION TO DO")
    (license license:bsd-2)))

my-pnpm ;; Uncomment this line while developping / Re-comment it after.

#!
     (list
      ;#:use-module (guix build utils)
       #:phases
       #~(modify-phases %standard-phases
	;; Add verbose option for debug
         (add-before 'configure 'patch-download-protocol
	       (lambda* (#:key inputs #:allow-other-keys)
			(let* ((dummy-binding "dummy-binding"))
		    (invoke "pwd")
		    (substitute* '("package.json")
		     (("workspace:") ; Command that should get the git version. But does not work as the '.git' directory is not copied/pasted during the build.
		      "file:")))))
	 ))
!#

#!
    (arguments
    ;; Patch for the issue about the dependencies :
    ;; ...
    ;; starting phase `configure'
    ;; npm ERR! code ENOTCACHED
    ;; npm ERR! request to https://registry.npmjs.org/@angular-devkit%2fbuild-angular failed: cache mode is 'only-if-cached' but no cached response is available.
    ;; ...
     (list
       #:phases
       #~(modify-phases %standard-phases
	;; Add verbose option for debug
	(replace 'configure			 
	    (lambda* (#:key outputs inputs #:allow-other-keys)
	      (let* ((npm (string-append (assoc-ref inputs "node") "/bin/npm")))			
        (invoke npm "--offline" "--ignore-scripts" "--install-links" "-verbose" "install"))))		
	)))
!#

#!
;; All dependencies causes issues... The devDependencies as well as the dependencies. If all dependencies with 'angular' are removed, the next one (by alphabetic order) causes issue : '@compodoc/compodoc'.
         (add-after 'patch-dependencies 'delete-custom-dependencies
	       (lambda _ 
		 (let* ((absent (list
				;; From devDependencies
				"@angular-devkit/build-angular"
		                "@angular-eslint/eslint-plugin"
		                "@angular-eslint/eslint-plugin-template"
		                "@angular-eslint/template-parser"
		                "@angular/cli"
		                "@angular/compiler-cli"
                                "@angular/elements"
                                 ;; From dependencies
				 "@angular/animations"
		                 "@angular/cdk"
		                 "@angular/common"
		                 "@angular/compiler"
		                 "@angular/core"
		                 "@angular/forms"
		                 "@angular/platform-browser"
		                 "@angular/platform-browser-dynamic"
		                 "@angular/router"
				 )))
		 (delete-dependencies absent)
		 )))
!#
