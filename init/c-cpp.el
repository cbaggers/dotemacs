;;--------------------------------;
;; C/C++ Programming
;;--------------------------------;

(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))
;; OPTIONAL, some users need specify extra flags forwarded to compiler
(setq cppcm-extra-preprocss-flags-from-user '("-I/usr/local/lib/fbx/include/" "-DNDEBUG"))
