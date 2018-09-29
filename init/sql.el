;;--------------------------------;
;; SQL
;;--------------------------------;

(defun sql-query-in-buffer (query)
  "List the details of a database table named NAME.
Displays the columns in the relation.  With optional prefix argument
ENHANCED, displays additional details about each column."
  (interactive "MQuery: ")
  (let ((sqlbuf (sql-find-sqli-buffer)))
    (unless sqlbuf
      (user-error "No SQL interactive buffer found"))
    (unless query
      (user-error "No query specified"))
    (sql-execute sqlbuf
                 (format "*SQL-QUERY: %s*" query) ;; destination buffer
                 (format "%s;" query) ;; ensure query is complete
                 nil nil)))
