(tool-bar-mode -1) ;;; no tool bar
(global-linum-mode 1) ; all files have line numbers
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
