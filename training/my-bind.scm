(define-module (my-packages my-bind)
  #:use-module (gnu packages autotools) ; for autoconf -> autoreconf & automake -> aclocal & libtool
  #:use-module (gnu packages check) ; for pytest
  #:use-module (gnu packages datastructures) ; for liburcu
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages libevent) ; for libuv
  #:use-module (gnu packages linux) ; for libcap
  #:use-module (gnu packages web) ; for nghttp2
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages tls) ; for openssl
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download) ; for git-fetch
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

(define-public my-bind
  (let ((commit "ed77b615998e73cd88be8cefdccda8e0c5b855ea")
    (revision "0"))
  (package
   (name "my-bind")
   (version "9.19.24") ; 240424
    (source
    (origin
      (method git-fetch)
      (uri (git-reference
	(url "https://gitlab.isc.org/isc-projects/bind9")
	    (commit commit)))
              (file-name (git-file-name "bind" version))
	      (sha256
               (base32
                "05jnk6hjjcmfzb8gdk456c9fgcb5zy77dd37138asxnr4jz46psv"))))
    (build-system gnu-build-system)
    (arguments '())
    ;; Inputs have to be that way with '`' because of the need of nghttps2:lib output
    (inputs `(
	      ("automake" ,automake)
	      ("autoconf" ,autoconf)
	      ("gettext" ,gettext-minimal)
	      ("libcap" ,libcap)
	      ("libtool" ,libtool)
	      ("liburcu" ,liburcu)
	      ("libuv" ,libuv)
	      ("nghttps2:lib" ,nghttp2 "lib")
	      ("openssl" ,openssl)
	      ("perl" ,perl)
	      ("pkg-config" ,pkg-config)
	      ("python-pytest" ,python-pytest)
	      ("python" ,python)
	      ))
    (synopsis "BIND (Berkeley Internet Name Domain) is a complete, highly portable implementation of the Domain Name System (DNS) protocol.")
    (description "The BIND name server, named, can act as an authoritative name server, recursive resolver, DNS forwarder, or all three simultaneously. It implements views for split-horizon DNS, automatic DNSSEC zone signing and key management, catalog zones to facilitate provisioning of zone data throughout a name server constellation, response policy zones (RPZ) to protect clients from malicious data, response rate limiting (RRL) and recursive query limits to reduce distributed denial of service attacks, and many other advanced DNS features. BIND also includes a suite of administrative tools, including the dig and delv DNS lookup tools, nsupdate for dynamic DNS zone updates, rndc for remote name server administration, and more.
It includes those tools : named, nsupdate, rndc, dnssec-keygen, nslookup, dig, dnssec-makekeyset, dnssec-signkey, dnssec-signzone, named-checkconf, named-checkzone, rndc-confgen, host.")
    (home-page "https://www.isc.org/")
    (license license:asl2.0))))

;;my-bind ; Development purpose

