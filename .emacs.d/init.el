;;; Config todo.
;; Merge my auto margin functions and settings.
;; Make ivy and swiper search fuzzy.
;; Enable parenthesis match highlighting.
;; Enable variable pitch fonts in text-modes and install mixed-pitch.
;; Rebind org-todo (t) to Enter key.
;; Set org-todo states.
;; Install yasnippet and copy over snippets.

;; User info.
(setq user-full-name "Matthew Batson"
      user-mail-address "mbatson@protonmail.com")

;; Visual Settings.
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(setq visible-bell t)
(setq inhibit-startup-screen t)

;; Font Settings.
(cond ((string= (system-name) "OREB")
       (set-face-attribute 'default nil :font "Source Code Pro" :height 130))
      (t
       (set-face-attribute 'default nil :font "Source Code Pro" :height 110)))

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

;; Make ESC quit prompts.
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Org-mode config.
(setq org-directory "~/OneDrive/Documents/org/")
(setq org-default-notes-file "~/OneDrive/Documents/org/notes.org")
(setq org-agenda-files (list "~/OneDrive/Documents/Uni/"
                             "~/OneDrive/Documents/org/todo.org"))

;; Custom org-capture templates.
(setq org-capture-templates
      '(("u" "Uni Task" entry
	(file+headline "~/OneDrive/Documents/Uni/uni-planner.org" "Todo")
	"* TODO %?"
	:prepend t :kill-buffer t)))


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
;; doom-plain-dark, doom-plain.
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
  (ivy-use-virtual-buffers t)
  :config (ivy-mode 1))

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
  :config (evil-mode 1))

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
    ;; Insert keybindings.
    "i m" (lambda () (interactive) (insert (char-from-name "EM DASH")))
    "i n" (lambda () (interactive) (insert (char-from-name "EN DASH")))
    "i '" (lambda () (interactive) (insert (char-from-name "RIGHT SINGLE QUOTATION MARK")))
    "i M-'" (lambda () (interactive) (insert (char-from-name "LEFT SINGLE QUOTATION MARK")))
    "i \"" (lambda () (interactive) (insert (char-from-name "RIGHT DOUBLE QUOTATION MARK")))
    "i M-\"" (lambda () (interactive) (insert (char-from-name "LEFT DOUBLE QUOTATION MARK")))
    ;; Org keybindings.
    "o a" 'org-agenda
    "o c" 'org-capture
    ;; Quit keybindings.
    "q q" 'save-buffers-kill-terminal
    ;; Search keybindings.
    "s s" 'swiper
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
					shift
					todo
					heading)))))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

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
    "i" "insert"
    "i m" "Em dash"
    "i n" "En dash"
    "i '" "Right single quotation mark / Apostrophe"
    "i M-'" "Left single quotation mark"
    "i \"" "Right double quotation mark"
    "i M-\"" "left double quotation mark"
    "o" "org"
    "q" "quit"
    "s" "search"
    "w" "window")
  (which-key-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(undo-fu-session evil-collection doom-modeline doom-themes evil-org evil-surround evil-leader undo-fu which-key evil ivy-rich counsel diminish ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )