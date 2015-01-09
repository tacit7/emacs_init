(require 'elscreen)
;;(elscreen-start)

(define-key global-map (kbd "s-t") 'elscreen-create)
(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)

; Either close the current elscreen, or if only one screen, use the ":q" Evil
; command; this simulates the ":q" behavior of Vim when used with tabs.
(defun vimlike-quit ()
  "Vimlike ':q' behavior: close current window if there are split windows;
otherwise, close current tab (elscreen)."
  (interactive)
  (let ((one-elscreen (elscreen-one-screen-p))
        (one-window (one-window-p))
        )
    (cond
     ; if current tab has split windows in it, close the current live window
     ((not one-window)
      (delete-window) ; delete the current window
      (balance-windows) ; balance remaining windows
      nil)
     ; if there are multiple elscreens (tabs), close the current elscreen
     ((not one-elscreen)
      (elscreen-kill)
      nil)
     ; if there is only one elscreen, just try to quit (calling elscreen-kill
     ; will not work, because elscreen-kill fails if there is only one
     ; elscreen)
     (one-elscreen
      (evil-quit)
      nil)
     )))
; A function that behaves like Vim's ':tabe' commnad for creating a new tab and
; buffer (the name "[No Name]" is also taken from Vim).
(defun vimlike-:tabe ()
  "Vimlike ':tabe' behavior for creating a new tab and buffer."
  (interactive)
  (let ((buffer (generate-new-buffer "[No Name]")))
      ; create new tab
      (elscreen-create)
      ; set window's buffer to the newly-created buffer
      (set-window-buffer (selected-window) buffer)
      ; set state to normal state
      (with-current-buffer buffer
        (evil-normal-state))
    )
  )
(define-key evil-normal-state-map ",n" 'vimlike-:tabe)
(defun get-alist (key alist)
  (cdr (assoc key alist)))

(provide 'elscreen-buffer-list)
(require 'elscreen)

;; From escreen.el
(defun buffer-dead-p (buffer)
  (not (static-if (fboundp 'buffer-live-p)
           (buffer-live-p buffer)
         ;; Emacs 18 doesn't have buffer-live-p.
         ;; Killed buffers have no names.
         (buffer-name buffer))))

;; From escreen.el
(defun reorder-buffer-list (new-list)
  "Set buffers in NEW-LIST to be the most recently used, in order."
  (when new-list
    (let (firstbuf buf)
      (while new-list
        (setq buf (car new-list))
        (when (stringp buf)
          (setq buf (get-buffer buf)))
        (unless (buffer-dead-p buf)
          (bury-buffer buf)
          (unless firstbuf
            (setq firstbuf buf)))
        (setq new-list (cdr new-list)))
      (setq new-list (buffer-list))
      (while (not (eq (car new-list) firstbuf))
        (bury-buffer (car new-list))
        (setq new-list (cdr new-list))))))


(defun elscreen-get-buffer-list (screen)
  "Return buffer-list of SCREEN."
  (let ((screen-property (elscreen-get-screen-property screen)))
    (get-alist 'buffer-list screen-property)))

(defun elscreen-set-buffer-list (screen buflist)
  "Set buffer-list of SCREEN to BUFLIST."
  (let ((screen-property (elscreen-get-screen-property screen)))
    (set-alist 'screen-property 'buffer-list buflist)
    (elscreen-set-screen-property screen screen-property)))

(defun elscreen-save-buffer-list (&optional screen)
  "Save the buffer-list order for SCREEN, or current screen"
  (elscreen-set-buffer-list (or screen
                                (elscreen-get-current-screen))
                            (buffer-list)))

(defun elscreen-load-buffer-list (&optional screen)
  "Set emacs' buffer-list order to that of SCREEN, or current screen"
  (reorder-buffer-list (elscreen-get-buffer-list
                        (or screen
                            (elscreen-get-current-screen)))))

(defadvice elscreen-goto-internal (around manage-buffer-list activate)
  "Manage screen-specific buffer lists."
  (when (and elscreen-buffer-list-enabled
             (elscreen-screen-live-p (elscreen-get-previous-screen)))
    (elscreen-save-buffer-list (elscreen-get-previous-screen)))
  ad-do-it
  (when elscreen-buffer-list-enabled
    (elscreen-load-buffer-list (elscreen-get-current-screen))))

(defcustom elscreen-buffer-list-enabled nil
  "Whether to save and load screen-local buffer lists."
  :type 'boolean
  :group 'elscreen)

(defun toggle-elscreen-buffer-list (&optional arg)
  (interactive "P")
  (setq elscreen-buffer-list-enabled
        (cond ((null arg) (not elscreen-buffer-list-enabled))
              (> arg 0)))
  (message "Screen-specific buffer lists %s"
	   (if elscreen-buffer-list-enabled "enabled" "disabled")))

(fset 'enable-elscreen-buffer-list
      (apply-partially 'toggle-elscreen-buffer-list 1))
(fset 'disable-elscreen-buffer-list
      (apply-partially 'toggle-elscreen-buffer-list 0))
 (defun elscreen-frame-title-update ()
   (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
     (let* ((screen-list (sort (elscreen-get-screen-list) '<))
 	   (screen-to-name-alist (elscreen-get-screen-to-name-alist))
 	   (title (mapconcat
 		   (lambda (screen)
 		     (format "%d%s %s"
 			     screen (elscreen-status-label screen)
 			     (get-alist screen screen-to-name-alist)))
 		   screen-list " ")))
       (if (fboundp 'set-frame-name)
 	  (set-frame-name title)
 	(setq frame-title-format title)))))
 
 (eval-after-load "elscreen"
   '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))
