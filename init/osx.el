(when is-osx
  (setq mac-command-modifier 'meta)
  (setenv "PATH" (concat "/opt/local/bin:/opt/local/sbin:" (getenv "PATH"))))
