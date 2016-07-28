;; Emacs LIVE
;;
;; This is where everything starts. Do you remember this place?
;; It remembers you...

(setq live-ascii-art-logo ";;
;;     MM\"\"\"\"\"\"\"\"`M
;;     MM  mmmmmmmM
;;     M`      MMMM 88d8b.d8b. .d8888b. .d8888b. .d8888b.
;;     MM  MMMMMMMM 88''88'`88 88'  `88 88'  `\"\" Y8ooooo.
;;     MM  MMMMMMMM 88  88  88 88.  .88 88.  ...       88
;;     MM        .M dP  dP  dP `88888P8 '88888P' '88888P'
;;     MMMMMMMMMMMM")

(message (concat "\n\n" live-ascii-art-logo "\n\n"))

(add-to-list 'command-switch-alist
             (cons "--live-safe-mode"
                   (lambda (switch)
                     nil)))

;; (add-to-list 'load-path "~/.emacs.d/let-alist")

;; ffip so that doesn/t work
;; find-file-noselect: Wrong type argument: stringp, nil
;; (add-to-list 'load-path
;;              "~/.emacs.d/ffip")

;; Projectile Remember
;; (projectile-global-mode)

(setq live-safe-modep
      (if (member "--live-safe-mode" command-line-args)
          "debug-mode-on"
        nil))

(setq initial-scratch-message "
;; I'm sorry, Emacs Live failed to start correctly.
;; Hopefully the issue will be simple to resolve.
;;
;;                _.-^^---....,,--
;;            _--                  --_
;;           <          SONIC         >)
;;           |       BOOOOOOOOM!       |
;;            \._                   _./
;;               ```--. . , ; .--'''
;;                     | |   |
;;                  .-=||  | |=-.
;;                  `-=#$%&%$#=-'
;;                     | ;  :|
;;            _____.,-#%&$@%#&#~,._____
;;      May these instructions help you raise
;;                  Emacs Live
;;                from the ashes
")

(setq live-supported-emacsp t)

(when (version< emacs-version "24.4")
  (setq live-supported-emacsp nil)
  (setq initial-scratch-message (concat "
;;                _.-^^---....,,--
;;            _--                  --_
;;           <          SONIC         >)
;;           |       BOOOOOOOOM!       |
;;            \._                   _./
;;               ```--. . , ; .--'''
;;                     | |   |
;;                  .-=||  | |=-.
;;                  `-=#$%&%$#=-'
;;                     | ;  :|
;;            _____.,-#%&$@%#&#~,._____
;;
;; I'm sorry, Emacs Live is only supported on Emacs 24.4+.
;;
;; You are running: " emacs-version "
;;
;; OS X GUI     - http://emacsformacosx.com/
;; OS X Console - via homebrew (http://mxcl.github.com/homebrew/)
;;                brew install emacs
;; Windows      - http://alpha.gnu.org/gnu/emacs/windows/
;; Linux        - Consult your package manager or compile from source

"))
  (let* ((old-file (concat (file-name-as-directory "~") ".emacs-old.el")))
    (if (file-exists-p old-file)
      (load-file old-file)
      (error (concat "Oops - your emacs isn't supported. Emacs Live only works on Emacs 24.4+ and you're running version: " emacs-version ". Please upgrade your Emacs and try again, or define ~/.emacs-old.el for a fallback")))))

(let ((emacs-live-directory (getenv "EMACS_LIVE_DIR")))
  (when emacs-live-directory
    (setq user-emacs-directory emacs-live-directory)))

(when live-supported-emacsp
;; Store live base dirs, but respect user's choice of `live-root-dir'
;; when provided.
(setq live-root-dir (if (boundp 'live-root-dir)
                          (file-name-as-directory live-root-dir)
                        (if (file-exists-p (expand-file-name "manifest.el" user-emacs-directory))
                            user-emacs-directory)
                        (file-name-directory (or
                                              load-file-name
                                              buffer-file-name))))

(setq
 live-tmp-dir      (file-name-as-directory (concat live-root-dir "tmp"))
 live-etc-dir      (file-name-as-directory (concat live-root-dir "etc"))
 live-pscratch-dir (file-name-as-directory (concat live-tmp-dir  "pscratch"))
 live-lib-dir      (file-name-as-directory (concat live-root-dir "lib"))
 live-packs-dir    (file-name-as-directory (concat live-root-dir "packs"))
 live-autosaves-dir(file-name-as-directory (concat live-tmp-dir  "autosaves"))
 live-backups-dir  (file-name-as-directory (concat live-tmp-dir  "backups"))
 live-custom-dir   (file-name-as-directory (concat live-etc-dir  "custom"))
 live-load-pack-dir nil
 live-disable-zone nil)

;; create tmp dirs if necessary
(make-directory live-etc-dir t)
(make-directory live-tmp-dir t)
(make-directory live-autosaves-dir t)
(make-directory live-backups-dir t)
(make-directory live-custom-dir t)
(make-directory live-pscratch-dir t)

;; Load manifest
(load-file (concat live-root-dir "manifest.el"))

;; load live-lib
(load-file (concat live-lib-dir "live-core.el"))

;;default packs
(let* ((pack-names '("foundation-pack"
                     "colour-pack"
                     "lang-pack"
                     "power-pack"
                     "git-pack"
                     "org-pack"
                     "clojure-pack"
                     "bindings-pack"))
       (live-dir (file-name-as-directory "stable"))
       (dev-dir  (file-name-as-directory "dev")))
  (setq live-packs (mapcar (lambda (p) (concat live-dir p)) pack-names) )
  (setq live-dev-pack-list (mapcar (lambda (p) (concat dev-dir p)) pack-names) ))

;; Helper fn for loading live packs

(defun live-version ()
  (interactive)
  (if (called-interactively-p 'interactive)
      (message "%s" (concat "This is Emacs Live " live-version))
    live-version))

;; Load `~/.emacs-live.el`. This allows you to override variables such
;; as live-packs (allowing you to specify pack loading order)
;; Does not load if running in safe mode
(let* ((pack-file (concat (file-name-as-directory "~") ".emacs-live.el")))
  (if (and (file-exists-p pack-file) (not live-safe-modep))
      (load-file pack-file)))

;; Load all packs - Power Extreme!
(mapc (lambda (pack-dir)
          (live-load-pack pack-dir))
        (live-pack-dirs))

(setq live-welcome-messages
      (if (live-user-first-name-p)
          (list (concat "Hello " (live-user-first-name) ", somewhere in the world the sun is shining for you right now.")
                (concat "Hello " (live-user-first-name) ", it's lovely to see you again. I do hope that you're well.")
                (concat (live-user-first-name) ", turn your head towards the sun and the shadows will fall behind you.")
                )
        (list  "Hello, somewhere in the world the sun is shining for you right now."
               "Hello, it's lovely to see you again. I do hope that you're well."
               "Turn your head towards the sun and the shadows will fall behind you.")))


(defun live-welcome-message ()
  (nth (random (length live-welcome-messages)) live-welcome-messages))

(when live-supported-emacsp
  (setq initial-scratch-message (concat live-ascii-art-logo " Version " live-version
                                                                (if live-safe-modep
                                                                    "
;;                                                     --*SAFE MODE*--"
                                                                  "
;;"
                                                                  ) "
;;           http://github.com/overtone/emacs-live
;;
;; "                                                      (live-welcome-message) "

")))
)

(if (not live-disable-zone)
    (add-hook 'term-setup-hook 'zone))

(if (not custom-file)
    (setq custom-file (concat live-custom-dir "custom-configuration.el")))
(when (file-exists-p custom-file)
  (load custom-file))

(message "\n\n Pack loading completed. Your Emacs is Live...\n\n")
(put 'downcase-region 'disabled nil)


(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (add-to-list
   'package-archives
   '("gnu" . "http://elpa.gnu.org/packages/")
   t)
  (add-to-list
   'package-archives
   '("marmalade" . "https://marmalade-repo.org/packages/")
   t)
  (package-initialize))


;; Find File in project
(autoload 'find-file-in-project "find-file-in-project" nil t)
(autoload 'find-file-in-project "find-file-in-project-by-selected" nil t)
(autoload 'find-file-in-project "find-directory-in-project-by-selected" nil t)

;; Snippets
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        ))

;; Gomode
(setenv "GOPATH" "/Users/abel/development/goWorkspace")
(setenv "GOBIN" "/Users/abel/development/goWorkspace/bin")
(setq default-tab-width 2)

(add-to-list 'load-path "/Users/abel/development/goWorkspace/src/github.com/dougm/goflymake")
(require 'go-flymake)

;;flycheck
(require 'go-flycheck)

(add-hook 'before-save-hook #'gofmt-before-save)

;; Elm mode
(add-to-list 'load-path "~/.emacs.d/elm-mode")
(require 'elm-mode)

;; Javascript
(setq js-indent-level 2)
(setq-default js2-basic-offset 2)

;; Python
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(add-hook 'python-mode-hook '(lambda ()
  (setq python-indent 2)))

;; Databases
(setq sql-connection-alist
		 '((swipe-local (sql-product 'mysql)
                    (sql-server "localhost")
										(sql-port 3306)
										(sql-user "root")
										(sql-password "")
										(sql-database "channels"))
       (pairwith-local (sql-product 'postgres)
                       (sql-port 5432)
                       (sql-server "localhost")
                       (sql-user "")
                       (sql-password "")
                       (sql-database "pairwith"))
       (entelo-local (sql-product 'mysql)
                     (sql-port 3306)
                     (sql-server "localhost")
                     (sql-user "root")
                     (sql-password "")
                     (sql-database "reputedly_development"))))
