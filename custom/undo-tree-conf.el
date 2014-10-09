(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t
      undo-tree-history-directory-alist `(("." . ,(expand-file-name "~/.emacs-undo/"))))

(defadvice undo-tree-make-history-save-file-name
  (after undo-tree-compressed activate)
  (setq ad-return-value (concat ad-return-value ".gz")))
