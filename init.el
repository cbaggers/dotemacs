;;------------------------------------------------------------

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;;------------------------------------------------------------

(load-user-file "init/early.el")
(load-user-file "init/exwm.el")
(load-user-file "init/cosmetic.el")
(load-user-file "init/misc.el")

;; relied on my packages below
(load-user-file "init/paredit.el")
(load-user-file "init/flycheck.el")
(load-user-file "init/yasnippet.el")
(load-user-file "init/company.el")

;; And the rest :)
(load-user-file "init/ansi-term.el")
(load-user-file "init/avy.el")
(load-user-file "init/c-cpp.el")
(load-user-file "init/csharp.el")
(load-user-file "init/dired.el")
(load-user-file "init/docker.el")
(load-user-file "init/editorconfig.el")
(load-user-file "init/elisp.el")
(load-user-file "init/erlang.el")
(load-user-file "init/eshell.el")
(load-user-file "init/ibuffer.el")
(load-user-file "init/jekyll.el")
(load-user-file "init/lisp.el")
(load-user-file "init/math-symbols.el")
(load-user-file "init/multiple-cursors.el")
(load-user-file "init/osx.el")
(load-user-file "init/processes.el")
(load-user-file "init/rcirc.el")
(load-user-file "init/sql.el")
(load-user-file "init/tmp-files.el")
(load-user-file "init/twitter.el")
(load-user-file "init/uno.el")
(load-user-file "init/version-control.el")
(load-user-file "init/xml.el")
(load-user-file "init/yasnippet.el")

;;------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wheatgrass)))
 '(grep-command "grep --color -nHirI -e \"\" *")
 '(grep-find-command
   (quote
    ("find . -type f -exec grep --color -nH --null -e  \\{\\} +" . 49)))
 '(grep-find-template
   "find <D> <X> -type f <F> -exec grep <C> -nH --null -e <R> \\{\\} +")
 '(grep-highlight-matches (quote auto))
 '(grep-template "grep <X> <C> -nH --null -e <R> <F>")
 '(grep-use-null-device nil)
 '(grep-use-null-filename-separator t)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (markdown-mode yasnippet company-omnisharp company omnisharp :omnisharp flycheck docker ac-slime auto-complete auto-complete-config magit csharp-mode column-marker avy editorconfig multiple-cursors use-package paredit exwm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(trailing-whitespace ((t nil)))
 '(whitespace-empty ((t nil)))
 '(whitespace-line ((t nil)))
 '(whitespace-newline ((t (:foreground "grey9" :weight normal))))
 '(whitespace-space ((t (:foreground "grey9"))))
 '(whitespace-tab ((t (:foreground "gray9"))))
 '(whitespace-trailing ((t nil))))
