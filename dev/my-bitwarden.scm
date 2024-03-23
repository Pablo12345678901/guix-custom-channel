(define-module (my-packages my-bitwarden)
  #:use-module (guix build-system node)
  #:use-module (guix gexp) ; for '#~'
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
)

(define-public my-bitwarden
  (package
    (name "bitwarden-client")
    (version "desktop-v2024.3.0") ;; Latest available on the 240320
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/bitwarden/clients")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1f3p5yvw3knn5s99jlb1xb4k0i4m19gs9mnlqazjqzd7j7vl2ijw"))))
    (build-system node-build-system)
    (arguments '())
    (home-page "https://bitwarden.com/")
    (synopsis "Bitwarden client applications (web, browser extension, desktop, and cli)")
    (description "Bitwarden client applications (web, browser extension, desktop, and cli)")
    (license license:gpl3)))

my-bitwarden ;; Uncomment this line while developping / Re-comment it after.

#!
; Content of package.json
{"dependencies":{
		 "@angular\/animations":"16.2.12",
		 "@angular\/cdk":"16.2.13",
		 "@angular\/common":"16.2.12",
		 "@angular\/compiler":"16.2.12",
		 "@angular\/core":"16.2.12",
		 "@angular\/forms":"16.2.12",
		 "@angular\/platform-browser":"16.2.12",
		 "@angular\/platform-browser-dynamic":"16.2.12",
		 "@angular\/router":"16.2.12",
		 "@koa\/multer":"3.0.2",
		 "@koa\/router":"12.0.1",
		 "@microsoft\/signalr":"8.0.0",
		 "@microsoft\/signalr-protocol-msgpack":"8.0.0",
		 "@ng-select\/ng-select":"11.2.0",
		 "argon2":"0.31.0","argon2-browser":"1.18.0",
		 "big-integer":"1.6.51","bootstrap":"4.6.0",
		 "braintree-web-drop-in":"1.42.0",
		 "buffer":"6.0.3","bufferutil":"4.0.8",
		 "chalk":"4.1.2","commander":"11.1.0",
		 "core-js":"3.34.0",
		 "duo_web_sdk":"github:duosecurity\/duo_web_sdk",
		 "form-data":"4.0.0",
		 "https-proxy-agent":"7.0.2",
		 "inquirer":"8.2.6",
		 "jquery":"3.7.1",
		 "jsdom":"23.0.1",
		 "jszip":"3.10.1",
		 "koa":"2.15.0",
		 "koa-bodyparser":"4.4.1",
		 "koa-json":"2.0.2",
		 "lowdb":"1.0.0",
		 "lunr":"2.3.9",
		 "multer":"1.4.5-lts.1",
		 "ngx-infinite-scroll":"16.0.0",
		 "ngx-toastr":"17.0.2",
		 "node-fetch":"2.6.12",
		 "node-forge":"1.3.1",
		 "nord":"0.2.1",
		 "oidc-client-ts":"2.4.0",
		 "open":"8.4.2",
		 "papaparse":"5.4.1",
		 "patch-package":"8.0.0",
		 "popper.js":"1.16.1",
		 "proper-lockfile":"4.1.2",
		 "qrcode-parser":"2.1.3",
		 "qrious":"4.0.2",
		 "rxjs":"7.8.1",
		 "tabbable":"6.2.0",
		 "tldts":"6.1.8",
		 "utf-8-validate":"6.0.3",
		 "zone.js":"0.13.3",
		 "zxcvbn":"4.4.2"
	     },
 "devDependencies":{
		    "@angular-devkit\/build-angular":"16.2.11",
		    "@angular-eslint\/eslint-plugin":"16.3.1",
		    "@angular-eslint\/eslint-plugin-template":"16.3.1",
		    "@angular-eslint\/template-parser":"16.3.1",
		    "@angular\/cli":"16.2.11",
		    "@angular\/compiler-cli":"16.2.12",
		    "@angular\/elements":"16.2.12",
		    "@compodoc\/compodoc":"1.1.23",
		    "@electron\/notarize":"2.3.0",
		    "@electron\/rebuild":"3.6.0",
		    "@ngtools\/webpack":"16.2.11",
		    "@storybook\/addon-a11y":"7.6.17",
		    "@storybook\/addon-actions":"7.6.17",
		    "@storybook\/addon-designs":"7.0.9",
		    "@storybook\/addon-essentials":"7.6.17",
		    "@storybook\/addon-interactions":"7.6.17",
		    "@storybook\/addon-links":"7.6.17",
		    "@storybook\/angular":"7.6.17",
		    "@storybook\/jest":"0.2.3",
		    "@storybook\/testing-library":"0.2.2",
		    "@types\/argon2-browser":"1.18.1",
		    "@types\/chrome":"0.0.243",
		    "@types\/duo_web_sdk":"2.7.1",
		    "@types\/firefox-webext-browser":"111.0.1",
		    "@types\/inquirer":"8.2.6",
		    "@types\/jest":"29.5.12",
		    "@types\/jquery":"3.5.29",
		    "@types\/jsdom":"21.1.6",
		    "@types\/koa":"2.14.0",
		    "@types\/koa__multer":"2.0.7",
		    "@types\/koa__router":"12.0.4",
		    "@types\/koa-bodyparser":"4.3.7",
		    "@types\/koa-json":"2.0.23",
		    "@types\/lowdb":"1.0.11",
		    "@types\/lunr":"2.3.7",
		    "@types\/node":"18.19.14",
		    "@types\/node-fetch":"2.6.4",
		    "@types\/node-forge":"1.3.11",
		    "@types\/node-ipc":"9.2.0",
		    "@types\/papaparse":"5.3.14",
		    "@types\/proper-lockfile":"4.1.2",
		    "@types\/react":"16.14.54",
		    "@types\/retry":"0.12.5",
		    "@types\/zxcvbn":"4.4.4",
		    "@typescript-eslint\/eslint-plugin":"6.21.0",
		    "@typescript-eslint\/parser":"6.21.0",
		    "@webcomponents\/custom-elements":"1.6.0",
		    "autoprefixer":"10.4.16",
		    "base64-loader":"1.0.0",
		    "chromatic":"10.0.0",
		    "clean-webpack-plugin":"4.0.0",
		    "concurrently":"8.2.2",
		    "copy-webpack-plugin":"11.0.0",
		    "cross-env":"7.0.3",
		    "css-loader":"6.8.1",
		    "electron":"28.2.4",
		    "electron-builder":"24.9.1",
		    "electron-log":"5.0.1",
		    "electron-reload":"2.0.0-alpha.1",
		    "electron-store":"8.1.0",
		    "electron-updater":"6.1.8",
		    "eslint":"8.56.0",
		    "eslint-config-prettier":"9.1.0",
		    "eslint-import-resolver-typescript":"3.6.1",
		    "eslint-plugin-import":"2.29.1",
		    "eslint-plugin-rxjs":"5.0.3",
		    "eslint-plugin-rxjs-angular":"2.0.1",
		    "eslint-plugin-storybook":"0.6.15",
		    "eslint-plugin-tailwindcss":"3.13.1",
		    "gulp":"4.0.2",
		    "gulp-filter":"9.0.1",
		    "gulp-if":"3.0.0",
		    "gulp-json-editor":"2.6.0",
		    "gulp-replace":"1.1.4",
		    "gulp-zip":"6.0.0",
		    "html-loader":"4.2.0",
		    "html-webpack-injector":"1.1.4",
		    "html-webpack-plugin":"5.5.4",
		    "husky":"9.0.10",
		    "jest-junit":"16.0.0",
		    "jest-mock-extended":"3.0.5",
		    "jest-preset-angular":"14.0.2",
		    "lint-staged":"15.2.2",
		    "mini-css-extract-plugin":"2.7.6",
		    "node-ipc":"9.2.1",
		    "pkg":"5.8.1",
		    "postcss":"8.4.32",
		    "postcss-loader":"7.3.3",
		    "prettier":"3.2.2",
		    "prettier-plugin-tailwindcss":"0.5.11",
		    "process":"0.11.10",
		    "react":"18.2.0",
		    "react-dom":"18.2.0",
		    "regedit":"^3.0.3",
		    "remark-gfm":"3.0.1",
		    "rimraf":"5.0.5",
		    "sass":"1.69.5",
		    "sass-loader":"13.3.2",
		    "storybook":"7.6.17",
		    "style-loader":"3.3.3",
		    "tailwindcss":"3.3.5",
		    "ts-jest":"29.1.2",
		    "ts-loader":"9.5.1",
		    "tsconfig-paths-webpack-plugin":"4.1.0",
		    "type-fest":"2.19.0",
		    "typescript":"5.1.6",
		    "url":"0.11.3",
		    "util":"0.12.5",
		    "wait-on":"7.2.0",
		    "webpack":"5.89.0",
		    "webpack-cli":"5.1.4",
		    "webpack-dev-server":"4.15.1",
		    "webpack-node-externals":"3.0.0"
		}, 
 "name":"@bitwarden\/clients",
 "version":"0.0.0",
 "description":"Bitwarden Client Applications",
 "repository":{
	       "type":"git",
	       "url":"git+https:\/\/github.com\/bitwarden\/clients.git"
	       },
 "author":"Bitwarden Inc. <hello@bitwarden.com> (https:\/\/bitwarden.com)",
 "license":"GPL-3.0",
 "bugs":{"url":"https:\/\/github.com\/bitwarden\/clients\/issues"},
 "homepage":"https:\/\/bitwarden.com",
 "scripts":{
	    "prepare":"husky",
	    "lint":"eslint . --cache --cache-strategy content && prettier --check .",
	    "lint:fix":"eslint . --cache --cache-strategy content --fix",
	    "lint:clear":"rimraf .eslintcache",
	    "prettier":"prettier --cache --write .",
	    "test":"jest",
	    "test:watch":"jest --clearCache && jest --watch",
	    "test:watch:all":"jest --watchAll",
	    "test:types":"node .\/scripts\/test-types.js",
	    "docs:json":"compodoc -p .\/tsconfig.json -e json -d .",
	    "storybook":"ng run components:storybook",
	    "build-storybook":"ng run components:build-storybook",
	    "build-storybook:ci":"ng run components:build-storybook --webpack-stats-json",
	    "postinstall":"patch-package"
	    },
 "workspaces":["apps\/*","apps\/desktop\/desktop_native","libs\/*"],
 "overrides":{
	      "tailwindcss":"$tailwindcss",
	      "@storybook\/angular":{"zone.js":"$zone.js"},
	      "replacestream":"4.0.3"
	      },
 "resolutions":{"@types\/react":"16.14.54"},
 "lint-staged":{
		"*":"prettier --cache --ignore-unknown --write",
		"*.ts":"eslint --cache --cache-strategy content --fix"
		},
 "engines":{"node":"~18","npm":"~9"}
 }
!#


#!
        ;; Add a custom phase to debug network access
        (add-before 'unpack 'debug-network-access
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let* ((url "https://www.gnu.org/")  ; Replace with a known URL
                   (curl (string-append (assoc-ref inputs "curl") "/bin/curl"))) ; Path to binary
              (format #t "Testing network access before unpack phase...~%")
              (if (zero? (system* curl "--head" "--silent" "--fail" url))
                  (format #t "Network access before unpack phase: SUCCESS~%")
                  (format #t "Network access before unpack phase: FAILURE~%"))
              #t))))))

    (inputs
`(("curl" ,curl))) ; Ensure 'curl' is available for testing network access
!#

#!
     (list
       #:phases
        #~(modify-phases %standard-phases
			 ;; Add a custom phase to debug network access

			         (add-before 'configure 'enable-network-access
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let ((network-dir (string-append (assoc-ref inputs "network-files") "/network")))
               (mkdir-p network-dir)
               (mount #f network-dir "/etc/network" "-o" "bind")
               #t)))))
!#