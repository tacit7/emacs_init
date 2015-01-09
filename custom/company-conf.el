(global-company-mode t)
(push 'company-robe company-backends)
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "<backtab>") 'company-complete-common)

(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))
