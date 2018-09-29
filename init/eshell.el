;;--------------------------------;
;; EShell Stuff
;;--------------------------------;

(use-package eshell
  :bind (("\C-c C-e" . term/clear)
         ("\C-c e" . term/clear))
  :config
  ;; (add-hook 'eshell-mode-hook 'eshell-bookmark-setup)
  (setf async-shell-command-buffer 'rename-buffer))


