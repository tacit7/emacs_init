
;;; package --- Summary:
;;; Commentary:
;;; Code:
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump t)
(setq evil-want--i-jump t)
(setq evil-toggle-key "C-`")
(setq evil-auto-indent t)
(setq evil-want-fine-undo t)
(require 'evil)
(require 'evil-leader)
(require 'evil-surround)
;; not necessary if using (evil-snipe-replace-evil)

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
  (insert "require 'pry'; binding.pry")
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


(defun ugm/new-line ()
	(interactive)
	(open-line 2)
	(forward-line 2)
	(indent-for-tab-command))



(define-key evil-normal-state-map (kbd "C-e") 'ugm/new-line)
(define-key evil-insert-state-map (kbd "C-e") 'ugm/new-line)


;; normal mode key maps
(define-key evil-normal-state-map "\C-p" 'helm-projectile)
(define-key evil-normal-state-map (kbd "s") 'ace-jump-word-mode)
(define-key evil-normal-state-map "gor" 'helm-mini)
(define-key evil-normal-state-map "gom" 'helm-imenu)
(define-key evil-normal-state-map "gol" 'org-store-link)
(define-key evil-normal-state-map "got" 'tacit7/open-org-tickets)

(define-key evil-normal-state-map (kbd "gb") 'helm-projectile-switch-to-buffer)
(define-key evil-normal-state-map (kbd "C-SPC") 'helm-M-x)


(define-key evil-normal-state-map (kbd "C-<ret>") 'evil-add-blank-line)
(define-key evil-normal-state-map "J" 'evil-join)
(add-to-list 'evil-emacs-state-modes 'nav-mode)

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-x C-k") 'yas-expand) ;



(add-to-list 'evil-emacs-state-modes 'dired-mode)
(eval-after-load 'elscreen-conf
  (progn
    (message "elscreen conf has been loaded")
    (global-set-key (kbd "s-t") 'elscreen-create)
    (define-key evil-normal-state-map (kbd "C-w q") 'vimlike-quit)
    (evil-ex-define-cmd "q[uit]" 'vimlike-quit)))

(defun neotree-preview-file ()
  "Preview file."
  (neotree-enter)
  (evil-window-prev 1))

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
			 (define-key evil-normal-state-local-map (kbd "o") 'neotree-preview-file)
			 (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
	     )))
(define-key evil-normal-state-map (kbd "gom") 'projectile-rails-find-model)
(define-key evil-normal-state-map (kbd "god") 'helm-imenu)
(define-key evil-normal-state-map (kbd "goc") 'projectile-rails-find-controller)
(define-key evil-normal-state-map (kbd "gov") 'projectile-rails-find-view)
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
  "s" 'sp-forward-slurp-sexp
  "S" 'sp-backward-slurp-sexp
  "l" 'ace-jump-line-mode
  "c" 'ace-jump-char-mode
  "j" 'helm-M-x
  "k" 'kill-buffer
  "e" 'eval-region
  "c" 'tacit7/binding-pry
  "f" 'helm-projectile-find-file)
;;; some hack to get indetation working
(define-key evil-insert-state-map [remap newline] 'newline)
(define-key evil-insert-state-map [remap newline-and-indent] 'newline-and-indent)




;; ElScreen
(global-set-key (kbd "s-1") (lambda() (interactive) (elscreen-goto 0)))
(global-set-key (kbd "s-2") (lambda() (interactive) (elscreen-goto 1)))
(global-set-key (kbd "s-3") (lambda() (interactive) (elscreen-goto 2)))
(global-set-key (kbd "s-4") (lambda() (interactive) (elscreen-goto 3)))
(global-set-key (kbd "s-5") (lambda() (interactive) (elscreen-goto 4)))
(global-set-key (kbd "s-6") (lambda() (interactive) (elscreen-goto 5)))
(global-set-key (kbd "s-7") (lambda() (interactive) (elscreen-goto 6)))
(global-set-key (kbd "s-8") (lambda() (interactive) (elscreen-goto 7)))
(global-set-key (kbd "s-9") (lambda() (interactive) (elscreen-goto 8)))


;;; evil-conf ends here
