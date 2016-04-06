;; Personal emacs configuration

;; GLOBAL SETTINGS

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
(setq js-indent-level 4)
(setq x-stretch-cursor 1)

;; Zoom in/out
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(require 'package)

(setq package-archives
      '(
	("gnu" . "http://elpa.gnu.org/packages/")
	("org" . "http://orgmode.org/elpa/")
	("melpa-stable" . "http://stable.melpa.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	)
      )
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(load-theme 'misterioso)

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

;; DOCKER

(use-package dockerfile-mode
  :ensure t)

;; EDITING

(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'")
(put 'narrow-to-region 'disabled nil)

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" "\\.MD\\'"))
