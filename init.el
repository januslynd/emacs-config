;;; package --- Something
;;; Commentary:

;; GLOBAL SETTINGS
;;; Code:

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; auto-save configuration
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; put all backup files in the same dir
(setq backup-directory-alist `(("." . "~/.saves")))

;; Tab indent
(setq-default indent-tabs-mode nil)
(setq-default tab-stop-list (number-sequence 4 120 4))
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(setq-default sgml-basic-offset 4)
(setq-default nxml-child-indent tab-width)
(setq-default nxml-outline-child-indent tab-width)
(setq x-stretch-cursor 1)

;; Zoom in/out
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(require 'package)

(setq package-archives
      '(
;;	("gnu" . "http://elpa.gnu.org/packages/")
;;	("org" . "http://orgmode.org/elpa/")
	("melpa-stable" . "http://stable.melpa.org/packages/")
;;	("melpa" . "http://melpa.org/packages/")
	)
      )
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(load-theme 'whiteboard)

;; GENERAL PURPOSE PACKAGES

(use-package magit
  :pin melpa-stable
  :ensure t
  :bind ("C-x g" . magit-status)
  :init (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package projectile
  :ensure t
  :init (projectile-global-mode))

(use-package ag
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :bind (("C-c m c" . mc/edit-lines)
	 ("C-M-j" . mc/mark-next-like-this)
	 ("C-M-k" . mc/mark-previous-like-this)))

(use-package neotree
  :ensure t
  :bind (([f8] . neotree-toggle))
  :config (setq neo-theme 'ascii))

;; DOCKER

(use-package dockerfile-mode
  :ensure t)

;; EDITING

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'")

(put 'narrow-to-region 'disabled nil)

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" "\\.MD\\'"))

;; PROGRAMMING LANGUAGES

(use-package groovy-mode
  :ensure t
  :mode ("\\.groovy\\'" "\\.gtpl\\'"))

(use-package haskell-mode
  :ensure t
  :mode ("\\.hs\\'" "\\.fr\\'"))

(use-package scala-mode
  :ensure t
  :mode "\\.scala\\'")

(use-package clojure-mode
  :ensure t
  :mode ("\\.clj\\'" "\\.cljs\\'"))

;; FRONT DEVELOPMENT

;; eslint will not work if using emacs in xorg mode
;; because in that mode shell variables are not
;; available, therefore emacs won't be able to find
;; eslint executable
(use-package exec-path-from-shell
  :ensure t
  :init
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

(use-package flycheck
  :ensure t
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; web-mode should have the javascript-eslint checker activated
(flycheck-add-mode 'javascript-eslint 'web-mode)

;;
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun my/use-eslint-from-node-modules ()
  "Use local eslint from node_modules before global."
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

;; sometimes latest flycheck can't find the xml parser to parse eslint output
(setq flycheck-xml-parser 'flycheck-parse-xml-region)

(use-package js2-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :mode ("\\.js\\'" "\\.jsx\\'"))

;; GENERATED CODE

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck js2-mode json-mode web-mode markdown-mode yaml-mode dockerfile-mode neotree multiple-cursors ag projectile magit use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

