(use-package flycheck
  :ensure t
  :config
  (bind-key "M-n" 'flycheck-next-error flycheck-mode-map)
  (bind-key "M-p" 'flycheck-previous-error flycheck-mode-map))
