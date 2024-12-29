;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq projectile-project-se
      '("~/Desktop/"))
;; Needed to add javascript-eslint to the the next-checker after lsp so that it would actually load, as that wasn't happening by deafult
;; also needed to runit after the lsp-afer-initalize-hook because otherwise 'lsp wasn't a valid checker
;; (add-hook 'lsp-after-initialize-hook (lambda
;;                                        ()
;;                                        (flycheck-add-next-checker 'lsp 'javascript-eslint)))

;; Potential alternative to the above
;; (after! (:and lsp-mode flycheck)
;; (flycheck-add-next-checker 'lsp 'javascript-eslint))

;; https://emacs-lsp.github.io/lsp-mode/page/lsp-typescript/#available-configurations
;; lsp performance settings
(setq lsp-eslint-run "onSave")
;; (setq +format-with-lsp nil) ; We want something that will respect our prettierrc to do this instead. Also I don't know how to configure this yet.
(setq lsp-eslint-format nil)
(setq lsp-enable-file-watchers nil)

(after! lsp-eslint
  (setq lsp-eslint-auto-fix-on-save t)) ; Enable ESLint auto-fix on save

(after! lsp-mode
  (add-hook 'typescript-mode-hook #'lsp)
  (add-hook 'typescript-mode-hook (lambda ()
                                    (setq +format-with :none)
                                    (flycheck-add-next-checker 'lsp 'javascript-eslint)))
  ;; Enable lsp-mode in web-mode
  (add-hook 'web-mode-hook #'lsp)
  (add-hook 'web-mode-hook (lambda () (setq +format-with-lsp t))))


(setq +format-with-lsp nil) ; Disable LSP-based formatting
;; (setq-hook! 'typescript-mode-hook +format-with :none) ; Disable Doom's formatter for TypeScript


;; Recommendations from https://ianyepan.github.io/posts/emacs-ide/
;; (setq lsp-auto-guess-root t)
(setq lsp-log-io nil)
;; (setq lsp-restart 'auto-restart)
(setq lsp-enable-symbol-highlighting t)
(setq lsp-enable-on-type-formatting nil)
;; (setq lsp-signature-auto-activate nil)
;; (setq lsp-signature-render-documentation nil)
;; (setq lsp-eldoc-hook nil)
(setq lsp-modeline-code-actions-enable t)
(setq lsp-modeline-diagnostics-enable nil)
(setq lsp-headerline-breadcrumb-enable nil)
;; (setq lsp-semantic-tokens-enable nil)
(setq lsp-enable-folding nil)
(setq lsp-enable-imenu t)
(setq lsp-enable-snippet nil)
(setq read-process-output-max (* 1024 1024)) ;; 1MB
(setq lsp-idle-delay 0.25)  



;; Run eslint fixes on save
(add-hook 'before-save-hook 'lsp-eslint-apply-all-fixes)

;; ;; Enable lsp-mode in web-mode
;; (add-hook 'web-mode-hook #'lsp)
;; (add-hook 'web-mode-hook (lambda () (setq +format-with-lsp t)))

;; ;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; Set the Option key as the Meta key
(setq mac-option-modifier 'meta)


;; (use-package tide
;;   :ensure t
;;   :hook (typescript-mode . tide-setup)
;;   :config
;;   (setq tide-tsserver-process-environment '("TSSERVER_PATH=/usr/local/bin/tsserver")))

;; (add-hook 'typescript-mode-hook #'tide-setup)
;; (add-hook 'typescript-mode-hook #'tide-hl-identifier-mode)  ;; Optional: Highlights current identifier
 
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; I don't want to use any autosaving
;; ;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

;; ;; if you use typescript-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; ;; if you use treesitter based typescript-ts-mode (emacs 29+)
;; (add-hook 'typescript-ts-mode-hook #'setup-tide-mode)


;; config.el - Emacs configuration for TypeScript development in a monorepo

;; Ensure use of local TypeScript version from node_modules
(setq tide-tsserver-program (expand-file-name "node_modules/.bin/tsserver" default-directory))

 ;; Install necessary packages for TypeScript and LSP support
(use-package lsp-mode
  :ensure t
  :hook ((typescript-mode . lsp)
         (js-mode . lsp))
  :commands lsp
  :config
  ;; Optional: Set the lsp log level to debug if you want detailed logs for troubleshooting
  (setq lsp-log-io t)
  (setq lsp-prefer-flymake nil) ;; Prefer Flycheck over Flymake

  ;; Automatically enable LSP for TypeScript files
  (add-hook 'typescript-mode-hook #'lsp)
  (add-hook 'js-mode-hook #'lsp))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :config
  ;; Optional: Enable LSP UI enhancements like documentation popups, code actions, etc.
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-sideline-show-hover t))

(after! (evil copilot)
  ;; Define the custom function that either accepts the completion or does the default behavior
  (defun my/copilot-tab-or-default ()
    (interactive)
    (if (and (bound-and-true-p copilot-mode)
             ;; Add any other conditions to check for active copilot suggestions if necessary
             )
        (copilot-accept-completion)
      (evil-insert 1))) ; Default action to insert a tab. Adjust as needed.

  ;; Bind the custom function to <tab> in Evil's insert state
  (evil-define-key 'insert 'global (kbd "<tab>") 'my/copilot-tab-or-default))


(use-package lsp-mode
  :hook ((prog-mode . lsp))
  :config
  ;; Keybinding for finding definitions
  (define-key lsp-mode-map (kbd "s-d") 'lsp-find-definition)) ;; Disable lsp-mode in emacs-lisp-mode for Doom Emacs
(after! lsp-mode
  (add-to-list 'lsp-disabled-clients 'emacs-lisp-mode)) 

(use-package exec-path-from-shell
     :config
     (exec-path-from-shell-initialize))
