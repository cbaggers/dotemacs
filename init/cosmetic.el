;;--------------------------------;
;; Cosmetic Stuff
;;--------------------------------;

(require 'column-marker)

(global-set-key (kbd "C-]") #'ignore)
(global-set-key (kbd "C-@") #'er/expand-region)
(setq ring-bell-function #'ignore)

(tool-bar-mode -1)
(menu-bar-mode -1)
(delete-selection-mode 1)
(setq inhibit-splash-screen t)
(fset `yes-or-no-p `y-or-n-p)
(show-paren-mode t)
(setq column-number-mode t)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; ham finger fixes
(defun my-kill-buffer (prefix buffer)
  (interactive "P\nbkill buffer: ")
  (if (window-dedicated-p (get-buffer-window buffer))
      (message "Cannot kill dedicated buffer")
    (kill-buffer buffer)))

(global-set-key (kbd "\C-x f") `find-file)
(global-set-key (kbd "\C-x \C-b") `switch-to-buffer)
(global-set-key (kbd "\C-x k") `my-kill-buffer)
(global-set-key (kbd "\C-x \C-k") `my-kill-buffer)
(global-set-key (kbd "\C-x \C-h") `mark-whole-buffer)
(global-set-key (kbd "ESC ESC ESC") 'hitting-the-wrong-key)
(global-set-key (kbd "\S-\M-k") `kill-line)

;; allowing meta+arrow keys to switch windows
(windmove-default-keybindings)

;; switch instances
(global-set-key (kbd "\C-c o") 'other-frame)
(global-set-key (kbd "\C-c \C-o") 'other-frame)

;;Kill that bloody insert key
(global-set-key [insert] (lambda () (interactive)))

;;Stop shift mouse click opening the font window
(global-set-key [(shift down-mouse-1)] 'ignore)
(global-set-key [(control down-mouse-1)] 'ignore)

(defun hide-mixed-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(setq-default indent-tabs-mode nil)
