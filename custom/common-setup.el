(tool-bar-mode -1) ;;; no tool bar
(setq auto-save-default nil);; no auto save
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

;; Use only homerow keys for ace-jump
; (setq ace-jump-mode-move-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?A ?S ?D ?F ?G ?H ?J ?K ?L))

(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))


(global-set-key (kbd "s-s") 'save-buffer-always)


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

(defun geoforce-journal-start ()
  "Every 30 mins, run the journal so you can record progress."
  (interactive)
  (run-at-time 0  (* 60 30) 'tacit7/new-journal))


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
;; to setup tabs
;;;
