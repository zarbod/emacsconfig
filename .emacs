(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 2)
 '(custom-safe-themes
   '("21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" default))
 '(evil-undo-system 'undo-tree)
 '(fancy-splash-image "/home/zarbod/Downloads/lg.jpg")
 '(initial-buffer-choice "~/")
 '(package-selected-packages
   '(ayu-theme flycheck rust-mode company vterm-toggle vterm vertico evil-collection evil))
 '(warning-suppress-log-types '((lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package) (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(require 'evil)
(when (require 'evil-collection nil t)
  (evil-collection-init))

(evil-mode 1)

(load-theme 'tango-dark t)

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(vertico-mode 1)
(global-set-key (kbd "M-p") 'find-file)
(global-set-key (kbd "M-v") 'vterm-toggle)
(global-set-key (kbd "S-k") 'kill-buffer)
(global-set-key (kbd "S-q") 'kill-buffer-and-window)
(add-hook 'after-init-hook 'global-company-mode)
(global-undo-tree-mode 1)
(global-display-line-numbers-mode 1)


;; lsp and completion setup
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :custom
  (company-backends '(company-capf)))

(use-package lsp-mode
  :ensure t
  :hook (prog-mode . lsp-deferred)
  :custom
  (lsp-prefer-capf t)
  (lsp-auto-guess-root t)             
  (lsp-keep-workspace-alive nil))

;;; C programming hooks
(add-hook 'c-mode-hook #'flycheck-mode)

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
