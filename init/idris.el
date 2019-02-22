(use-package idris-mode
  :ensure t
  ;; :bind ("C-<tab>" . avy-goto-char)
  ;; (:map dired-mode-map
  ;;       ("C-c C-c" . wdired-change-to-wdired-mode)
  ;;       ("Q" . dired-do-query-replace-regexp))
  :config
  (setq idris-interpreter-path "/home/baggers/.cabal/bin/idris")
  ;; (add-hook 'csharp-mode-hook 'my-csharp-hook)
  ;; (bind-key "M-n" 'flycheck-next-error flycheck-mode-map)
  ;; (bind-key "M-p" 'flycheck-previous-error flycheck-mode-map)
  )
