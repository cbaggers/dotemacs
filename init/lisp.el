;;--------------------------------;
;; Common Lisp
;;--------------------------------;

;; slime setup
(when (file-exists-p (expand-file-name "~/quicklisp/slime-helper.el"))
  (use-package slime
    :init
    (load (expand-file-name "~/quicklisp/slime-helper.el"))
    :bind
    (("C-c C-v C-v" . slime-vari-describe-symbol))
    :config
    (setq slime-lisp-implementations
	  '((sbcl  ("~/Programs/optirun-sbcl.sh") :coding-system utf-8-unix)
            ;; (sbcl "--dynamic-space-size" "2GB")
            ;; (sbcl  ("sbcl") :coding-system utf-8-unix)
	    ;; (ccl   ("~/Programs/ccl/lx86cl64"))
            )
	  slime-net-coding-system 'utf-8-unix
          slime-inhibit-pipelining nil
	  slime-contribs '(slime-fancy slime-repl slime-scratch slime-trace-dialog))
    (add-hook 'slime-load-hook            (lambda () (require 'slime-fancy)))
    (add-hook 'lisp-mode-hook             'my-lisp-mode-hook)
    (add-hook 'lisp-interaction-mode-hook 'my-lisp-mode-hook)
    (add-hook 'slime-repl-mode-hook       'my-lisp-repl-hook)))


(defun my-lisp-mode-hook ()
  (paredit-mode +1)  
  (column-marker-3 80)
  (setq indent-tabs-mode nil)
  (whitespace-mode 1))

(defun my-lisp-repl-hook ()
  (paredit-mode +1))

;; (load "/home/baggers/quicklisp/clhs-use-local.el" t)

;;--------------------------------
;; CEPL Related

(defun slime-vari-describe-symbol (symbol-name)
  "Describe the symbol at point."
  (interactive (list (slime-read-symbol-name "Describe symbol: ")))
  (when (not symbol-name)
    (error "No symbol given"))
  (let ((pkg (slime-current-package)))
    (slime-eval-describe
     `(vari.cl::vari-describe ,symbol-name nil ,pkg))))

;;--------------------------------
;; Helpers

(defun slime-inspect-macroexpand-1 ()
  (interactive)
  (slime-eval-async
      `(swank::to-string
        (swank:inspect-in-emacs
         (cl:macroexpand
          (swank::from-string
           ',(slime-sexp-at-point-or-error)))))))

(defun slime-inspect-macroexpand-all ()
  (interactive)
  (slime-eval-async
      `(swank::to-string
        (swank:inspect-in-emacs
         (swank-backend:macroexpand-all
          (swank::from-string
           ',(slime-sexp-at-point-or-error)))))))
