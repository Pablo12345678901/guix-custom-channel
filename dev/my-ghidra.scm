(define-module (my-packages my-ghidra)
  #:use-module (gnu build install)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages node)
  #:use-module (gnu packages node-xyz)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix build-system trivial)
  #:use-module (guix build utils)
  #:use-module (guix git-download)
  #:use-module (guix gexp) ; for #~
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

(define %base-inputs
  (list
   bash
   bzip2
   coreutils
   findutils
   gawk
   gcc
   glib
   grep
   gzip
   gnu-make
   python-invoke
   python-minimal
   sed))

(define-public my-ghidra
  (let ((revision "1")
   (commit "87747c20b36f89bb32577813a44348deed2f4354")) ; As of 240620
  (package
    (name "my-ghidra")
    (version "11.1.1") ; As of 240620
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
	    (url "https://github.com/NationalSecurityAgency/ghidra")
	    (commit commit)))
      (file-name (git-file-name name version))
       (sha256
        (base32
	 "0px8kgyz905dp7hspy4m9vawg2bjwjqscsi39h704cws7p8xmzz3"))))
      (build-system trivial-build-system)

      (native-inputs
       (list node-global-gradle-clean))
#!
(inputs
 (append %base-inputs
         (list (node-global-gradle-clean))))
!#
   (arguments
       `(#:guile ,guile-3.0
         #:modules ((guix build utils))
         #:builder
         (begin
           (use-modules (guix build utils))
           (let* ((out (assoc-ref %outputs "out"))
                  (node-global-gradle-clean (assoc-ref %build-inputs "node-global-gradle-clean")))
             ;(mkdir-p out)
             (invoke (string-append node-global-gradle-clean "/bin/global-gradle-clean") "buildGhidra")))))
    (synopsis "A software reverse engineering (SRE) suite of tools developed by NSA's Research Directorate in support of the Cybersecurity mission")
    (description "Ghidra is a software reverse engineering (SRE) framework created and maintained by the National Security Agency Research Directorate. This framework includes a suite of full-featured, high-end software analysis tools that enable users to analyze compiled code on a variety of platforms including Windows, macOS, and Linux. Capabilities include disassembly, assembly, decompilation, graphing, and scripting, along with hundreds of other features. Ghidra supports a wide variety of processor instruction sets and executable formats and can be run in both user-interactive and automated modes. Users may also develop their own Ghidra extension components and/or scripts using Java or Python.")
    (home-page "https://ghidra-sre.org/")
    (license license:gpl3))))

my-ghidra ;; Development purpose

