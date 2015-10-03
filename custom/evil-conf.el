;; package --- Summary:
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
(require 'evil-matchit)
;; not necessary if using (evil-snipe-replace-evil)

(global-evil-surround-mode 1)
(evil-mode 1)
(global-evil-leader-mode)
(global-evil-matchit-mode)

; modes that do not need to be in evil mode
(add-to-list 'evil-emacs-state-modes 'dirtree-mode )

(defun ugm/persp-names ()
		(-map
		 (lambda (x) (if (stringp x) x ( symbol-name x ) ))
		 (persp-names-current-frame-fast-ordered)))

(setq helm-persp-source
			`((name . "Perspecticve switch")
				(candidates . (lambda () (ugm/persp-names) ))
				(action . (("Switch to perspective " . (lambda (candidate) (persp-switch candidate)))
									 ("Remove perspective" .     (lambda (candidate) (persp-kill candidate)))
									 ))))

(defun is-dot-dir-p (file)
	"Check if FILE is . or .."
	(-contains? '("." "..") file))

(defun ugm/remove-dot-dirs(dirs)
	(-remove 'is-dot-dir-p dirs))

(defun ugm/list-notes ()
	"List all the notes that you have."
	(ugm/remove-dot-dirs (directory-files "~/uriel-repo/notes/")))

(setq helm-notes-source
			`((name . "Notes")
				(candidates . (lambda () (ugm/list-notes) ))
				(action . (("Switch to notes " . (lambda (candidate) (find-file (concat "~/uriel-repo/notes/" candidate))))
									 ))))
(defvar fallback-notes-source '((name . "Notes create")
																(dummy)
																(action . (("Create Note" . (lambda (candidate) (find-file (concat "~/uriel-repo/notes/" candidate))))))))
(defun helm-list-notes ()
	(interactive)
	(helm :sources '(helm-notes-source fallback-notes-source )))

(defvar fallback-persp-source '((name . "Perspecticve create")
																(dummy)
																(action . (("Create" . (lambda (candidate) (persp-switch candidate)))))))


(defun helm-persp-switch ()
	(interactive)
	(helm :sources '(helm-persp-source fallback-persp-source) ))

(defun switch-to-last-buffer ()
  "Switch to the previously selected buffer in the current window."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer)) nil t))


(defun ido-persp-select ()
	(ido-completing-read "Select perspective" (ugm/persp-names)))

(defun ido-persp-switch ()
	(persp-switch (ido-persp-select)))


(defun tacit7/evil-comment-xmp ()
  "Insert a '# =>' so that xmp can insert ruby evaluations."

    (interactive)
    (evil-append-line 0)
    (insert "    # =>")
    (evil-normal-state))

(defun tacit7/evil-xmp-comment-and-eval()
  "Insert the comment string and eval the file."
  (interactive)
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

(defun tacit7/edit-cask ()
  "Open the cask file"
  (interactive)
  (find-file "~/.emacs.d/Cask" ))

(defun tacit7/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

					;insert mode key maps
	(define-key evil-insert-state-map "\C-f" 'sp-forward-slurp-sexp)
	(define-key evil-insert-state-map "\C-b" 'sp-backward-slurp-sexp)
(add-hook 'yasnippet-minor-mode
		 (progn 
	(define-key evil-insert-state-map "\C-k" 'yas/expand)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-x C-k") 'yas-expand) ;
))
(defun ugm/project-to-1kb ()
	"Switch to 1kb project."
	(interactive)
	(persp-load-state-from-file "~/.emacs.d/persp-confs/1kb")
	(cd "~/repo/1kb/")
	(helm-projectile-find-file "~/repo/1kb/"))

(defun ugm/search-custom-emacs-files ()
	"Switch to a custom emacs file."
	(interactive)
	(let (old-dir (pwd))
		(helm-find-files nil))
	(cd old-dir))

(defun ugm/project-to-strangler ()
	"Switch to stranger project."
	(interactive)
	(cd "~/repo/strangler/")
	(persp-load-state-from-file "~/.emacs.d/persp-confs/strangler")
	(helm-projectile-find-file "~/repo/strangler/"))

(defun ugm/project-to-eden ()
	"Switch to eden-search project."
	(interactive)
	(cd "~/repo/eden-search/")
	(helm-projectile-find-file "~/repo/eden-search/"))

(defun ugm/find-notes ()
	(interactive)
	(setq current-prefix-arg '(4)) 	
	(cd "~/uriel-repo/notes/")
	(helm-projectile-find-file "/Users/uriel781/uriel-repo/notes/"))

(defun edit-1kb-notes ()
	(interactive)
	(find-file "/Users/uriel781/uriel-repo/notes/1kb.org"))

(defun ugm/find-custom-file ()
	(interactive)
	(setq current-prefix-arg '(4)) 	
	(cd "~/uriel-repo/emacs_init/")
	(helm-projectile-find-file "/Users/urielm/uriel-repo/emacs_init/"))

(defun ugm/find-agendas ()
	(interactive)
	(setq current-prefix-arg '(4)) 	
	(cd "~/uriel-repo/notes/")
	(helm-projectile-find-file "/Users/urielm/uriel-repo/notes/agendas/"))

(defun ugm/edit-1kb-agenda ()
	(interactive)
	(find-file-other-window "~/uriel-repo/notes/agendas/1kb.org"))

(defun ugm/edit-1kb-notes ()
	(interactive)
	(find-file-other-window "~/uriel-repo/notes/1kb.org"))

(defun ugm/edit-gemfile ()
	(interactive)
	(find-file-other-window (concat (projectile-project-root) "Gemfile")))

(defun ugm/new-line ()
	(interactive)
	(end-of-line)
	(open-line 2)
	(forward-line 2)
	(evil-insert nil)
	(indent-for-tab-command))

(evil-define-command evil-scroll-page-up-and-center (count)
	"Scrolls the window COUNT pages upwards."
	:repeat nil
	:keep-visual t
	(interactive "p")
	(evil-save-column
		(dotimes (i count)
			(scroll-down nil)))
	(evil-scroll-line-to-center nil))

(evil-define-command evil-scroll-page-down-and-center (count)
	"Scrolls the window COUNT pages upwards."
	:repeat nil
	:keep-visual t
	(interactive "p")
	(evil-save-column
		(dotimes (i count)
			(scroll-up nil)))
	(evil-scroll-line-to-center nil))


(evil-define-motion evil-next-line-and-center (count)
	"Move the cursor COUNT lines down."
	:type line
	(let (line-move-visual)
		
		(evil-line-move (or count 1))
		(evil-scroll-line-to-center nil)))

(evil-define-motion evil-previous-line-and-center (count)
	"Move the cursor COUNT lines down."
	:type line
	(let (line-move-visual)
		
		(evil-line-move (- (or count 1)))
		(evil-scroll-line-to-center nil)))

;; (define-key evil-motion-state-map "j" 'evil-next-line-and-center) 
;; (define-key evil-motion-state-map "k" 'evil-previous-line-and-center) 
;; (define-key evil-motion-state-map (kbd "C-f") 'evil-scroll-page-down-and-center) 
;; (define-key evil-motion-state-map (kbd "C-b") 'evil-scroll-page-up-and-center) 
;; (define-key evil-motion-state-map "k" 'evil-previous-line-and-center) 
(define-key evil-normal-state-map (kbd "C-e") 'ugm/new-line)
(define-key evil-insert-state-map (kbd "C-e") 'ugm/new-line)

(defun ugm/forward-center ()
	(interactive)
	(evil-scroll-down nil)
	(evil-scroll-line-to-center nil))
(defun ugm/backward-center ()
	(interactive)
	(evil-scroll-up nil)
	(evil-scroll-line-to-center nil))
;; center

;; normal mode key maps
(define-key evil-normal-state-map (kbd "C-6") 'switch-to-last-buffer)
(define-key evil-normal-state-map "\C-p" 'helm-projectile)
(define-key evil-normal-state-map (kbd "s") 'ace-jump-two-chars-mode)

(define-key evil-normal-state-map (kbd "gb") 'helm-projectile-switch-to-buffer)
(define-key evil-normal-state-map (kbd "C-SPC") 'helm-M-x)


(define-key evil-normal-state-map (kbd "C-<ret>") 'evil-add-blank-line)
(define-key evil-normal-state-map (kbd "C-f") 'ugm/forward-center)
(define-key evil-normal-state-map (kbd "C-b") 'ugm/backward-center)
(define-key evil-normal-state-map (kbd "C-<ret>") 'evil-add-blank-line)
(define-key evil-normal-state-map "J" 'evil-join)
(define-key evil-normal-state-map (kbd "god") 'helm-imenu)
(add-to-list 'evil-emacs-state-modes 'nav-mode)

; (97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90)

(setq ace-jump-mode-move-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?A ?S ?D ?F ?G ?H ?J ?K ?L ))

(add-to-list 'evil-emacs-state-modes 'dired-mode)

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
(evil-add-hjkl-bindings eshell-mode-map 'normal
	(kbd "M-j") 'eshell-previous-input                   ; "j"
	(kbd "M-k") 'eshell-next-input )   ; "k")

(evil-add-hjkl-bindings shell-mode-map 'normal
	(kbd "M-j") 'comint-previous-input
	(kbd "M-k") 'comint-next-input)
(defun ugm/edit-evil ()
	(interactive)
	(find-file "~/.emacs.d/custom/evil-conf.el"))

(defun ugm/edit-smyx ()
	(interactive)
	(find-file "~/uriel-repo/emacs/smyx/smyx-theme.el"))
(defun ugm/load-smyx ()
	(interactive)
	(load-theme 'smyx))
(defun ugm/edit-init ()
	(interactive)
	(find-file "~/.emacs.d/init.el"))
(defun ugm/send-previous-region ()
	"Send previous selected region."
	(interactive)
	(evil-visual-restore)
	(ruby-send-region (region-beginning) (region-end)))
;; Screens
(global-set-key (kbd "s-t") 'make-frame-command)
(define-key evil-normal-state-map (kbd "1 t") (other-frame 0))


;;; Naviagtion
(define-key evil-normal-state-map (kbd "C-i") 'evil-scroll-up)

;;; Emacs
(global-evil-leader-mode)
(global-set-key (kbd "M-x") 'helm-M-x)

;;; Leader stuff
(define-key global-map (kbd "C-h r") 'yari-helm)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
																				; Helm
	"hm" 'helm-mini
	"hr" 'helm-recentf
	"hd" 'helm-imenu
	"hn" 'helm-list-notes
	"ha" 'helm-ag
	"hb" 'helm-buffers-list
	"hc" 'ugm/search-custom-emacs-files

																				; Org
	"ol" 'org-store-link
	"ot" 'tacit7/open-org-tickets
	"oic" 'ugm/org-insert-checkbox
	"od" 'ugm/org-execute-and-display

	;; Edit files
	"n1" 'ugm/edit-1kb-notes
	"ea" 'ugm/edit-1kb-agenda
	"ee" 'ugm/edit-evil
	"es" 'ugm/edit-smyx
	"eS" 'ugm/load-smyx
	"ei" 'ugm/edit-init
	"eC" 'tacit7/edit-cask
	"ec" 'ugm/find-custom-file

																				;Rails
	"rm" 'projectile-rails-find-model
	"rc" 'projectile-rails-find-controller
	"rv" 'projectile-rails-find-view
	"rt" 'projectile-rails-find-spec
	"rz" 'projectile-rails-find-serializers
	"rs" 'projectile-rails-find-services
	"ra" 'projectile-rails-find-api

																				; projects
	"pe" 'ugm/project-to-eden
	"p1" 'ugm/project-to-1kb
	"ps" 'ugm/project-to-strangler

																				;go directly to file
	"gn" 'edit-1kb-notes

	"t" 'other-frame
	"x" 'tacit7/evil-comment-xmp
	"X" 'tacit7/evil-xmp-comment-and-eval
	"d" 'neotree-toggle
	"D" 'dired
	"s" 'sp-forward-slurp-sexp
	"S" 'sp-backward-slurp-sexp
	"l" 'ace-jump-line-mode
	"c" 'ace-jump-char-mode
	"k" 'kill-buffer
	"j" 'dabbrev-expand
	"er" 'eval-region
	"ef" 'eval-defun
	"c" 'tacit7/binding-pry
	"f" 'helm-projectile-find-file)
;;; some hack to get indetation working
(define-key evil-insert-state-map [remap newline] 'newline)
(define-key evil-insert-state-map [remap newline-and-indent] 'newline-and-indent)

(defadvice evil-window-vsplit (after evil-window-next-advice activate)
	(evil-window-next nil))


(eval-after-load 'elscreen-conf
  (progn
    (message "elscreen conf has been loaded")
    (global-set-key (kbd "M-t") 'elscreen-create)
    (define-key evil-normal-state-map (kbd "C-w q") 'vimlike-quit)
    (evil-ex-define-cmd "q[uit]" 'vimlike-quit)))

(define-key evil-normal-state-map (kbd "gt") 'elscreen-next)
(define-key evil-normal-state-map (kbd "gT") 'elscreen-previous)
;; ElScreen
(global-set-key (kbd "M-1") (lambda() (interactive) (elscreen-goto 0)))
(global-set-key (kbd "M-1") (lambda() (interactive) (elscreen-goto 0)))
(global-set-key (kbd "M-3") (lambda() (interactive) (elscreen-goto 2)))
(global-set-key (kbd "M-4") (lambda() (interactive) (elscreen-goto 3)))
(global-set-key (kbd "M-5") (lambda() (interactive) (elscreen-goto 4)))
(global-set-key (kbd "M-6") (lambda() (interactive) (elscreen-goto 5)))
(global-set-key (kbd "M-7") (lambda() (interactive) (elscreen-goto 6)))
(global-set-key (kbd "M-8") (lambda() (interactive) (elscreen-goto 7)))
(global-set-key (kbd "M-9") (lambda() (interactive) (elscreen-goto 8)))


;;; evil-conf ends here
