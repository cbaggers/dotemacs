;;--------------------------------;
;; Misc Handy Functions
;;--------------------------------;

(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))

(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))

(defun kill-invisible-unicode-chars () "Query replace Unicode some invisible Unicode chars.
The chars to be searched are:
 RIGHT-TO-LEFT MARK 8207 x200f
 ZERO WIDTH NO-BREAK SPACE 65279 xfeff
start on cursor position to end."
       (interactive)
       (let ()
         (query-replace-regexp "\u200B\\|\u200f\\|\ufeff" "")))

;;-------------------
;; clears any buffer

(defun term/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;;------------------------
;; Jump to matching paren

(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))
(global-set-key (kbd "\C-c )") `goto-match-paren)

;;--------------------------------;
;; splitting the root window

(defun my-split-root-window (size direction)
  (split-window (window-parent)
                (and size (prefix-numeric-value size))
                direction))

(defun split-add-window-below (&optional size)
  (interactive "P")
  (my-split-root-window size 'below))

(defun split-add-window-right (&optional size)
  (interactive "P")
  (my-split-root-window size 'right))

(defun split-add-window-left (&optional size)
  (interactive "P")
  (my-split-root-window size 'left))

;;--------------------------------
;; Remove text styling (nice when copying things from eww or repl

(defun remove-text-styling ()
  (interactive)
  (let ((inhibit-read-only t))
    (set-text-properties (point-min) (point-max) nil)))
