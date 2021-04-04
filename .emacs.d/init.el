;; User info.
(setq user-full-name "Matthew Batson"
      user-mail-address "mbatson@protonmail.com")

;; Set default language encoding system to UTF-8.
(set-language-environment "UTF-8")

;; Set default major mode when creating a new buffer.
(setq-default major-mode 'text-mode)

;; Backup configuration.
(defvar --backup-directory (concat user-emacs-directory "backups"))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t	 ;; Ensure backups are turned on.
      version-control t          ;; Use version numbers for backups.
      kept-new-versions 10       ;; Number of newest versions to keep.
      kept-old-versions 0        ;; Number of oldest versions to keep.
      delete-old-versions t      ;; Don't ask to delete excess backup versions.
      backup-by-copying t        ;; Copy all files, don't rename them.
      vc-make-backup-files t)	 ;; Backup version-controlled files.

;; Ensure sure auto-save is turned on.
(setq auto-save-default t)

;; Visual Settings.
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(setq visible-bell t)
(setq inhibit-startup-screen t)

;; Font Settings.
(cond ((string= (system-name) "OREB")
       (set-face-attribute 'default nil :family "Source Code Pro" :height 130)
       (set-face-attribute 'variable-pitch nil :family "Source Sans Pro" :height 1.1))
      (t
       (set-face-attribute 'default nil :family "Source Code Pro" :height 110)
       (set-face-attribute 'variable-pitch nil :family "Source Sans Pro" :height 1.1)))

;; Modeline.
(column-number-mode 1)

;; Line Numbers.
(setq display-line-numbers-type 'visual)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

;; Line mode.
(add-hook 'text-mode-hook 'visual-line-mode)

;; Maximise frames by default.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Highlight matching parentheses.
(show-paren-mode 1)

;; Make ESC quit prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Org-mode config.
(setq org-directory "~/OneDrive/Documents/org/")
(setq org-default-notes-file "~/OneDrive/Documents/org/notes.org")
(setq org-agenda-files (list "~/OneDrive/Documents/Uni/"
                             "~/OneDrive/Documents/org/todo.org"))

;; Begin org-agenda view on current day.
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day "today")

;; Custom org-capture templates.
(setq org-capture-templates
      '(("u" "Uni Task" entry
	(file+headline "~/OneDrive/Documents/Uni/uni-planner.org" "Todo")
	"* TODO %^{Task title} %^g\n DEADLINE: %^{DEADLINE}t%?"
	:prepend t :kill-buffer t)))

;; Set org-todo states.
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(sequence "|" "CANCELLED(c)")))

;; Set default encoding of .fountain files to utf-8.
(modify-coding-system-alist 'file ".fountain'" 'utf-8)

;; Set TAB key to complete the thing at point if appropriate,
;; otherwise indent the current line.
(setq tab-always-indent 'complete)


;;; Package Management.

;; Initialise package sources.
(require 'package) ; Make sure package is installed.

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package unless it's already installed.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Theme Settings.
;; Themes I like: doom-one, doom-moonlight, doom-manegarm, doom-outrun-electric
;; doom-plain-dark, doom-plain, doom-flatwhite.
(use-package doom-themes
  :config
  ;; Global settings (defaults).
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-moonlight t)

  ;; Enable flashing mode-line on errors.
  (doom-themes-visual-bell-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; doom-modeline requires all-the-icons font pack.
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  ;; Enable word count in major modes determined by
  ;; doom-modeline-continuous-word-count-modes.
  (setq doom-modeline-enable-word-count t))

;; Install diminish (hides minor modes from the mode line).
;; Can be toggled with :diminish flag in use-package call).
(use-package diminish)

;; Install and configure ivy, counsel, swiper, and ivy-rich.
(use-package ivy
  :defer 0.1
  :diminish ivy-mode
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :custom
  (ivy-count-format "(%d/%d) ")
  :config
  ;; Set regex matching behaviour.
  (setq ivy-re-builders-alist '((t . ivy--regex-ignore-order)))
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :config (ivy-rich-mode 1))

(use-package counsel
  :after ivy
  :diminish counsel-mode
  :config (counsel-mode 1))

(use-package swiper
  :after ivy)

;; Evil
(use-package evil
  :init
  ;; Necessary for evil-collection.
  (setq evil-want-keybinding nil)

  ;; Move pointer according to visual lines rather than logical lines
  (setq evil-respect-visual-line-mode t)

  (setq evil-undo-system 'undo-fu)

  ;; global-evil-leader-mode should be enabled before evil-mode
  ;; so that evil-leader is enabled in initial buffers like *scratch*.
  (global-evil-leader-mode 1)

  :config
  ;; Character insertion keybindings.
  ;; Note these bindings overwrite tab-to-tab-stop in insert mode.
  (evil-define-key 'insert 'global (kbd "M-i m")
    (lambda () (interactive) (insert (char-from-name "EM DASH"))))
  (evil-define-key 'insert 'global (kbd "M-i n")
    (lambda () (interactive) (insert (char-from-name "EN DASH"))))
  (evil-define-key 'insert 'global (kbd "M-i '")
    (lambda () (interactive) (insert (char-from-name "RIGHT SINGLE QUOTATION MARK"))))
  (evil-define-key 'insert 'global (kbd "M-i M-'")
    (lambda () (interactive) (insert (char-from-name "LEFT SINGLE QUOTATION MARK"))))
  (evil-define-key 'insert 'global (kbd "M-i \"")
    (lambda () (interactive) (insert (char-from-name "RIGHT DOUBLE QUOTATION MARK"))))
  (evil-define-key 'insert 'global (kbd "M-i M-\"")
    (lambda () (interactive) (insert (char-from-name "LEFT DOUBLE QUOTATION MARK"))))

  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-leader
  :after evil
  :init
  ;; Enable leader key in all modes with use of prefix
  ;; (defined by evil-leader/non-normal-prefix).
  (setq evil-leader/in-all-states t)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ;; Buffer keybindings.
    "`" (lambda () (interactive) (switch-to-buffer nil))
    "b s" 'save-buffer
    "b b" 'ivy-switch-buffer
    "b c" 'clone-indirect-buffer-other-window
    "b k" 'kill-buffer
    "b x" 'kill-buffer-and-window
    ;; Desktop keybindings.
    "d c" 'desktop-clear
    "d r" 'desktop-read
    "d s" 'desktop-save
    ;; File keybindings.
    "f f" 'find-file
    "f o" 'find-file-other-window
    "f r" 'counsel-recentf
    "f s" 'save-buffer
    ;; Org keybindings.
    "o a" 'org-agenda
    "o c" 'org-capture
    "o s p" 'org-set-property
    "o s t" 'org-set-tags-command
    "o t" 'org-todo
    ;; Quit keybindings.
    "q q" 'save-buffers-kill-terminal
    ;; Search keybindings.
    "s r" 'counsel-rg
    "s s" 'swiper-isearch
    ;; Theme keybindings.
    "t l" 'counsel-load-theme
    ;; Version control keybindings.
    "v d" 'vc-diff
    ;; Window keybindings.
    "w s" 'evil-window-split
    "w v" 'evil-window-vsplit
    "w n" 'evil-window-next
    "<SPC>" 'evil-window-next
    "w h" 'evil-window-left
    "w j" 'evil-window-down
    "w k" 'evil-window-up
    "w l" 'evil-window-right
    "w H" 'evil-window-move-far-left
    "w J" 'evil-window-move-very-bottom
    "w K" 'evil-window-move-very-top
    "w L" 'evil-window-move-far-right
    "w d" 'delete-window
    "w m" 'delete-other-windows))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-org
  :after org
  :hook ((org-mode . evil-org-mode)
	 (org-agenda-mode . evil-org-mode)
	 ;; Sets of keybindings to enable.
	 (evil-org-mode . (lambda () (evil-org-set-key-theme
				      '(textobjects
					insert
					navigation
					additional
					calendar
					return)))))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; Fancy auto-completion everywhere using a wrapper around built-in
;; dabbrev-expand.
(use-package fancy-dabbrev
  :config
  (evil-define-key 'insert 'global (kbd "<tab>") 'fancy-dabbrev-expand-or-indent)
  (evil-define-key 'insert 'global (kbd "<backtab>") 'fancy-dabbrev-backward)
  ;; Override dabbrev-expand with
  ;; indent-for-tab-command. dabbrev-expand is replaced by
  ;; fancy-dabbrev-expand-or-indent on TAB and I want to retain an
  ;; explicit binding for indent-for-tab-command for
  ;; completion-at-point access (gives completion of Emacs functions
  ;; and variables).
  (evil-define-key 'insert 'global (kbd "M-/") 'indent-for-tab-command)

  (setq fancy-dabbrev-preview-context 'everywhere)

  ;; Let dabbrev searches ignore case and expansions preserve case.
  ;; TRY CASE REPLACE TRUE
  (setq dabbrev-case-distinction nil)
  (setq dabbrev-case-fold-search t)
  (setq dabbrev-case-replace nil)

  (global-fancy-dabbrev-mode 1))
  

;; Fountain-mode for screenwriting in the Fountain markup language.
(use-package fountain-mode)

(use-package markdown-mode
  :init
  ;; Set the external Markdown processor.
  (setq markdown-command "pandoc"))

;; Enable the use of a mix of variable pitch and fixed pitch fonts.
(use-package mixed-pitch
  :config
  (setq mixed-pitch-set-height t)
  (add-hook 'org-mode-hook 'mixed-pitch-mode)
  (add-hook 'markdown-mode-hook 'mixed-pitch-mode))

;; Undo package for undo in evil-mode.
;; Use by setting evil-undo-system variable.
(use-package undo-fu)

;; Writes undo history to a file for persistence between emacs sessions.
;; ERROR: Doesn't seem to work on Windows 10. undo-fu-session-save gives error
;; mentioning file not found and gzip. Consider raising an issue on gitlab.
(use-package undo-fu-session
  :after undo-fu
  :config
  (global-undo-fu-session-mode 1))

(use-package visual-fill-column
  :custom
  (visual-fill-column-width 80)
  (visual-fill-column-center-text t)
  :config
  ;; Turn visual-fill-column-mode on whenever visual-line-mode is active.
  (add-hook 'visual-line-mode-hook #'visual-fill-column-mode)

  ;; Refresh margins automatically when adjusting text scale.
  (advice-add 'text-scale-adjust :after #'visual-fill-column-adjust))

;; which-key
(use-package which-key
  :diminish which-key-mode
  :config
  ;; Replacement descriptions for specified keys.
  (which-key-add-keymap-based-replacements evil-leader--default-map
    "`" "Switch to last buffer"
    "b" "buffer"
    "d" "desktop"
    "f" "file"
    "o" "org"
    "o s" "set"
    "q" "quit"
    "s" "search"
    "t" "theme"
    "v" "version control"
    "w" "window")
  (which-key-add-keymap-based-replacements evil-insert-state-map
    "M-i m" "Em dash"
    "M-i n" "En dash"
    "M-i '" "Right single quotation mark / Apostrophe"
    "M-i M-'" "Left single quotation mark"
    "M-i \"" "Right double quotation mark"
    "M-i M-\"" "left double quotation mark")
  (which-key-mode 1))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(fancy-dabbrev markdown-mode mixed-pitch yasnippet visual-fill-column-mode visual-fill-column fountain-mode undo-fu-session evil-collection doom-modeline doom-themes evil-org evil-surround evil-leader undo-fu which-key evil ivy-rich counsel diminish ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
