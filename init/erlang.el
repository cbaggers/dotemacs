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
  (my/disable-paredit-spaces-before-paren)
  (define-key erlang-mode-map "\C-c\C-k" 'set-erl-options-and-compile))

;;------------------------------------------------------------

;; prevent annoying hang-on-compile
(defvar inferior-erlang-prompt-timeout t)

;; Note: We use hidden here so that erlang:rpc doesnt include the
;;       shell by default. This matters as that node definitely
;;       will not have the app code loaded

(defun set-erl-options ()
  (interactive)
  (let* ((remote (or (file-remote-p default-directory) ""))
         (vm-args-path-a
          (concat remote
                  "/app/_build/prod/rel/vanguard/releases/0.1.0/vm.args"))
         (vm-args-path-b
          (concat remote
                  "/app/releases/0.1.0/vm.args"))
         (vm-args-path-c
          (concat remote
                  "/app/_build/debug/rel/vanguard/releases/0.1.0/vm.args"))
         (vm-args-path
          (cond
           ((file-exists-p vm-args-path-a) vm-args-path-a)
           ((file-exists-p vm-args-path-b) vm-args-path-b)
           ((file-exists-p vm-args-path-c) vm-args-path-c)))
         (name-line
          (with-temp-buffer
            (insert-file-contents vm-args-path nil nil nil t)
            (cl-find-if (lambda (str) (string-prefix-p "-name" str))
                        (split-string (buffer-string) "\n" t))))
         (cookie-line
          (with-temp-buffer
            (insert-file-contents vm-args-path nil nil nil t)
            (cl-find-if (lambda (str) (string-prefix-p "-setcookie" str))
                        (split-string (buffer-string) "\n" t))))
         (epmdless-path-a
          "/app/_build/default/lib/epmdless/ebin/")
         (epmdless-path-b
          "/app/lib/epmdless-0.1.4/ebin")
         (epmdless-path
          (cond
           ((file-exists-p (concat remote epmdless-path-a))
            epmdless-path-a)
           ((file-exists-p (concat remote epmdless-path-b))
            epmdless-path-b))))    
    (cond
     ((not vm-args-path)
      (message "FAILED TO SET ERL OPTIONS: couldnt find vm-args path %s"
               remote))
     ((not epmdless-path)
      (message "FAILED TO SET ERL OPTIONS: couldnt find epmdless path %s"
               remote)
      nil)
     ((not cookie-line)
      (message "FAILED TO SET ERL OPTIONS: couldnt find cookie")
      nil)
     ((not name-line)
      (message "FAILED TO SET ERL OPTIONS: couldnt find name")
      nil)
     (t (let ((cookie (second (split-string cookie-line " " t)))
              (name (second (split-string name-line " " t))))
          (setq inferior-erlang-machine-options
                (list
                 "-env" "EPMDLESS_DIST_PORT" "18999"
                 "-env" "EPMDLESS_REMSH_PORT" "18000"
                 "-name" "emacs@vanguard0.com"
                 "-hidden"
                 "-setcookie" cookie
                 "-remsh" name
                 "-proto_dist" "epmdless_proto"
                 "-epmd_module" "epmdless_client"
                 "-pa" epmdless-path))
          (message "hmm %s" inferior-erlang-machine-options)
          t)))))

(defun set-erl-options-and-compile ()
  (interactive)
  (unless (get-buffer "*erlang*")
    (message "=> Setting erlang options")
    (set-erl-options))
  (erlang-compile))

(defun kill-erlang-repl-node ()
  (interactive)
  (message "Nuked: %s" (shell-command-to-string "ss -tlnp | grep 18999.*beam | grep -o 'pid=[0-9]*' | grep -o '[0-9]*' | xargs -I {} kill -9 {}")))

;;------------------------------------------------------------

(use-package flierl
  :bind  (:map erlang-mode-map
               ("C-c C-c" . flycheck-buffer)
               ("C-c C-k" . set-erl-options-and-compile)
               ("M-p" . flycheck-previous-error)
               ("M-n" . flycheck-next-error))
  :config
  (flierl-setup)
  (add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
  (setq flycheck-check-syntax-automatically
        '(save idle-change new-line mode-enabled)
        ;;'(mode-enabled save)
        ))

(defun my-erlang-mode-hook ()
  (flycheck-mode))
