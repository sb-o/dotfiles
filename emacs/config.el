; Load in system-specific variables
(let ((file "~/.emacs.d/local.el"))
  (when (file-exists-p file)
    (load file)))
(defun check-variables-set (variable-list)
  "Check if variables in VARIABLE-LIST are set and print a warning if not."
  (dolist (var variable-list)
    (unless (boundp var)
      (message "Warning: Variable `%s' is not set" var))))

(check-variables-set '(sb-org-default-file sb-org-agenda-files sb-org-archive-file sb-org-roam-directory sb-org-roam-rootfile))

(setq initial-buffer-choice sb-org-default-file)

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
(unless (file-exists-p custom-file)
  (with-temp-buffer
    (write-file custom-file)))
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

(global-unset-key (kbd "C-x f"))
(global-set-key (kbd "C-x f") 'find-file)

(when window-system
 (set-frame-size (selected-frame) 100 60))

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

(load-theme 'deeper-blue)

; Improve readability
(set-face-attribute 'default nil :height 150) ; Set font
(setq-default line-spacing 0.25) ; Set line spacing

; Fixes
(set-face-attribute 'default nil :foreground "white") ; lighter text
(set-face-attribute 'shadow nil :foreground "grey90") ; lighter text
(set-face-attribute 'org-ellipsis nil :foreground "yellow" :underline nil) ; Don't underline ellipsis
(set-face-attribute 'mode-line nil :background "blue25" :foreground "white")
(set-face-attribute 'mode-line-inactive nil :background "gray50")
(set-face-attribute 'mode-line-buffer-id nil :foreground "SkyBlue1")

; Org outline tweaks
(set-face-attribute 'outline-1 nil :height 155)

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

(use-package org
  :init
  (setq initial-major-mode 'org-mode)
  (setq org-hide-leading-stars t)
  (setq org-startup-indented t)
  (setq org-ellipsis " ▾") 
  (setq org-hide-emphasis-markers t)
  (setq org-cycle-separator-lines 1)
  (setq org-M-RET-may-split-line nil)
  (setq org-clock-string-limit 50)
  (setq org-agenda-files sb-org-agenda-files)
  ;(setq org-archive-location sb-org-archive-file)
  (setq org-log-done 'time)
 )

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region   (match-beginning 1) (match-end 1) "•"))))))

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-deadline-warning-days 4)
;(setq org-agenda-span 7)
(setq org-agenda-start-on-weekday nil)

; More concise "scheduled" and "deadline" descriptors in org-agenda
(setq org-agenda-scheduled-leaders '("s: " "s.%dx: "))
(setq org-agenda-deadline-leaders '("d: " "%3dd: " "%2dd ago: "))

; Add new line between each date line
(setq org-agenda-format-date
        (lambda (date)
          (concat "\n" (org-agenda-format-date-aligned date))))

(use-package org-roam
  :custom
  (org-roam-directory sb-org-roam-directory)
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
    :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n#+bibliography: Roam.bib\n")
    :unnarrowed t)))
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ;("C-c n g" . org-roam-graph)
   ("C-c n i" . org-roam-node-insert)
   ("C-c n c" . org-roam-capture)
   ("C-c n r" . (lambda() (interactive)(find-file sb-org-roam-rootfile))))
  )
  :config
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)

(use-package org-tidy
  :config
 (add-hook 'org-mode-hook #'org-tidy-mode)
)

(use-package gptel
  :config
  (setq gptel-api-key sb-chatgpt-api-key)
  )

(defun remove-eol-chars ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t)
    (replace-match "")))

(bind-key "C-c z" 'gptel-send)

(defvar sb-llm (make-sparse-keymap) "sb LLM")
(bind-key "C-c x" sb-llm)
(bind-key "z" 'gptel-menu sb-llm)

(defvar sb-actions (make-sparse-keymap) "sb Actions")
(bind-key "C-c c" sb-actions)
(bind-key "i" 'org-indent-block sb-actions)
(bind-key "m" 'remove-eol-chars sb-actions)

(which-key-add-key-based-replacements
  "C-c c" "sb actions"
  )

(defvar sb-views (make-sparse-keymap) "sb Views")
(bind-key "C-c v" sb-views)
(bind-key "t" 'org-tidy-toggle sb-views)

(which-key-add-key-based-replacements
  "C-c v" "sb views"
)

(defvar sb-bookmarks (make-sparse-keymap) "sb Bookmarks")
(bind-key "C-c b" sb-bookmarks)
(bind-key "c" (lambda () (interactive) (find-file "~/.emacs.d/config.org")) sb-bookmarks)
(bind-key "h" (lambda () (interactive) (find-file "~/sb/Org/homebox.org")) sb-bookmarks)
(which-key-add-key-based-replacements
  "C-c b" "sb bookmarks"
  "C-c b c" "config.org"
  "C-c b h" "homebox.org"
  )
