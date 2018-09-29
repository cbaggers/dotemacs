;;--------------------------------;
;; ANSI TERM
;;--------------------------------;

;; Stop yasnippet fucking up the tab completion
(add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))

;; Makes ansi term awesome
;; Taken from: http://emacs-journey.blogspot.co.uk/2012/06/improving-ansi-term.html

(defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer))
    ad-do-it))
(ad-activate 'term-sentinel)

(defvar my-term-shell "/bin/bash")

(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))

(ad-activate 'ansi-term)

(defun my-term-use-utf8 ()
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(add-hook 'term-exec-hook 'my-term-use-utf8)

(defun my-term-paste (&optional string)
  (interactive)
  (process-send-string (get-buffer-process (current-buffer))
                       (if string string (current-kill 0))))

(defun my-term-hook ()
  (goto-address-mode)
  (define-key term-raw-map "\C-y" 'my-term-paste)
  (define-key term-raw-map "\C-w" 'kill-region)
  (define-key term-raw-map "\M-w" 'copy-region-as-kill)
  (define-key term-raw-map "\C-c\C-e" 'term/clear)
  (define-key term-raw-map "\C-ce" 'term/clear)
  (define-key term-raw-map (kbd "\C-c o") 'other-frame))

(add-hook 'term-mode-hook 'my-term-hook)
