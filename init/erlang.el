;;--------------------------------;
;; Erlang
;;--------------------------------;

(setq load-path
      (cons "/home/baggers/Code/erlang/emacs/"
            load-path))
(require 'erlang-start)

;;------------------------------------------------------------
;; Paredit

(defun my/erlang-paredit-space-for-delimiter-p (endp delimiter)
  ;; https://gist.github.com/luisgerhorst/139601a977e9291471e4
  ;; Function which always returns nil -> never insert a space
  ;; when insert a parentheses.
  nil)

(defun my/disable-paredit-spaces-before-paren ()
  ;; Set this function locally as only predicate to
  ;; check when determining if a space should be inserted
  ;; before a newly created pair of parentheses.
  (setq-local paredit-space-for-delimiter-predicates
              '(my/erlang-paredit-space-for-delimiter-p)))

(add-hook 'erlang-mode-hook 'my-erlang-edit-hook)
(add-hook 'erlang-shell-mode-hook 'my-erlang-edit-hook)

(defun my-erlang-edit-hook ()
  (paredit-mode +1)
  (my/disable-paredit-spaces-before-paren))

;;------------------------------------------------------------

;; prevent annoying hang-on-compile
(defvar inferior-erlang-prompt-timeout t)
(setq inferior-erlang-machine-options
      '("-name" "emacs@vanguard0.com"
        "-setcookie" "cookie"
        "-remsh" "vanguard@vanguard0.com"))

;;------------------------------------------------------------

(use-package flierl
  :bind ((:map erlang-mode-hook
               ("C-c C-c" . flycheck-buffer)
               ("M-p" . flycheck-previous-error)
               ("M-n" . flycheck-next-error)))
  :config
  (flierl-setup)
  (add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
  (setq flycheck-check-syntax-automatically
        ;;'(save idle-change new-line mode-enabled)
        '(mode-enabled save)))

(defun my-erlang-mode-hook ()
  (flycheck-mode))




