;; ;; [Facultative] Only if you have installed async.
;; ;;(add-to-list 'load-path "/path/to/async/directory")

;; (require 'helm-config)

;; (when (executable-find "curl")
  
;;   (setq helm-google-suggest-use-curl-p t))
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (setq helm-quick-update                     t ; do not display invisible candidates
;;       helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
;;       helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
;;       helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
;;       helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
;;       helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
;;       helm-ff-file-name-history-use-recentf t)


;; (setq helm-ag-base-command "ag --nocolor --nogroup -C 2")
;; ;(define-key helm-map (kbd "C-j") 'helm-next-line)
;; ;          (define-key helm-map (kbd "C-k") 'helm-previous-line)
;; ;          (define-key helm-map (kbd "C-h") 'helm-next-source)
;; ;          (define-key helm-map (kbd "C-l") 'helm-previous-source)
;; (defun helm-hide-minibuffer-maybe ()
;;   (when (with-helm-buffer helm-echo-input-in-header-line)
;;     (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
;;       (overlay-put ov 'window (selected-window))
;;       (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
;;                               `(:background ,bg-color :foreground ,bg-color)))
;;       (setq-local cursor-type nil))))
;; (setq helm-echo-input-in-header-line t)
;; (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)
