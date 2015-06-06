;;; package --- Summary:
;;; Commentary:
;;; Uriel's init file
;;; Code:

(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")


(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
	("MELPA" . "http://melpa.milkbox.net/packages/")))
(require 'package)
(package-initialize)
(cask-initialize)
(require 'pallet)
(setq shell-file-name "bash")
					;(add-to-list 'load-path "./rvm-autoloads.el")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'custom-theme-load-path "~/uriel-repo/emacs/smyx/")
(add-to-list 'load-path "~/uriel-repo/emacs/web-mode/")
					;(add-to-list 'load-path "~/repo/emacs/smart-mode-line/") ;
(add-to-list 'load-path "~/uriel-repo/emacs/evil-eww-mode/evil-eww.el")
(add-to-list 'load-path "~/uriel-repo/emacs/evil-jumper/")
(add-to-list 'load-path "~/uriel-repo/emacs/rainbow-mode/")
(add-to-list 'exec-path "/usr/local/Cellar/aspell/0.60.6.1/bin")
					;(require 'rainbow-mode)
(require 'smart-mode-line)
(require 'popwin)
(popwin-mode 1)
(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config)

(setq indent-guide-char "│")
(indent-guide-global-mode)
;; (sml/setup)
;; (sml/apply-theme 'dark)
(rvm-use-default)
(yas-global-mode t)
(global-evil-jumper-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(setq system-uses-terminfo nil)
(add-hook 'term-mode-hook (lambda()
			    (yas-minor-mode -1)))
(defun tacit7/add-new-path (path)
  (interactive "sEnter Path:")
  (let ((path (concat "(add-to-list 'load-path \"" path "\")")))
    (insert path) ))

(add-hook 'term-mode-hook
	  (lambda ()
	    (setq term-buffer-maximum-size 10000))) 
;;; BAD

(defun ugm/new-entry-proj ()
  (interactive)

  (find-file "~/repo/org-mode/projects"))
(defun ugm/transperancy (num)
  (set-frame-parameter nil 'alpha `(,num ,num)))
;;(require 'json)
(define-key global-map (kbd "C-c o") 'iedit-mode)

(defun ugm/filepath-to-clipboard ()
  "Put the current file name on the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))
(defun load-private ()
	"Load the private file."
	(interactive)
	(load-file "~/uriel-repo/private.el"))

;;; Shell 
;; (setq shell-command-switch "-ic")
;; (setenv "PATH" (shell-command-to-string "echo $PATH"))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


(require 'undo-tree)

(define-key global-map (kbd "RET") 'newline-and-indent) ;; Auto indent when you hit return

(require 'linum-relative)
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")


;;BAD

;; Disable loading of “default.el” at startup,
;; in Fedora all it does is fix window title which I rather configure differently
(setq inhibit-default-init t)

;; SHOW FILE PATH IN FRAME TITLE
(setq-default frame-title-format "%b (%f)")


(setq ido-everywhere t)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

(require 'column-marker)
;; (require 'recentf)
;; (recentf-mode 1)
;; (setq recentf-max-menu-items 25)
;; (global-set-key "\C-x\ \C-r" 'recentf-open-files)
;;(add-hook 'haskell-mode-hook 'structured-haskell-mode)

(defun ugm/switch-to-api ()
	"Switch to api project."
	(interactive)
	(cd "	~/repo/api-socialcentiv-com/"))

(defun ugm/scratch-notes ()
  (interactive)
  (find-file "~/uriel-repo/scratch-notes.org"))
(defun reload-init ()
  "Reload the Emacs config file."
  (interactive)
  (load "~/.emacs.d/init.el"))

(defun e-init ()
  "Edit the the init file."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun e-evil ()
  "Edit the evil conf file."
  (interactive)
  (find-file "~/.emacs.d/custom/evil-conf.el"))
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)


(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
(require 'ibuffer)

(setq ibuffer-expert t) ; dont ask when killing a buffer
;;BAD

(setq-default truncate-lines t)

(add-to-list 'load-path "/usr/local/bin")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


(setq neo-theme 'nerd)



(load "~/.emacs.d/custom/common-setup.el")
(load "~/.emacs.d/custom/evil-conf.el")
(load "~/.emacs.d/custom/evil-star.el")
(require 'helm-config)
(load "~/.emacs.d/custom/helm-conf.el")
(load "~/uriel-repo/private.el")
(load "~/.emacs.d/custom/projectile-conf.el")
(load "~/.emacs.d/custom/helm-projectile.el")
(load "~/.emacs.d/custom/ruby-conf.el")
(load "~/.emacs.d/custom/flycheck-conf.el")
(load "~/.emacs.d/custom/ido-conf.el")
(load "~/.emacs.d/custom/undo-tree-conf.el")
(load "~/.emacs.d/custom/elscreen-conf.el")
(load "~/.emacs.d/custom/org-conf.el")
(load "~/.emacs.d/custom/auto-mode.el")
(load "~/.emacs.d/custom/yasnippet-conf.el")
(require 'evil-visualstar)
(setq mac-command-key-is-meta t)
(scroll-bar-mode -1)
(setq linum-relative-current-symbol "")
(global-linum-mode t)
(setq linum-relative-format "%3s ")
(setq-default tab-width 2)
(setq indent-tabs-mode nil)
					; make tab key always call a indent command.

;; make tab key call indent command or insert tab character, depending on cursor position





;; Dont prompt for getting on read only text
(setq minibuffer-prompt-properties
      (plist-put minibuffer-prompt-properties 'point-entered 'minibuffer-avoid-prompt))


;;; To check what minor modes you have
;;; C-h v minor-mode-alist
(setq projectile-mode-line
      '(:eval (format "  	❰%s❱" (projectile-project-name))))
												;;;	⬿El⥺
					;http://en.wikipedia.org/wiki/Arrow_%28symbol%29
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . "")
    (yas/minor-mode . " υ")
    (yas-minor-mode . " υ")
    (yas-global-mode . " υ")
    (smartparens-mode . " ❨✷❩")
    (smartparens-global-mode . " (o)")
    (yas/global-mode . " υ")
    (paredit-mode . " ❨e❩")
    (lisp-interaction-mode . "λ")
    (enh-ruby-mode . " ♦")
    (undo-tree-mode . " 木")
    (flycheck-mode . "")
    (eldoc-mode . "")
    (evil-org-mode . " ⬿Org")
    (org-mode . "")
    (abbrev-mode . "")
    ;; Major modes
    (hi-lock-mode . "")
    (python-mode . "Py")
    (emacs-lisp-mode . "⒠")
    (nxhtml-mode . "nx"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")


(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
		  (mode-str (cdr cleaner))
		  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
	       (setcar old-mode-str mode-str))
	     ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))


(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;;; alias the new `flymake-report-status-slim' to
;;; `flymake-report-status'
(defalias 'flymake-report-status 'flymake-report-status-slim)
(defun flymake-report-status-slim (e-w &optional status)
  "Show \"slim\" flymake status in mode line."
  (when e-w
    (setq flymake-mode-line-e-w e-w))
  (when status
    (setq flymake-mode-line-status status))
  (let* ((mode-line " Φ"))
    (when (> (length flymake-mode-line-e-w) 0)
      (setq mode-line (concat mode-line ":" flymake-mode-line-e-w)))
    (setq mode-line (concat mode-line flymake-mode-line-status))
    (setq flymake-mode-line mode-line)
    (force-mode-line-update)))





;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)
;;; Dash

(setq helm-dash-common-docsets '("Ruby"))
					; my keymaps
					; (add-to-list 'company-backends 'company-ghc)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
	 ["#282828" "#FAB1AB" "#D1FA71" "#FFA600" "#7b68ee" "#dc8cc3" "#96D9F1" "#F7F7F7"])
 '(custom-safe-themes
	 (quote
		("535e812d2e7743efe63f925a4b63dcc1cce5ed76101aea087fd43fecb1b184f5" "bc8d8a2639c2ced6ab7aa1c2715c75be4d719ee801b8d85295c0c678f5784865" "bf0d1f9681ca12cf2b81ad5b957691c9262cf7998dc4dd1169d5e8ae881eaefe" "cce0922a8ccd83f160b8c9c950c7ef4c1c102f685485743141c8f8ebbaf548cc" "8c28b6a38e5289b0037d5c75aa4bf539bfd5982f792e10d834821d831d117efe" "75451efa3d6bcf86a0bd073530d5aa201f32c391bfa920ed63a3c0d41814c5c1" "bd89966dceed21a386abccc8f14cb710705141b380a95504ff71eba577049f73" "464e9ae9bd79330f97c73dfc8f0c61456aa0a9ecb35e62bbb9abc751a7ab2a3e" "e67f6ab4d1919e89cd2f0e0fac8fc8643e44074a41b1b249d27169c8ee4e4ca6" "21dc45232458293dbbfe8be6c3a865e9cc96f9f1a5f3f9feae740340f56e757d" "19df744e92ad2c1361d50aaeadfefc1755628f7516c2b6dbe75a7ec541a10e2c" "c591f386024ea45b2eb06cf453667ec8ac21a0a317ad58e623867d030eeb5e95" "1d473e48201ce4bff3daaa0ef9850de9dfb841508d931378ffa9224f9daff183" "adbe62bd4752af9ca4da38cb34d1ac1a2d9d0feb935ba2a7c0f7185d9993cc6f" "a04764f59d957cc6de179cf1337d49859140f62443e89d34999dd2c6adf203c0" "b6f90696a1383eb731c2a2bcbdbe940124d873e07c2bee8b3461d7107f261ec5" "e842be0f7791b65556f557c49f62068aade2e9deeec58c00a9015ef50b993584" "e6a2a6296531458fc3a31cdecc9168dc392e9e73f443d9f12f40a2e2e7918ab6" "46577cc8193c51db01e121e9d35b9e26dd933680ff3b8593d1ce201eb3d9f11a" "7127a2bb56533b4a24e717a6d8ffa75bc18765a49608f806eb145b8fd5a82f58" "c52acd08c890e0911a448d8973ed9f3ef3a0d99baef8b44f57edda4585d17ccd" "e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "accb248b5e48ccd64698e4d8074ed85d654c27204d4a340a14ac96f49c22aad3" "4a7318f3227086da03f6b1f864866a314c59b2c480b1c3ada0d7ba3dddd14bfc" "c9c93703c8fad5d642559b451b288b4c7a0bd9d71f6ced3da19c633fb842d0a2" "f4f8576fe07fc3af67502138390ee3e5e87c04955a9546f7130c62c2bd0e91c7" "4ef679cc918bf5a15bb8083d6973bd7cf09dbee7767bca7972b3a9d1a6059dfe" "658e419791489181d9eca29bda5adb6db1f83c8d329c890f1db82bb5229e56e9" "c48a51eb37c6d7d2e0bd1d7702dbe22f5f1f200f73e502b8674ee76b882b5325" "315c803fa6b2ca79d3bbdc72ca48d90dcf754351675a4ac9087fc7fdf2848f0f" "386fae5b62db6fdebe6308d45092f61e4a00f7d386a4a3262d0526eabbcd396a" "42eac23bb0b30c62fc7e362baf5aadc7721b158dfcdfb9e6d1f39678c7d09afa" "5795f513cecdc9bac2ffc7dc9f0345568fd77dbb112950fd68d2bffe1f03dac1" "a9c7c29d1b8b4624262f5f1060695762ac959100ae8511110944e473a2d137f9" "f8c3adbd854f6a4c07b7a4495e762afd16236c11a1d7e5e692ea411cd2c83922" "5e2613552e00cf6e202342628bb6091889e5584d2744378eeb9c7c3a51a21883" "5003c2869df42ded63fc03c1e0e137c2fa80d393ecfb36f245228594aa1673b1" "d450600be457b75971859e5284d0f00042f49473d0888a956e6b6683097a772f" "76c388d24276bdf01bbbe6c75b1af0b76a16026f2d181a5ae6fb72bb9b2e8d44" "bebbaadce43fdfe82fd453969f4f877799c4f4973d5c9192b1186aa0c058f2ae" "2c058064c9abac150e45f023b8b8fd517e1398f68d409eef1dcb9898897d374d" "2ce73702b05bf6c30d769c4bb04a79bbde1b189e5ea8c03deb224009fe2937ae" "93474ff98fdae64502e72d31b0585043d82778706e3a8c8f0ed93cde8d1bad77" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "2764d37d3fd3429a1efa6d0a5e261c2ea46f999525cfb07dd609266b05ed102d" "7f7d401d49912861cddfe72fa98fde1080e917d91b3ad44bf814ab9e566fb059" "35661b0091bfac46b0b363a47746d04695916c8b20e51a09f7ac446c18144c0a" "b847b0cf684d9ccb969f8868b29f1c83a88abdce974009801a0854a3eaeb3b57" "0d78be97cb294ee45add15a9dde4a02d108eb627c51c401d0513dc60c21f9798" "baf8ee8730814bc8ba999a8e810410891f2509daeb28b4b517b1eb6bd5453965" "f9fb31369819ed08e231c1b69dc0c5e1bb8b52563d60a0dbcb577e47d33b39fe" "7f6d903b875ce4d2f1834211e8b32a2172b7171adef428222ec64dda6f3bbf4d" "a6f737e76be7891e2cf84f9da6e1b42622f01d504058961d60bfe271e75844dc" "6594e3106eeee750952a5adcb09e45f2a4d7b0d1ba7636d146b1ee25273cc503" "559b61aeea22f87ad68869eba08750d5cd6812732ad0eabd3c7d7d710207b422" "d0b289cc0d83cede021418f7e6bc1be02102e086e0d1d5ccc202d2c0d9145dba" "06b5bb3b81404b669f333b4ee895980ed9542bf6c1a16f2eff12d8e83b4d9177" "6a2fca26dcb3421c90e2a5cd8209b1cfc696eca9c4f2f3baa8044268bdae1275" "125c5a9d7a13d23701b5ddb8ec32ca2fc3a12af03b86fe75120556f5774ba478" "d21f4b910f540b7a1bb556c6fd9e872e8ea4f96763808f127741e1821e59d57e" "6b65c53d36b423e01c2dfb2e2ff15d155efe54d23d61b33ac8eea0c4c6192259" "6b7065007cbb2fd84cb64c47f26052f2142fdb47cb89cfc1b2037147844bb960" "c23d376d252905d68d028da63e0e8892a7bbeb8d085cf5d9cd04039f1f969bff" "042764fe6116fad118e545807f4e1634e1d7364f5e41dfeba589d19cea1687f6" "0f002f8b472e1a185dfee9e5e5299d3a8927b26b20340f10a8b48beb42b55102" "4bafdf555f23506274614cd17ca564fae34c833ff1d0a5fa04e5034823d56d81" "8e29973bf8aee4b708c8ef9c512b90d1acabe4a5c15b571c6f57e140264d44d3" "97c3898362f36417cf9bece98a9fad1ba8bc145043097a5b9bb8a7e66addec6c" default)))
 '(evil-jumper-mode t)
 '(fci-rule-color "#151515")
 '(minibuffer-prompt-properties
	 (quote
		(point-entered minibuffer-avoid-prompt face minibuffer-prompt point-entered minibuffer-avoid-prompt)))
 '(package-selected-packages
	 (quote
		(indent-guide ruby-refactor erlang define-word lua-mode smooth-scrolling smooth-scroll avy hl-line+ hl-spotlight yari helm-c-yasnippet centered-cursor-mode projectile ocodo-svg-modelines org smartparens zencoding-mode yascroll yaml-mode wrap-region workgroups web-mode web-beautify vagrant-tramp vagrant tern-auto-complete tabbar-ruler smex smart-mode-line slime shm shell-command rvm ruby-tools rubocop rsense restclient relative-line-numbers recentf-ext rainbow-delimiters projectile-rails project-explorer pretty-mode powerline paredit pallet org-journal org-bullets occidental-theme noctilux-theme neotree multiple-cursors multi-term moz-controller mew maxframe markdown-mode magit linum-relative jabber idomenu ido-vertical-mode icicles helm guide-key grizzl git-timemachine git-gutter-fringe git-blame flymake-ruby flymake-cursor flycheck flx-ido floobits findr expand-region exec-path-from-shell eww-lnum evil-tabs evil-surround evil-leader evil-jumper escreen enh-ruby-mode enclose elscreen-mew elpy ecb drag-stuff dirtree dash-at-point cyberpunk-theme company-inf-ruby company-ghc column-marker color-theme-sanityinc-tomorrow clojure-mode calfw bash-completion babel arduino-mode anaphora ag ace-jump-mode ac-js2 ac-haskell-process))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'smyx)
(setq ns-use-srgb-colorspace nil)
(require 'powerline)
(powerline-default-theme)
					;(powerline-default-theme)
;;;

;;;### (autoloads nil "../repo/emacs/rvm.el/rvm" "../repo/emacs/rvm.el/rvm.el"
;;;;;;  (21707 27595 0 0))
;;; Generated autoloads from ../repo/emacs/rvm.el/rvm.el

;;;***
(put 'dired-find-alternate-file 'disabled nil)
