
(defun tramp-cleanup ()
  (interactive)
  (tramp-cleanup-all-buffers)
  (tramp-cleanup-all-connections)
  (setf tramp-default-proxies-alist nil))

(defun tramp-cleanup-proxies-alist ()
  (interactive)
  (setf tramp-default-proxies-alist nil))

;; Fuck yeah agent forwarding so we can multi hop
;; using publickey through aws
(defun add-ssh-agent-to-tramp ()
  (cl-pushnew '("-A")
              (cadr (assoc 'tramp-login-args
                           (assoc "ssh" tramp-methods)))
              :test #'equal))
(add-ssh-agent-to-tramp)
