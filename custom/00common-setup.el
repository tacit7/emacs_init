(require 'org-journal)
(require 'linum)
(require 'linum-relative)
(require 'helm)
(setq make-backup-files nil)


;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)


(setq explicit-shell-file-name "/bin/zsh")
(define-key global-map (kbd "RET") 'newline-and-indent) ;; Auto indent when you hit return
(tool-bar-mode -1) ; no tool bar
(global-linum-mode 1) ; all files have line numbers
(global-hl-line-mode 1) ; highlight the current line
(setq linum-relative-current-symbol "") ; just the line number for the current line
(setq ispell-program-name "aspell") ; use aspell for spelling corrections
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(add-hook 'ruby-mode-hook 'rubocop-mode)
 (setq ring-bell-function 'ignore)

					; auto save files in temp file
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;(setq initial-buffer-choice "~/repo/org-mode/start.org")
