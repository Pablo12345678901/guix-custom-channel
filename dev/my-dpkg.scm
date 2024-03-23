(define-module (my-packages my-dpkg)
  #:use-module (gnu packages debian) ; for dpkg
  #:use-module (guix build utils)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix build-system gnu)  
)

#!
;; ERROR MESSAGE :
While trying to install a 'deb' package file, return an error :
Example :
        sudo dpkg --install ChatGPT_1.1.0_linux_x86_64.deb
        dpkg: error: unable to access the dpkg database directory /gnu/store/968gwhadzz885jmy0il1lab4i9kac005-my-dpkg-1.22.1/var/lib/dpkg: Read-only file system
!#

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

        (arguments
          (list #:modules
           `((srfi srfi-71)
             ,@%gnu-build-system-modules)
           #:phases
           #~(modify-phases %standard-phases
               (add-before 'bootstrap 'patch-version
                 (lambda _
                   (patch-shebang "build-aux/get-version")
                   (with-output-to-file ".dist-version"
                     (lambda () (display #$version)))))
               (add-after 'unpack 'set-perl-libdir
                 (lambda _
                   (let* ((perl #$(this-package-input "perl"))
                          (_ perl-version (package-name->name+version perl)))
                     (setenv "PERL_LIBDIR"
                             (string-append #$output
                                            "/lib/perl5/site_perl/"
                                            perl-version)))))
               (add-after 'install 'wrap-scripts
                 (lambda _
                   (with-directory-excursion (string-append #$output "/bin")
                     (for-each
                      (lambda (file)
                        (wrap-script file
                          ;; Make sure all perl scripts in "bin" find the
                          ;; required Perl modules at runtime.
                          `("PERL5LIB" ":" prefix
                            (,(string-append #$output
                                             "/lib/perl5/site_perl")
                             ,(getenv "PERL5LIB")))
                          ;; DPKG perl modules expect dpkg to be installed.
                          ;; Work around it by adding dpkg to the script's path.
                          `("PATH" ":" prefix (,(string-append #$output
                                                               "/bin")))))
                      (list "dpkg-architecture"
                            "dpkg-buildapi"
                            "dpkg-buildflags"
                            "dpkg-buildpackage"
                            "dpkg-checkbuilddeps"
                            "dpkg-distaddfile"
                            "dpkg-genbuildinfo"
                            "dpkg-genchanges"
                            "dpkg-gencontrol"
                            "dpkg-gensymbols"
                            "dpkg-mergechangelogs"
                            "dpkg-name"
                            "dpkg-parsechangelog"
                            "dpkg-scanpackages"
                            "dpkg-scansources"
                            "dpkg-shlibdeps"
                            "dpkg-source"
                            "dpkg-vendor")))))
#!
	       ;; Trying to set to 'writable' the file system but not possible that way
	       (add-after 'wrap-scripts 'set-chmod-on-database
		   (lambda* (#:key outputs #:allow-other-keys)
		      (let* (
			 (database-dir (string-append (assoc-ref outputs "out") "/var/lib/dpkg")))
			 (invoke "pwd")
			     (for-each make-file-writable (find-files database-dir)))))
!#
	       )))
    
))

my-dpkg ;; Uncomment this line while developping / Re-comment it after.
