;;--------------------------------;
;; Paredit!
;;--------------------------------;

(use-package paredit
  :ensure t)

;; From https://gist.github.com/luisgerhorst/139601a977e9291471e4
(defun my/disable-paredit-spaces-before-paren ()
  ;; Function which always returns nil -> never insert a space when insert a parentheses.
  (defun my/erlang-paredit-space-for-delimiter-p (endp delimiter) nil)
  ;; Set this function locally as only predicate to check when determining if a space should be inserted
  ;; before a newly created pair of parentheses.
  (setq-local paredit-space-for-delimiter-predicates '(my/erlang-paredit-space-for-delimiter-p)))
