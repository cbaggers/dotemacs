;;--------------------------------;
;; c#
;;--------------------------------;

(use-package csharp-mode
  :ensure t
  :config
  (add-hook 'csharp-mode-hook 'my-csharp-hook)
  (bind-key "{" 'paredit-open-curly csharp-mode-map)
  (bind-key "}" 'paredit-close-curly csharp-mode-map)
  (use-package omnisharp
    :ensure t
    :config
    (setq omnisharp-server-executable-path "/home/baggers/Programs/omnisharp/myrun.sh")
    (bind-key "M-." 'omnisharp-go-to-definition csharp-mode-map)
    (bind-key "M-," 'pop-tag-mark csharp-mode-map)
    (bind-key "C-c C-w C-c" 'omnisharp-find-usages csharp-mode-map)
    (add-to-list 'company-backends 'company-omnisharp)))

(defun my-csharp-hook ()
  (paredit-mode 1)
  (omnisharp-mode 1)
  (my/disable-paredit-spaces-before-paren)
  (company-mode 1)
  (yas-minor-mode 1)
  (flycheck-mode 1))
