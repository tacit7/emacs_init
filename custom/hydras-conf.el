;;;;
;; (defhydra persp-hydra 
;;   "Hydra for perspective-mode."
;;   ("t" persp-switch "Create or switch persp.")
;;   ("j" persp-next   "Switch to next perspective.")
;;   ("k" persp-prev   "Switch to previous perspective.")
;;   ("K" persp-kill   "Kill perspective.")
;;   ("D" persp-remove-buffer "Remoce buffer from perspective.")
;;   ("r" persp-rename "Rename perspective.")
;;     ("a" persp-add-buffer "Add current buffer to the current perspective."))

(defhydra hydra-rotate-text (global-map "C-c r")
  "Rotate Text"
  ("r" rotate-text "next")
  ("R" rotate-text-backward "previous"))

(defhydra hydra-rotate-text (global-map "C-z")
 
	("j" elscreen-next "next")
	("k" elscreen-previous "prev")
	("n" elscreen-screen-nickname "nickname")
	("c" elscreen-create "new a"))

(defhydra hydra-evil-kindow (global-map "C-w")
  "Window movement."
  ("j" evil-window-down "move down")
  ("k" evil-window-up "move up")
  ("h" evil-window-left "move to the left")
  ("l" evil-window-right "move to the right")
  ("L" evil-window-move-far-right "move window to the right")
  ("H" evil-window-move-far-left "move window to the left")
  ("=" balance-windows "move window to the left")
	("r" evil-window-rotate-downwards "Rotate window.")
	("i" ugm/increase-height-5 "increase height")
	("d" ugm/decrease-height-5 "decrease height")
	("I" ugm/increase-width-5 "increase width")
	("D" ugm/decrease-width-5 "decreate width"))

(defun ugm/increase-width-5 ()
	(interactive)
	(evil-window-increase-width 5))

(defun ugm/decrease-width-5 ()
	(interactive)
	(evil-window-decrease-width 5))

(defun ugm/increase-height-5 ()
	(interactive)
	(evil-window-increase-height 5))

(defun ugm/decrease-height-5 ()
	(interactive)
	(evil-window-decrease-width 5))
