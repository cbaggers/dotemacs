;;--------------------------------;
;; Version Control Stuff
;;--------------------------------;

(use-package magit
  :ensure t
  :bind (("\C-c \C-g" . magit-status))
  :config
  (setq magit-diff-refine-hunk 'all)
  (add-hook 'magit-mode-hook 'my-magit-hook))

(defun my-magit-hook ()
  (magit-add-section-hook 'magit-status-sections-hook
                          'magit-insert-unpushed-to-upstream
                          'magit-insert-unpushed-to-upstream-or-recent
                          'replace))



