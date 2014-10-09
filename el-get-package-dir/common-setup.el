(require 'org-journal)
(require 'linum)
(require 'linum-relative)
(require 'helm)
(tool-bar-mode -1) ;;; no tool bar
(global-linum-mode 1) ; all files have line numbers
(global-hl-line-mode 1) ; highlight the current line
(setq linum-relative-current-symbol "") ; just the line number for the current line
(setq ispell-program-name "aspell") ; use aspell qor spelling corrections
 (setq ring-bell-function 'ignore)
(add-hook 'after-init-hook #'global-flycheck-mode)
					; auto save files in temp file
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

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
;(setq initial-buffer-choice "~/repo/org-mode/start.org")
