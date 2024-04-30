(define-module (my-packages my-sqltutor)
  #:use-module (gnu packages databases) ; for libpqxx
  ;;#:use-module (gnu packages haskell-xyz) ; for ghc-postgresql-libpq -> libpqd
  #:use-module (gnu packages pkg-config)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix gexp) ; for #~
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages) ; for 'package' definition
)

#!
Build error :
getting error kind of :
"in function `inert_notice_processor':
(.text+0x1b9):  undefined reference to `PQfreemem'"
Because of librairy linking. It seems to be about liqpqxx and lpq.
See :
- https://github.com/jtv/libpqxx/issues/462
- https://stackoverflow.com/questions/27144588/undefined-reference-to-pqfinish-even-though-libraries-etc-are-included
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
	    ;;pqxx::tuple was replaced by pqxx::row
	    (add-before 'build 'patch-pqxx-new-api
	       (lambda* (#:key inputs #:allow-other-keys)
		(substitute* "cgi.cpp/check_answer.cpp"
			     (("pqxx::tuple") "pqxx::row"))
		(substitute* "cgi.cpp/show_sql_result.cpp"
			     (("pqxx::tuple") "pqxx::row"))
		(substitute* "cgi.cpp/show_table_data.cpp"
			     (("pqxx::tuple") "pqxx::row"))
		)))))
    (inputs
     (list
      libpqxx
      pkg-config))
    (synopsis "
3 	Interactive web based tool for learning SQL by examples.")
    (description "SQLtutor consists of two modules: a database of questions and answers and a simple CGI interface for running tests. Questions are chosen at random for each session, submitted queries are checked against correct answers stored in the database. Query results differing only in column permutations are evaluated as correct. For each session queries and answers are logged and the final score is evaluated when the test is finished. SQLtutor is written in C++ with lipqxx library to connect to PostgreSQL database. SQLtutor runs on GNU/Linux.")
    (home-page "https://savannah.gnu.org/projects/sqltutor/")
    (license license:gpl3)))

my-sqltutor ;; Development purpose

