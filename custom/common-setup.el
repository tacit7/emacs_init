(tool-bar-mode -1) ;;; no tool bar
(setq auto-save-default nil);; no auto save
(global-hl-line-mode 1) ; highlight the current line
(setq linum-relative-current-symbol "") ; just the line number for the current line
(setq ispell-program-name "aspell") ; use aspell qor spelling corrections
 (setq ring-bell-function 'ignore)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq dired-use-ls-dired nil)					; auto save files in temp file
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(global-set-key (kbd "C-d") 'delete-backward-char)
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(global-set-key (kbd "C-c j") 'tacit7/new-journal-entry)
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))


(global-set-key (kbd "s-s") 'save-buffer-always)
(global-linum-mode 1) ; all files have line numbers
(defun keep-search-highlight ()
  (interactive)
  (setq lazy-highlight-max-at-a-time nil)
  )


(defun tacit7/isearch-forward-keep-highlight (&optional regexp-p no-recursive-edit)
  (interactive "P\np")
  (setq lazy-highlight-cleanup nil)
  (isearch-mode t (not (null regexp-p)) nil (not no-recursive-edit)))

(defun tact7/isearch-clean-highlight ()
  (interactive)
  (lazy-highlight-cleanup)
  (setq lazy-highlight-cleanup 1))

(defun tacit7/new-journal () (org-journal-new-entry nil))
(defun periodically-run-journal ()
  "Every 30 mins, run the journal so you can record progress."
  (interactive)
  (run-at-time 0  (* 60 30) 'tacit7/new-journal))

;;;
