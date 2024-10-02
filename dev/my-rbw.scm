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

;; Packages (with specific version - if 'inherit') needed during build phase

(define-public rust-argon2-0.5.3
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

(define-public rust-axum-0.7.5
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

(define-public rust-base32-0.5.1
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

(define-public rust-clap-4.5.11
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

(define-public rust-clap-builder-4.5.11
  (package
   (inherit rust-clap-builder-4)
    (name "rust-clap-builder")
    (version "4.5.11")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "clap_builder" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1ymhgzh6a9jnf0fh88xlk2613hqlbg3limbwgc0kbykwzb5rdss9"))))))

(define-public rust-clap-complete-4.5.11
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

(define-public rust-clap-derive-4.5.11
  (package
   (inherit rust-clap-derive-4)
    (name "rust-clap-derive")
    (version "4.5.11")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "clap_derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0gmr5mk50idn4iwissgwap0sxh4k28bdb7y88ysvnc4xz1krn0jx"))))))

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

(define-public rust-cpufeatures-0.2.12 ; Required by 'argon2'
  (package
   (inherit rust-cpufeatures-0.2)
    (name "rust-cpufeatures")
    (version "0.2.12")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cpufeatures" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "012m7rrak4girqlii3jnqwrr73gv1i980q4wra5yyyhvzwk5xzjk"))))))

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

(define-public rust-reqwest-0.12.5
  (package
   (inherit rust-reqwest-0.12)
    (name "rust-reqwest")
    (version "0.12.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "reqwest" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0dva5mx1cli19adc9igc81ix4si7yiri24ayxdw8652pgnid5mn7"))))))

(define-public rust-rmpv-1.3.0
  (package
   (inherit rust-rmpv-1)
   (name "rust-rmpv")
   (version "1.3.0")
   (source
    (origin
     (method url-fetch)
     (uri (crate-uri "rmpv" version))
     (file-name (string-append name "-" version ".tar.gz"))
     (sha256
      (base32 "1adjigqyrzbv71s18qz3sa77zqggqip0p8j4rrrk5scyrlihfiaq"))))))

(define-public rust-rustix-0.38.34
  (package
   (inherit rust-rustix-0.38)
    (name "rust-rustix")
    (version "0.38.34") ;XXX drop rust-rustix-for-bcachefs-tools when updating
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "rustix" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "03vkqa2ism7q56rkifyy8mns0wwqrk70f4i4fd53r97p8b05xp3h"))))))

(define-public rust-serde-json-1.0.120
  (package
   (inherit rust-serde-json-1)
    (name "rust-serde-json")
    (version "1.0.120")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serde_json" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1idpv3zxcvl76z2z47jgg1f1wjqdnhfc204asmd27qfam34j23af"))))))

(define-public rust-serde-path-to-error-0.1.16
  (package
   (inherit rust-serde-path-to-error-0.1)
    (name "rust-serde-path-to-error")
    (version "0.1.16")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "serde_path_to_error" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
         (base32 "19hlz2359l37ifirskpcds7sxg0gzpqvfilibs7whdys0128i6dg"))))))

(define-public rust-serde-repr-0.1.19
  (package
   (inherit rust-serde-repr-0.1)
    (name "rust-serde-repr")
    (version "0.1.19")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serde_repr" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1sb4cplc33z86pzlx38234xr141wr3cmviqgssiadisgl8dlar3c"))))))

(define-public rust-serde-1.0.204
  (package
   (inherit rust-serde-1)
    (name "rust-serde")
    (version "1.0.204")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serde" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "04kwpwqz559xlhxkggmm8rjxqgywy5swam3kscwsicnbw1cgaxmw"))))))

(define-public rust-textwrap-0.16.1
  (package
   (inherit rust-textwrap-0.16)
    (name "rust-textwrap")
    (version "0.16.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "textwrap" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1fgqn3mg9gdbjxwfxl76fg0qiq53w3mk4hdh1x40jylnz39k9m13"))))))

(define-public rust-thiserror-1.0.63
  (package
   (inherit rust-thiserror-1)
    (name "rust-thiserror")
    (version "1.0.63")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "thiserror" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "092p83mf4p1vkjb2j6h6z96dan4raq2simhirjv12slbndq26d60"))))))

(define-public rust-tokio-stream-0.1.15
  (package
   (inherit rust-tokio-stream-0.1)
    (name "rust-tokio-stream")
    (version "0.1.15")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tokio-stream" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1brpbsqyg8yfmfc4y0j9zxvc8xsxjc31d48kb0g6jvpc1fgchyi6"))))))

(define-public rust-sync-wrapper-1.0.0 ; Required by 'axum'
  (package
   (inherit rust-sync-wrapper-0.1)
    (name "rust-sync-wrapper")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sync_wrapper" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "037jwlka84cxwx6yzrd9aswmlpqi5508qnmdbj4njaaf3b0rai9q"))))))

(define-public rust-tokio-tungstenite-0.23.0
  (package
   (inherit rust-tokio-tungstenite-0.21)
    (name "rust-tokio-tungstenite")
    (version "0.23.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tokio-tungstenite" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1c10wfw22z8nn0j773mfvj9p7x90hfrl2wkwpwyimqz76fi39kdy"))))))

(define-public rust-tokio-1.39.2
  (package
   (inherit rust-tokio-1)
    (name "rust-tokio")
    (version "1.39.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tokio" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1cb7yhba7nnf00cylcywk7rai5kkdb8b4jzwrc26zgbqqwdzp96s"))))))

(define-public rust-url-2.5.2
  (package
   (inherit rust-url-2)
    (name "rust-url")
    (version "2.5.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "url" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "0v2dx50mx7xzl9454cl5qmpjnhkbahmn59gd3apyipbgyyylsy12"))))))

(define-public rust-uuid-1.10.0
  (package
   (inherit rust-uuid-1)
    (name "rust-uuid")
    (version "1.10.0")
    (source (origin
              (method url-fetch)
              (uri (crate-uri "uuid" version))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0503gvp08dh5mnm3f0ffqgisj6x3mbs53dmnn1lm19pga43a1pw1"))))))


(define-public rust-x11-clipboard-0.9.1 ; Required by 'copypasta'
  (package
   (inherit rust-x11-clipboard-0.8)
    (name "rust-x11-clipboard")
    (version "0.9.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "x11-clipboard" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "11zh1r18rlnflanp22n0p9lccpjzcw9l9af5ayxjpbvjwzijng31"))))))

(define-public rust-zeroize-1.8.1
  (package
   (inherit rust-zeroize-1)
    (name "rust-zeroize")
    (version "1.8.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "zeroize" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1pjdrmjwmszpxfd7r860jx54cyk94qk59x13sc307cvr5256glyf"))))))

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
	("rust-clap-builder" ,rust-clap-builder-4.5.11)
        ("rust-clap-complete" ,rust-clap-complete-4.5.11)
	("rust-clap-derive" ,rust-clap-derive-4.5.11)
        ("rust-copypasta" ,rust-copypasta-0.10.1)
	("rust-cpufeatures" ,rust-cpufeatures-0.2.12) ; required by 'argon2'
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
        ("rust-reqwest" ,rust-reqwest-0.12.5)
        ("rust-rmpv" ,rust-rmpv-1.3.0)
        ("rust-rsa" ,rust-rsa-0.9)
	("rust-rustix", rust-rustix-0.38.34)
        ("rust-serde" ,rust-serde-1.0.204)
        ("rust-serde-json" ,rust-serde-json-1.0.120)
        ("rust-serde-path-to-error" ,rust-serde-path-to-error-0.1.16)
        ("rust-serde-repr" ,rust-serde-repr-0.1.19)
        ("rust-sha1" ,rust-sha1-0.10)
        ("rust-sha2" ,rust-sha2-0.10)
	("rust-sync-wrapper" ,rust-sync-wrapper-1.0.0) ; Required by 'axum'
        ("rust-tempfile" ,rust-tempfile-3)
        ("rust-terminal-size" ,rust-terminal-size-0.3)
        ("rust-textwrap" ,rust-textwrap-0.16.1)
        ("rust-thiserror" ,rust-thiserror-1.0.63)
        ("rust-tokio" ,rust-tokio-1.39.2)
        ("rust-tokio-stream" ,rust-tokio-stream-0.1.15)
        ("rust-tokio-tungstenite" ,rust-tokio-tungstenite-0.23.0)
        ("rust-totp-lite" ,rust-totp-lite-2)
        ("rust-url" ,rust-url-2.5.2)
	("rust-urlencoding" ,rust-urlencoding-2)
        ("rust-uuid" ,rust-uuid-1.10.0)
	("rust-x11-clipboard" ,rust-x11-clipboard-0.9.1) ; Required by 'copypasta'
        ("rust-zeroize" ,rust-zeroize-1.8.1))
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
