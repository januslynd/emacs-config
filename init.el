   
;; Personal emacs configuration

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

(use-package magit
	     :pin melpa-stable
	     :ensure t
	     :bind ("C-x g" . magit-status)
	     :init (setq magit-last-seen-setup-instructions "1.4.0"))


(use-package multiple-cursors
	     :ensure t)

(use-package projectile
	     :ensure t)
;; PROGRAMMING LANGUAGES

(use-package groovy-mode
  :ensure t
  :mode "\\.groovy\\'")

(use-package haskell-mode
  :ensure t
  :mode ("\\.hs\\'" "\\.fr\\'"))

(use-package scala-mode
  :ensure t
  :mode "\\.scala\\'")
