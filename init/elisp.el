;;--------------------------------;
;; ELisp Stuff
;;--------------------------------;

(defun init-my-ielm-stuff ()
  (paredit-mode +1))

(add-hook 'ielm-mode-hook 'init-my-ielm-stuff)

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()
   ;; (column-marker-3 80)
   (paredit-mode +1)
   (eldoc-mode +1)
   (define-key emacs-lisp-mode-map (kbd "C-c C-c") 'compile-defun)))
