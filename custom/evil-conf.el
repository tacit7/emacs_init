;;; package --- Summary:
;;; Commentary:
;;; Code:
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump t)
(setq evil-want--i-jump t)
(setq evil-toggle-key "C-`")
(setq evil-auto-indent t)
(setq evil-want-fine-undo 'fine)
(require 'evil)
(require 'evil-leader)
(require 'evil-surround)
(require 'evil-snipe)
(global-evil-snipe-mode 1)

;; Optional!
(evil-snipe-replace-evil) ;; replaces evil-mode's f/F/t/T/;/, with snipe
(evil-snipe-enable-nN)    ;; enable repeating with n/N (not implemented)

;; not necessary if using (evil-snipe-replace-evil)
(evil-snipe-enable-sS)    ;; enable repeating with s/S
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
  "Insert a '# =>' so that xmp can insert ruby evaluations."

    (interactive)
    (evil-append-line 0)
    (insert "    # =>")
    (evil-normal-state))

(defun tacit7/evil-xmp-comment-and-eval()
  "Insert the comment string and eval the file."
  (interactive)
  (tacit7/evil-comment-xmp)
  (xmp))

(defun tacit7/isearch-next ()
  "Function written for evil mode.  This is so that ; can go the next occurance."
  (isearch-forward nil nil))

(defun evil-add-blank-line ()
    (interactive)
    (evil-open-below 1)
    (evil-normal-state))

(defun tacit7/binding-pry ()
  "Insert binging pry and then save the file."
  (interactive)
  (evil-open-below 1)
  (insert "binding.pry")
  (evil-normal-state)
  (save-buffer))

(defun tacit7/open-org-tickets ()
  "Open the tickets file on org mode."
  (interactive)
  (find-file "/Users/umaldonado/repo/org-mode/tickets.org"))

(defun tacit7/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

					;insert mode key maps
(define-key evil-insert-state-map "\C-f" 'sp-forward-slurp-sexp)
(define-key evil-insert-state-map "\C-b" 'sp-backward-slurp-sexp)


;; normal mode key maps
(define-key evil-normal-state-map "\C-p" 'helm-projectile)
(define-key evil-normal-state-map "gor" 'helm-mini)
(define-key evil-normal-state-map "gom" 'helm-imenu)
(define-key evil-normal-state-map "gol" 'org-store-link)
(define-key evil-normal-state-map "got" 'tacit7/open-org-tickets)

(define-key evil-normal-state-map (kbd "gb") 'helm-buffers-list)
(define-key evil-normal-state-map (kbd "C-SPC") 'helm-M-x)


(define-key evil-normal-state-map (kbd "C-<ret>") 'evil-add-blank-line)
(define-key evil-normal-state-map "J" 'evil-join)
(add-to-list 'evil-emacs-state-modes 'nav-mode)




(add-to-list 'evil-emacs-state-modes 'dired-mode)
(eval-after-load 'elscreen-conf
  (progn
    (message "elscreen conf has been loaded")
    (global-set-key (kbd "s-t") 'elscreen-create)
    (define-key evil-normal-state-map (kbd "C-w q") 'vimlike-quit)
    (evil-ex-define-cmd "q[uit]" 'vimlike-quit)))


(eval-after-load 'neotree
  (progn
    (message "neotree has been loaded"
	     (add-hook 'neotree-mode-hook
		       (lambda ()
			 (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
			 (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
			 (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
			 (define-key evil-normal-state-local-map (kbd "j") 'next-line)
			 (define-key evil-normal-state-local-map (kbd "k") 'previous-line)
			 (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
	     )))
(evil-add-hjkl-bindings eshell-mode-map 'normal
  (kbd "M-j") 'eshell-previous-input                   ; "j"
  (kbd "M-k") 'eshell-next-input )   ; "k")

(evil-add-hjkl-bindings shell-mode-map 'normal
  (kbd "M-j") 'comint-previous-input
  (kbd "M-k") 'comint-next-input)

;; Screens
(global-set-key (kbd "s-t") 'make-frame-command)
(define-key evil-normal-state-map (kbd "1 t") (other-frame 0))


;;; Naviagtion
(define-key evil-normal-state-map (kbd "C-i") 'evil-scroll-up)

;;; Emacs
(global-evil-leader-mode)
(global-set-key (kbd "M-x") 'helm-M-x)

;;; Leader stuff
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "t" 'other-frame
  "x" 'tacit7/evil-comment-xmp
  "X" 'tacit7/evil-xmp-comment-and-eval
  "d" 'neotree-toggle
  "D" 'dired
  "w" 'ace-jump-word-mode
  "s" 'sp-forward-slurp-sexp
  "S" 'sp-backward-slurp-sexp
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




;; ElScreen
(define-key evil-normal-state-map (kbd "s-1") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-normal-state-map (kbd "s-2") (lambda() (interactive) (elscreen-goto 1)))
(define-key evil-normal-state-map (kbd "s-3") (lambda() (interactive) (elscreen-goto 2)))
(define-key evil-normal-state-map (kbd "s-4") (lambda() (interactive) (elscreen-goto 3)))
(define-key evil-normal-state-map (kbd "s-5") (lambda() (interactive) (elscreen-goto 4)))
(define-key evil-normal-state-map (kbd "s-6") (lambda() (interactive) (elscreen-goto 5)))
(define-key evil-normal-state-map (kbd "s-7") (lambda() (interactive) (elscreen-goto 6)))
(define-key evil-normal-state-map (kbd "s-8") (lambda() (interactive) (elscreen-goto 7)))
(define-key evil-normal-state-map (kbd "s-9") (lambda() (interactive) (elscreen-goto 8)))


;;; evil-conf ends here
