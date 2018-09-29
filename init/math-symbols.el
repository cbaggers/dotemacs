;;--------------------------------;
;; Math Chars
;;--------------------------------;

(use-package xah-math-input
  :config  
  (xah-math-input-mode)
  (global-set-key (kbd "M-l")
                (lambda ()
                  (interactive)
                  (insert
                   (make-char 'greek-iso8859-7 107))))
  (xah-math-input--add-to-hash
   '(["shrug" "¯\\_(ツ)_/¯"]))
  :bind
  (("M-SPC" . xah-math-input-change-to-symbol)))



