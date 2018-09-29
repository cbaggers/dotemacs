;;--------------------------------;
;; IRC
;;--------------------------------;

(use-package rcirc
  :ensure t
  :config
  (add-hook 'irc-mode-hook 'my-irc-hook))

(defun my-irc-hook ()
  ;; Turn on spell checking.
  (flyspell-mode 1))

