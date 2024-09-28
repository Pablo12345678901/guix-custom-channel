(define-module (my-packages my-rbw)  
  ;; Copied/pasted the 'use-module' from on the top of the 'rbw' package (obtained through 'guix edit rbw' command)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix deprecation)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crates-apple)
  #:use-module (gnu packages crates-crypto)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages crates-tls)
  #:use-module (gnu packages crates-vcs)
  #:use-module (gnu packages crates-web)
  #:use-module (gnu packages crates-windows)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages ibus)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages jemalloc)
  #:use-module (gnu packages kde)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xorg)
)

;;-----------------------------------------------------------------------------------------

;; Packages needed during build phase

(define-public rust-argon2-0.5.3 ; version at least 0.5.3.
  (package
   (inherit rust-argon2-0.5)
   (name "rust-argon2")
    (version "0.5.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "argon2" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0wn0kk97k49wxidfigmz1pdqmygqzi4h6w72ib7cpq765s4i0diw"))))))

(define-public rust-axum-0.7.5 ; version at least 0.7.5
  (package
   (inherit rust-axum-0.7)
    (name "rust-axum")
    (version "0.7.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "axum" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1kyb7pzgn60crl9wyq7dhciv40sxdr1mbqx2r4s7g9j253qrlv1s"))))))

(define-public rust-base32-0.5.1 ; version at least 0.5.1
  (package
   (inherit rust-base32-0.4)
    (name "rust-base32")
    (version "0.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "base32" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0xp0a3xml25xw2bp5pyac2nld7vmmfjl02qynnyfn6aznfggwb82"))))))

(define-public rust-clap-4.5.11 ; version at least 4.5.11
  (package
   (inherit rust-clap-4)
    (name "rust-clap")
    (version "4.5.11")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "clap" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1cxmlb1zqx054j7l4lx9h89f5a3fpy40pkwbazxjlb3625m3wwim"))))))

(define-public rust-clap-complete-4.5.11 ; version at least 4.5.11
  (package
   (inherit rust-clap-complete-4)
    (name "rust-clap-complete")
    (version "4.5.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_complete" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32 "0spj1nll4b7zagc4iqhizjasviq8y44qcjwdbb6nyg43n3xnkbn6"))))))

(define-public rust-copypasta-0.10.1
  (package
   (inherit rust-copypasta-0.10)
    (name "rust-copypasta")
    (version "0.10.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "copypasta" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0n58sfbahs49ar0qivz1sqz1ixhh1ifgp5bzifjkvabwhqi59f6y"))))))

(define-public rust-env-logger-0.11.5
  (package
    (inherit rust-env-logger-0.11)
    (name "rust-env-logger")
    (version "0.11.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "env_logger" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "13812wq68kybv2vj6rpnhbl7ammlhggcb7vq68bkichzp4cscgz1"))))))

(define-public rust-is-terminal-0.4.12
  (package
   (inherit rust-is-terminal-0.4)
    (name "rust-is-terminal")
    (version "0.4.12")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "is-terminal" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "12vk6g0f94zlxl6mdh5gc4jdjb469n9k9s7y3vb0iml05gpzagzj"))))))


(define-public rust-libc-0.2.155
  (package
   (inherit rust-libc-0.2)
    (name "rust-libc")
    (version "0.2.155")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "libc" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0z44c53z54znna8n322k5iwg80arxxpdzjj5260pxxzc9a58icwp"))))))


(define-public rust-log-0.4.22
  (package
   (inherit rust-log-0.4)
    (name "rust-log")
    (version "0.4.22")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "log" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "093vs0wkm1rgyykk7fjbqp2lwizbixac1w52gv109p5r4jh0p9x7"))))))

(define-public rust-open-5.3.0
  (package
   (inherit rust-open-5)
    (name "rust-open")
    (version "5.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "open" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1cy40lf0hk8b0pwm9ix5zi53m4lqnjgviw9ylm16cwdxdazpga31"))))))


(define-public rust-regex-1.10.5
  (package
   (inherit rust-regex-1)
    (name "rust-regex")
    (version "1.10.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "regex" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zsiqk2sxc1kd46qw0yp87s2a14ialwyxinpl0k266ddkm1i64mr"))))))


(define-public rust-region-3.0.2
  (package
   (inherit rust-region-3)
    (name "rust-region")
    (version "3.0.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "region" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "19wrf7fg741jfnyz2314dv9m9hwssh816v27rpwsw2f07g8ypdp6"))))))


;;-----------------------------------------------------------------------------------------

(define-public my-rbw
  (package
    (name "my-rbw")
    (version "1.12.1")
    (outputs '("out" "scripts"))
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rbw" version))
       (file-name (string-append "rbw" "-" version ".tar.gz"))
       (sha256
        (base32 "175i4by97rnnpfxmy3cb8qlpf4ij793l37ln9q8n4fcq5dj84hs1"))
       (modules '((guix build utils)))
       (snippet
        '(begin (substitute* "Cargo.toml"
                  (("\"=([[:digit:]]+(\\.[[:digit:]]+)*)" _ version)
                   (string-append "\"^" version)))))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:cargo-inputs
       (("rust-aes" ,rust-aes-0.8)
        ("rust-anyhow" ,rust-anyhow-1)
	("rust-argon2" ,rust-argon2-0.5.3)
        ("rust-arrayvec" ,rust-arrayvec-0.7)
        ("rust-async-trait" ,rust-async-trait-0.1)
	("rust-axum" ,rust-axum-0.7.5) 
        ("rust-base32" ,rust-base32-0.5.1)
        ("rust-base64" ,rust-base64-0.22)
        ("rust-block-padding" ,rust-block-padding-0.3)
        ("rust-cbc" ,rust-cbc-0.1)
        ("rust-clap" ,rust-clap-4.5.11)
        ("rust-clap-complete" ,rust-clap-complete-4.5.11)
        ("rust-copypasta" ,rust-copypasta-0.10.1)
        ("rust-daemonize" ,rust-daemonize-0.5)
        ("rust-directories" ,rust-directories-5)
        ("rust-env-logger" ,rust-env-logger-0.11.5) 
        ("rust-futures" ,rust-futures-0.3)
        ("rust-futures-channel" ,rust-futures-channel-0.3)
        ("rust-futures-util" ,rust-futures-util-0.3)
        ("rust-hkdf" ,rust-hkdf-0.12)
        ("rust-hmac" ,rust-hmac-0.12)
        ("rust-humantime" ,rust-humantime-2)
        ("rust-is-terminal" ,rust-is-terminal-0.4.12)
        ("rust-libc" ,rust-libc-0.2.155)
        ("rust-log" ,rust-log-0.4.22)
        ("rust-nix" ,rust-nix-0.26)
	("rust-open" ,rust-open-5.3.0)
        ("rust-pbkdf2" ,rust-pbkdf2-0.12)
        ("rust-percent-encoding" ,rust-percent-encoding-2)
        ("rust-pkcs8" ,rust-pkcs8-0.10)
        ("rust-rand" ,rust-rand-0.8)
	("rust-regex" ,rust-regex-1.10.5)
        ("rust-region" ,rust-region-3.0.2)
        ("rust-reqwest" ,rust-reqwest-0.11)
        ("rust-rmpv" ,rust-rmpv-1)
        ("rust-rsa" ,rust-rsa-0.9)
        ("rust-serde" ,rust-serde-1)
        ("rust-serde-json" ,rust-serde-json-1)
        ("rust-serde-path-to-error" ,rust-serde-path-to-error-0.1)
        ("rust-serde-repr" ,rust-serde-repr-0.1)
        ("rust-sha1" ,rust-sha1-0.10)
        ("rust-sha2" ,rust-sha2-0.10)
        ("rust-tempfile" ,rust-tempfile-3)
        ("rust-terminal-size" ,rust-terminal-size-0.3)
        ("rust-textwrap" ,rust-textwrap-0.16)
        ("rust-thiserror" ,rust-thiserror-1)
        ("rust-tokio" ,rust-tokio-1)
        ("rust-tokio-stream" ,rust-tokio-stream-0.1)
        ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.20)
        ("rust-totp-lite" ,rust-totp-lite-2)
        ("rust-url" ,rust-url-2)
        ("rust-uuid" ,rust-uuid-1)
        ("rust-zeroize" ,rust-zeroize-1))
       #:phases
       (modify-phases %standard-phases
         (add-after 'install 'install-completions
           (lambda* (#:key native-inputs outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (share (string-append out "/share"))
                    (rbw (if ,(%current-target-system)
                          (search-input-file native-inputs "/bin/rbw")
                          (string-append out "/bin/rbw"))))
               (mkdir-p (string-append share "/bash-completion/completions"))
               (with-output-to-file
                 (string-append share "/bash-completion/completions/rbw")
                 (lambda _ (invoke rbw "gen-completions" "bash")))
               (mkdir-p (string-append share "/fish/vendor_completions.d"))
               (with-output-to-file
                 (string-append share "/fish/vendor_completions.d/rbw.fish")
                 (lambda _ (invoke rbw "gen-completions" "fish")))
               (mkdir-p (string-append share "/zsh/site-functions"))
               (with-output-to-file
                 (string-append share "/zsh/site-functions/_rbw")
                 (lambda _ (invoke rbw "gen-completions" "zsh")))
               (mkdir-p (string-append share "/elvish/lib"))
               (with-output-to-file
                 (string-append share "/elvish/lib/rbw")
                 (lambda _ (invoke rbw "gen-completions" "elvish"))))))
         (add-after 'install 'install-scripts
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out"))
                   (scripts (assoc-ref outputs "scripts")))
               (for-each (lambda (file)
                           (install-file file (string-append scripts "/bin")))
                         (find-files "bin"))
               (for-each (lambda (file)
                           (wrap-script file
                             ;; TODO: Do we want to wrap these with more programs?
                             ;; pass git fzf libsecret xclip rofi
                             `("PATH" prefix
                                (,(string-append out "/bin")
                                 ,(dirname (search-input-file inputs "/bin/grep"))
                                 ,(dirname (search-input-file inputs "/bin/sed"))
                                 ,(dirname (search-input-file inputs "/bin/perl"))
                                 ,(dirname (search-input-file inputs "/bin/xargs"))
                                 ,(dirname (search-input-file inputs "/bin/sort"))))))
                         (find-files (string-append scripts "/bin")))))))))
    (native-inputs
     (cons* perl (if (%current-target-system)
                   (list this-package)
                   '())))
    (inputs
     (list coreutils-minimal findutils grep perl sed))
    (home-page "https://git.tozt.net/rbw")
    (synopsis "Unofficial Bitwarden CLI")
    (description "This package is an unofficial command line client for
Bitwarden.  Although Bitwarden ships with a command line client, but
it's limited by being stateless, which makes it very difficult to use.  This
client avoids that problem by maintaining a background process which is able
to hold the keys in memory, similar to the way that ssh-agent or gpg-agent
work.  This allows the client to be used in a much simpler way, with the
background agent taking care of maintaining the necessary state.")
    (license license:expat)))

my-rbw ; For development purpose
