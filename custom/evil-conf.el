(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump t)
(setq evil-toggle-key "C-`")
(setq evil-want-C-u-scroll t)
(setq evil-auto-indent t)

(require 'evil)
(require 'evil-leader)
(require 'evil-surround)
(global-evil-surround-mode 1)
(evil-mode 1)
(global-evil-leader-mode)

; modes that do not need to be in evil mode
(add-to-list 'evil-emacs-state-modes 'dirtree-mode )

(defun switch-to-last-buffer ()
  "Switch to the previously selected buffer in the current window."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer)) nil t))
(define-key evil-normal-state-map (kbd "C-6") 'switch-to-last-buffer)


(defun tacit7/evil-comment-xmp ()
    (interactive)
    (evil-append-line 0)
    (insert "    # =>")
    (evil-normal-state))

(defun evil-add-blank-line ()
    (interactive)
    (evil-open-below 1)
    (evil-normal-state))

(defun tacit7/binding-pry ()
  "Insert binging.pry and then save the file"
  (interactive)
  (evil-open-below 1)
  (insert "binding.pry")
  (evil-normal-state)
  (save-buffer))
(defun tacit7/eval-region ()
  "Evaluate the current line"
  (interactive)
  (evil-visual-line 1)
  (eval-region))

(defun tacit7/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(define-key evil-normal-state-map ",c" 'tacit7/evil-comment-xmp)
(define-key evil-normal-state-map "\C-p" 'helm-projectile)
(define-key evil-normal-state-map "gor" 'helm-mini)
(define-key evil-normal-state-map "gom" 'helm-imenu)
(define-key evil-normal-state-map "gol" 'org-store-link)

(define-key evil-normal-state-map (kbd "gb") 'ido-switch-buffer)
(define-key evil-normal-state-map (kbd "s") 'ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "f") 'ace-jump-char-mode)
(define-key evil-normal-state-map (kbd "C-SPC") 'helm-M-x)

(define-key evil-normal-state-map (kbd "C-w q") 'elscreen-kill)
(define-key evil-normal-state-map (kbd "C-<ret>") 'evil-add-blank-line)
(define-key evil-normal-state-map "J" 'evil-join)
(add-to-list 'evil-emacs-state-modes 'nav-mode)
(add-to-list 'evil-emacs-state-modes 'neotree-mode)


;;; Naviagtion
(define-key evil-normal-state-map (kbd "C-i") 'evil-scroll-up)

;;; Emacs
(global-evil-leader-mode)
(global-set-key (kbd "M-x") 'helm-M-x)

;;; Leader stuff
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "d" 'neotree-toggle
  "D" 'dired
  "w" 'ace-jump-word-mode
  "l" 'ace-jump-line-mode
  "c" 'ace-jump-char-mode
  "j" 'helm-M-x
  "k" 'kill-buffer
  "e" 'eval-region
  "bp" 'tacit7/binding-pry
  "f" 'projectile-find-file)
;;; some hack to get indetation working
(define-key evil-insert-state-map [remap newline] 'newline)
(define-key evil-insert-state-map [remap newline-and-indent] 'newline-and-indent)


;;; evil-conf ends here
