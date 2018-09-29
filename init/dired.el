(use-package dired
  :bind
  (:map dired-mode-map
        ("C-c C-c" . wdired-change-to-wdired-mode)
        ("<M-return>" . open-file-externally)
        ("Q" . dired-do-query-replace-regexp)))

(defun open-file-externally ()
  "In dired, open the file named on this line."
  ;; this is old and pants, what the proper way?
  ;; at least make it work on win & osx
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process "gnome-open" nil 0 nil file)
    (message "Opening %s done" file)))

