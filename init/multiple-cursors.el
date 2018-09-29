(use-package multiple-cursors
  :ensure t
  :bind
  (("C-c ]" . mc/mark-next-like-this)
   ("C-c C-]" . mc/mark-next-like-this)
   ("C-c l" . mc/edit-lines)))
