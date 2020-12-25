;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Matthew Batson"
      user-mail-address "mbatson@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(if (string= (system-name) "OREB") ; If on system with hostname "OREB"
    (setq doom-font (font-spec :family "Source Code Pro" :size 31 :weight 'normal))
  (setq doom-font (font-spec :family "Source Code Pro" :size 15 :weight 'normal)))

(setq doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 18))

;; Let mixed-pitch-mode inherit doom-variable-pitch-font's height
(setq mixed-pitch-set-height t)

;; Enable mixed-pitch-mode by default in modes suited for writing
(add-hook! '(org-mode-hook markdown-mode-hook) #'mixed-pitch-mode)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function.
;;
;; Themes I like: doom-one, doom-moonlight, doom-manegarm, doom-outrun-electric
(setq doom-theme 'doom-moonlight)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Maximise frames by default
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Turn on visual-line-mode for soft-wrapping
;;(add-hook 'markdown-mode-hook 'visual-line-mode)
;;(add-hook 'markdown-mode-hook #'+word-wrap-mode)

;; Keybinding for opening buffer clone in another window.
;; This allows independent folding in each window while working in the same buffer.
(map! :leader :desc "Clone indirect buffer" "b c"
      #'clone-indirect-buffer-other-window)

(map! :leader :desc "Find file other window" "f o" #'find-file-other-window)
(map! :leader :desc "Kill buffer and window" "b D" #'kill-buffer-and-window)

;; Character insertion keybindings
(map! :desc "Em dash" :nvi "M-i m" (lambda () (interactive)
                                     (insert (char-from-name "EM DASH"))))
(map! :desc "En dash" :nvi "M-i n" (lambda () (interactive)
                                     (insert (char-from-name "EN DASH"))))
(map! :desc "Apostrophe / Right single quotation mark"
      :nvi "M-i '"
      (lambda () (interactive)
        (insert (char-from-name "RIGHT SINGLE QUOTATION MARK"))))
(map! :desc "Left single quotation mark"
      :nvi "M-i M-'"
      (lambda () (interactive)
        (insert (char-from-name "LEFT SINGLE QUOTATION MARK"))))
(map! :desc "Right double quotation mark"
      :nvi "M-i \""
      (lambda () (interactive)
        (insert (char-from-name "RIGHT DOUBLE QUOTATION MARK"))))
(map! :desc "Left double quotation mark"
      :nvi "M-i M-\""
      (lambda () (interactive)
        (insert (char-from-name "LEFT DOUBLE QUOTATION MARK"))))

;; Set default mode based on file type
;; Currently unnecessary due to running talonscript-mode
;(add-to-list 'auto-mode-alist '("\\.talon\\'" . text-mode))

;; Set buffer-local value of fill-column for specific modes.
;; fill-column specifies the column at which lines will wrap when filling
;; regions/paragraphs or in visual-fill-column-mode.
(setq-hook! '(org-mode-hook markdown-mode-hook)
  fill-column 90)

;; Set the desired line length (in char columns) to be displayed.
;; This will be used to dynamically calculate margin widths that will always
;; keep the displayed width at this size even if the frame width changes
;; (unless width of frame < 'mb/displayed-line-length').
(defvar mb/displayed-line-length 90 "Desired line length (in char columns).")

(defun mb/margins-on ()
  "Turn centering margins on."
  ;; First, make sure visual-fill-column-mode is off.
  (visual-fill-column-mode -1)
  ;; Set margin widths so that the screen space always equals
  ;; mb/displayed-line-length, plus 3 to account for the space needed by line
  ;; numbers.
  (setq left-margin-width (/ (- (window-total-width)
                                (+ mb/displayed-line-length 3)) 2))
  (setq right-margin-width (/ (- (window-total-width)
                                 (+ mb/displayed-line-length 3)) 2))
  ;; Refresh screen to show new margin width.
  (set-window-buffer nil (current-buffer)))

(defun mb/margins-off ()
  "Turn centering margins off."
  (setq left-margin-width 0)
  (setq right-margin-width 0)
  ;; If in specified mode, switch visual-fill-column-mode on.
  (if (or (equal major-mode 'org-mode) (equal major-mode 'markdown-mode))
      (visual-fill-column-mode 1))
  ;; Refresh screen to show new margin width.
  (set-window-buffer nil (current-buffer)))

(defun mb/auto-set-margins ()
  "Turn mode on or off based on amount of windows."
  (cond ((= (count-windows 'ignore-minibuffer) 1)
         (mb/margins-on))
        (t
         (mb/margins-off))))

(define-minor-mode mb/center-margins-mode
  "Minor mode to center text in the current buffer."
  :init-value nil
  :global nil
  (cond (mb/center-margins-mode
         (add-hook 'window-configuration-change-hook 'mb/auto-set-margins
                   'append 'local)
         (mb/auto-set-margins)
         )
        (t
         (remove-hook 'window-configuration-change-hook 'mb/auto-set-margins 'local)
         (mb/margins-off)))
  )

(add-hook! ('org-mode-hook 'markdown-mode-hook) :append #'mb/center-margins-mode)

(defun mb/reset-margins (&rest args)
  "Set margins to zero to avoid size error when calling split-window."
  (setq left-margin-width 0)
  (setq right-margin-width 0)
  (set-window-buffer nil (current-buffer)))

;; Turn off margins before splitting window to avoid size too small for
;; splitting error.
(advice-add 'evil-window-vsplit :before #'mb/reset-margins)
