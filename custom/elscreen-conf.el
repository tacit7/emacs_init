(require 'elscreen)
;;(elscreen-start)

(setq elscreen-tab-display-control nil)
(setq elscreen-tab-display-kill-screen nil)
(defun get-alist (key alist)
    (cdr (assoc key alist)))

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

(defun elscreen-frame-title-update ()
  (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
    (let* ((screen-list (sort (elscreen-get-screen-list) '<))
 	   (screen-to-name-alist (elscreen-get-screen-to-name-alist))
 	   (title (mapconcat
 		   (lambda (screen)
 		     (format " %s%d: %s"
 			    (elscreen-status-label screen " ") screen
 			     (get-alist screen screen-to-name-alist)))
 		   screen-list "    ")))
      (if (fboundp 'set-frame-name)
 	  (set-frame-name title)
 	(setq frame-title-format title)))))

(setq elscreen-display-tab nil)
(eval-after-load "elscreen"
  '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))
(elscreen-start)


(defun elscreen-status-label (screen &optional default)
  (let ((default (or default " "))
        (current-screen (elscreen-get-current-screen))
        (previous-screen (elscreen-get-previous-screen)))
    (cond
     ((eq screen current-screen) "★")
     ((eq screen previous-screen) "")
     (t default))))
