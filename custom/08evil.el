(defun switch-to-last-buffer ()
  "Switch to the previously selected buffer in the current window."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer)) nil t))
(define-key evil-normal-state-map (kbd "C-6") 'switch-to-last-buffer)
