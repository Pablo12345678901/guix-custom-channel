(define-module (my-packages my-sqltutor)
  #:use-module (gnu packages databases) ; for libpqxx
  #:use-module (gnu packages geo) ; for postgis
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages databases) ; for postgresql
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp) ; for #~
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

#!
During build, issue about creating socket within /var directory.
It does not block the build but the package does not work.
Example : 'sqltutor --help' -> waits indefinitely.
!#

(define-public my-sqltutor
  (package
    (name "my-sqltutor")
    (version "1.0") ;; 240425
    (source
     (origin
       (method url-fetch)
       (uri
	(string-append
	 "https://ftp.gnu.org/gnu/sqltutor/sqltutor-" version ".tar.gz"))
       (sha256
        (base32
         "1qda46q4d437am667903r5pkszzc1ijq9zrap25nhw3n32yyn7fi"))))
    (build-system gnu-build-system)
    (arguments
     (list
       #:phases
       #~(modify-phases %standard-phases
	    ;; Changes in API (https://pqxx.org/libpqxx/)
	    ;; 'pqxx::tuple' was replaced by 'pqxx::row'
	    (add-before 'build 'patch-libpqxx-new-api
		(lambda* (#:key inputs #:allow-other-keys)
                (substitute* '("cgi.cpp/check_answer.cpp"
			       "cgi.cpp/show_sql_result.cpp"
			       "cgi.cpp/show_table_data.cpp"
			       )
		     (("pqxx::tuple") "pqxx::row"))))
	    ;; To resolve 'undefined references to "PQ" variables'
	    ;; Add the build against the 'lpq' lib after the 'lpqxx' one.
	    (add-before 'build 'patch-libpqxx-makefile
		(lambda* (#:key inputs #:allow-other-keys)
		  (let* ((libpqxx-path (string-append "-L" (assoc-ref inputs "libpqxx") "/lib -lpqxx"))
			 (libpq-path (string-append "-L" (assoc-ref inputs "postgresql") "/lib -lpq"))
			  (replacement-libpqxx-libs (string-append "LIBPQXX_LIBS = " libpqxx-path " " libpq-path "
")))
		 ;; Add library paths and name to LIBPQXX_LIBS
		 (substitute* "cgi.cpp/Makefile"
		      (("^LIBPQXX_LIBS =.*$")
		       replacement-libpqxx-libs))
		 ;; Add library names to LIBS
		 (substitute* "cgi.cpp/Makefile"
		      (("^LIBS =.*$")
		       "LIBS = -lpqxx -lpq
")))))
	    )))
    (inputs
     (list
      libpqxx
      pkg-config
      postgis ; See README of sqltutor
      postgresql ; for libpq -> required to build against libpqxx
      ))
    (synopsis "Interactive web based tool for learning SQL by examples.")
    (description "SQLtutor consists of two modules: a database of questions and answers and a simple CGI interface for running tests. Questions are chosen at random for each session, submitted queries are checked against correct answers stored in the database. Query results differing only in column permutations are evaluated as correct. For each session queries and answers are logged and the final score is evaluated when the test is finished. SQLtutor is written in C++ with lipqxx library to connect to PostgreSQL database. SQLtutor runs on GNU/Linux.")
    (home-page "https://savannah.gnu.org/projects/sqltutor/")
    (license license:gpl3)))

my-sqltutor ;; Development purpose

