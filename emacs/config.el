;; PACKAGE MANAGER
(require 'package)
(setq package-archives '(
    ("gnu"   . "https://elpa.gnu.org/packages/")
    ("melpa" . "https://melpa.org/packages/")
    ("org" . "https://orgmode.org/elpa/")
))
(package-initialize) 
(unless package-archive-contents
    (package-refresh-contents))
(unless (package-installed-p 'use-package)
    (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
(require 'bind-key)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq ring-bell-function 'ignore)

(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

; To disable menu bar
(menu-bar-mode -1)

; To disable on emacsclient
(setq tool-bar-mode nil)
(setq scroll-bar-mode nil)
(setq tooltip-mode nil)

; To disable on emacs GUI
(if (or (display-graphic-p) window-system)
(progn (tool-bar-mode -1) (scroll-bar-mode -1) (tooltip-mode -1))
)

(setq backup-directory-alist
	`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
	`((".*" ,temporary-file-directory t)))

(setq vc-follow-symlinks t)

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-s") 'save-buffer)

(global-visual-line-mode t)

(use-package kaolin-themes 
     :config
     (load-theme 'kaolin-galaxy t)
 )

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package which-key
:init
(which-key-mode))

(use-package vertico
  :ensure t
  :init (vertico-mode))

(use-package consult)

(use-package orderless
  :ensure t
  :custom (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))) ; recommended settings

(use-package marginalia
  ; :bind (:map minibuffer-local-map ("M-A" . marginalia-cycle)) ; allows you to cycle it on or off
  :init (marginalia-mode))

(use-package evil
  :init
  (setq evil-want-C-i-jump nil)
  (setq evil-want-keybinding nil) 
  (setq evil-want-fine-undo t) 
  :config
  (evil-mode 1)
  )
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
  )
(use-package evil-org
  :after (org evil-collection)
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)
  )

(setq initial-major-mode 'org-mode)
(setq org-ellipsis " ▾") 
(setq org-M-RET-may-split-line nil)
