;;--------------------------------;
;; Erlang
;;--------------------------------;

;; Hey chris, trying to remember how this works? :p
;;
;; The general idea is that we use our existing
;; scripts to spin up the docker instances. Then
;; we can navigate in using tramp and visit a file.
;; From there, when we C-c C-k inferior erlang is
;; going to use the erl from inside the container.
;; So far so good but we need to use epmdless so
;; we have custom inferior-erlang-machine-options.
;; With that we get a beautiful little repl session
;; however we also want flycheck and that is where
;; flierl comes in, it simply (and hackily) uses
;; the existing inferior-erlang session to compile
;; the code.

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

;; (setq inferior-erlang-machine-options
;;       '("-name" "emacs@vanguard0.com"
;;         "-setcookie" "cookie"
;;         "-remsh" "vanguard@vanguard0.com"))

;; Note: We use hidden here so that erlang:rpc doesnt include the
;;       shell by default. This matters as that node definitely
;;       will not have the app code loaded
(setq inferior-erlang-machine-options
      '("-env" "EPMDLESS_DIST_PORT" "18999"
        "-env" "EPMDLESS_REMSH_PORT" "18000"
        "-name" "emacs@vanguard0.com"
        "-hidden"
        "-setcookie" "cookie"
        "-remsh" "vanguard@vanguard0.com"
        "-proto_dist" "epmdless_proto"
        "-epmd_module" "epmdless_client"
        ;;"-pa" "/app/_build/default/lib/epmdless/ebin/"
        "-pa" "/app/lib/epmdless-0.1.4/ebin"))

(defun kill-erlang-repl-node ()
  (interactive)
  (message "Nuked: %s" (shell-command-to-string "ss -tlnp | grep 18999.*beam | grep -o 'pid=[0-9]*' | grep -o '[0-9]*' | xargs -I {} kill -9 {}")))

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
        '(save idle-change new-line mode-enabled)
        ;;'(mode-enabled save)
        ))

(defun my-erlang-mode-hook ()
  (flycheck-mode))
