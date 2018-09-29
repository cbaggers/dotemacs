;;; Auto-Complete
(use-package auto-complete
  :ensure t
  ;; :bind ("M-`" . auto-complete)
  :config
  (progn
    (ac-config-default)
    (setq ac-auto-start nil)
    (setq ac-use-fuzzy t)))
