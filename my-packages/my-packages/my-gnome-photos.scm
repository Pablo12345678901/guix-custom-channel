(define-module (gnu packages gnome)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages aidc)
  #:use-module (gnu packages aspell)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages avahi)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages build-tools)
  #:use-module (gnu packages calendar)
  #:use-module (gnu packages cdrom)
  #:use-module (gnu packages check)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages crates-gtk)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages cyrus-sasl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages dbm)
  #:use-module (gnu packages djvu)
  #:use-module (gnu packages dns)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages docker)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages enchant)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages file-systems)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages game-development)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gimp)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages gnuzilla)
  #:use-module (gnu packages geo)
  #:use-module (gnu packages gperf)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages groff)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages ibus)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages inkscape)
  #:use-module (gnu packages iso-codes)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages language)
  #:use-module (gnu packages libcanberra)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libunistring)
  #:use-module (gnu packages libunwind)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lirc)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages man)
  #:use-module (gnu packages markup)
  #:use-module (gnu packages messaging)
  #:use-module (gnu packages mp3)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages music)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages nettle)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages node)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages ocr)
  #:use-module (gnu packages openldap)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages polkit)
  #:use-module (gnu packages popt)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rdesktop)
  #:use-module (gnu packages rdf)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages samba)
  #:use-module (gnu packages scanner)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages search)
  #:use-module (gnu packages selinux)
  #:use-module (gnu packages slang)
  #:use-module (gnu packages speech)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages valgrind)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu packages vpn)
  #:use-module (gnu packages web)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu artwork)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix platform)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (ice-9 match)
  #:use-module (my-packages my-babl) ;; for my custom version of 'babl'
  #:use-module (srfi srfi-1))

(define-public gnome-photos
  (package
    (name "gnome-photos")
    (version "43.beta")                 ;for geocode-glib 2 support
    (source
     (origin
       (method url-fetch)
       (uri
        (string-append "mirror://gnome/sources/" name "/"
                       (version-major version) "/"
                       name "-" version ".tar.xz"))
       (sha256
        (base32
         "1pry45dy4sjw8y63vxw2b499brcxzpkd4hmg2vbqy538r79ah2g9"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:disallowed-references (list (this-package-native-input "git-minimal"))
      #:glib-or-gtk? #t
      #:configure-flags
      #~(list "-Ddogtail=false"         ; Not available
              ;; Required for RUNPATH validation.
              (string-append "-Dc_link_args=-Wl,-rpath="
                             #$output "/lib/gnome-photos"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'disable-gtk-update-icon-cache
            (lambda _
              (setenv "DESTDIR" "/")))
          (add-after 'install 'wrap-gnome-photos
            (lambda* (#:key outputs #:allow-other-keys)
              (wrap-program (search-input-file outputs "bin/gnome-photos")
                `("GRL_PLUGIN_PATH" =
                  (,(getenv "GRL_PLUGIN_PATH")))))))))
    (native-inputs
     (list dbus
           desktop-file-utils
           gettext-minimal
           git-minimal/pinned
           `(,glib "bin")
           gobject-introspection
           gsettings-desktop-schemas
           itstool
           pkg-config))
    (inputs
     (list my-babl
           cairo
           gegl
           geocode-glib
           gexiv2
           gfbgraph
           gnome-online-accounts
           gnome-online-miners
           grilo
           grilo-plugins
           gtk+
           libdazzle
           libgdata
           libhandy
           libjpeg-turbo
           libportal
           libpng
           (librsvg-for-system)
           python-pygobject
           rest
           tracker
           tracker-miners))
    (synopsis "Access, organize and share your photos on GNOME desktop")
    (description "GNOME Photos is a simple and elegant replacement for using a
file manager to deal with photos.  Enhance, crop and edit in a snap.  Seamless
cloud integration is offered through GNOME Online Accounts.")
    (home-page "https://wiki.gnome.org/Apps/Photos")
    (license license:gpl3+)))

gnome-photos