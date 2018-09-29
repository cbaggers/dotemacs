;;--------------------------------;
;; Temp Files
;;--------------------------------;

;; stop emacs saving temp files in the directory hierarchy
;; this is mainly so it doesnt pollute machines I work with
;; over tramp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
