;;------------------------------------------------------------

(use-package exwm
  :ensure t
  :config
  (require 'exwm-config)
  (exwm-config-default)
  (ido-mode 0)  ;; fuck whoever forced ido on people
  (exwm-input-set-key (kbd "S-<right>") 'windmove-right)
  (exwm-input-set-key (kbd "S-<left>") 'windmove-left)
  (exwm-input-set-key (kbd "S-<up>") 'windmove-up)
  (exwm-input-set-key (kbd "S-<down>") 'windmove-down)
  ;; (exwm-input-set-key (kbd "s-n") 'invert-window)
  (setq exwm-input-simulation-keys
        '(;; movement
          ([?\C-b] . [left])
          ([?\M-b] . [C-left])
          ([?\C-f] . [right])
          ([?\M-f] . [C-right])
          ([?\C-p] . [up])
          ([?\C-n] . [down])
          ([?\C-a] . [home])
          ([?\C-e] . [end])
          ([?\M-v] . [prior])
          ([?\C-v] . [next])
          ([?\C-d] . [delete])
          ([?\C-k] . [S-end delete])
          ;; cut/paste.
          ([?\C-w] . [?\C-x])
          ([?\M-w] . [?\C-c])
          ([?\C-y] . [?\C-v])
          ;; search
          ([?\C-s] . [?\C-f]))))

;;------------------------------------------------------------

(defun invert-window ()
  (interactive)
  (start-process "" nil "do the magic"))
