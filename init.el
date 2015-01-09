;;; COMMENTARY

;;; Uriel's init file

(require 'cask "/usr/local/Cellar/cask/0.6.0/cask.el")

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(require 'package)
(package-initialize)


(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/repo/emacs/")
(add-to-list 'load-path "~/repo/emacs/powerline/")
(add-to-list 'load-path "/Users/umaldonado/Library/Haskell/ghc-7.8.3/lib/")
(add-to-list 'load-path "/Users/umaldonado/Library/Haskell/ghc-7.8.3/lib/ghc-mod-5.2.1.1/bin")
(add-to-list 'load-path "~/.emacs.d/el-get/")
(add-to-list 'load-path "~/smyx.el")
(add-to-list 'load-path "~/repo/emacs/elscreen/")
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'exec-path "/usr/local/Cellar/aspell/0.60.6.1/bin")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "/Users/umaldonado/.rbenv/versions/1.9.3-p484/lib/ruby/gems/1.9.1/gems/rcodetools-0.8.5.0/")
(add-to-list 'exec-path "~/.cabal/bin")
(add-to-list 'exec-path "/Users/umaldonado/Library/Haskell/ghc-7.8.3/lib/ghc-mod-5.2.1.1/bin")
(add-to-list 'exec-path  "~/repo/phabricator/arcanist/bin/" )
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(require 'powerline)

;; Setting this on a buffer will not work
;; you need the set-default
(defun my-ac-emacs-lisp-mode ()
    (setq ac-sources '(ac-source-symbols ac-source-words-in-same-mode-buffers ac-source-filename)))

(add-hook 'emacs-lisp-mode-hook 'my-ac-emacs-lisp-mode)
(add-hook 'enh-ruby-mode 'my-ac-emacs-lisp-mode)



(setq shell-file-name "zsh")
(setq shell-command-switch "-ic")


(require 'json)
(define-key global-map (kbd "C-c o") 'iedit-mode)
(setenv "PATH" (shell-command-to-string "echo $PATH"))
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


(require 'undo-tree)

(setq linum-format "%4d ") ;;; add some space before the line number
(require 'linum-relative)
(require 'ibuf-ext)
(add-to-list 'ibuffer-never-show-predicates "^\\*")




;; Disable loading of “default.el” at startup,
;; in Fedora all it does is fix window title which I rather configure differently
(setq inhibit-default-init t)

;; SHOW FILE PATH IN FRAME TITLE
(setq-default frame-title-format "%b (%f)")



(require 'rcodetools)
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

(defun reload-init ()
  "Reload the emacs config file"
  (interactive)
  (load "~/.emacs.d/init.el"))

(defun e-init ()
  "Edit the the init file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun e-init ()
  "Edit the the init file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun e-evil ()
  "Edit the evil conf file"
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

;;(require 'smart-mode-line)
;; (sml/setup)
;; (sml/apply-theme 'dark)

(setq-default truncate-lines t)

(add-to-list 'load-path "/usr/local/bin")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(load "common-setup.el")
;;(load "uby-conf.el")
(load "evil-conf.el")
(load "evil-star.el")
(load "helm-conf.el")
(require 'helm)

(load "projectile-conf.el")
(load "~/repo/emacs/evil-org-mode/evil-org.el")
(load "smartparens-conf.el")
(load "ido-conf.el")
(load "undo-tree-conf.el")
;;(load "elscreen-conf.el")
(load "org-conf.el")
(load "auto-mode.el")
(require 'evil-visualstar)
(setq mac-command-key-is-meta t)
(scroll-bar-mode -1)
					; my keymaps
					; (add-to-list 'company-backends 'company-ghc)
(column-marker-create column-marker-smyck-gray smyck-gray)
(add-hook 'enh-ruby-mode (lambda () (interactive) (column-marker-1 80)))
(add-hook 'ruby-mode (lambda () (interactive) (column-marker-1 80)))
(add-hook 'web-mode (lambda () (interactive) (column-marker-1 100)))
(load-theme 'smyx)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282828" "#FAB1AB" "#D1FA71" "#FFA600" "#7b68ee" "#dc8cc3" "#96D9F1" "#F7F7F7"])
 '(custom-safe-themes
   (quote
    ("7625c1f3a3f6dc6f0fb39031c9c7b19b19844c48cd2541a3cda376632ca5d59a" "515e32a9e3e2be7c357d686e733b1e8a3494641182238d2b12586bdc28ef3538" "32f0bc6c5cab9fe7f57b7b6ddcbb5531581733ae57e0b839b467d1e91a1cb1c8" "7219a8ffa9adbdb32afd8932756382b2c66310fc5ad72f98745b01b46265cd34" "c5dd6d56913cd6115523ccf9175f65f0218ddd4eadf40dc39668aaa870e86e43" "99d2eb0a3ba347c72c39b0222564a0c22560b617d6ea86165c9f61089f37b664" "4bad702c23bd342f42b7ffe967b7731ed885bd4f723045bfe9d738577569e1d6" "5bce96823727cc55e7f72fdd7984bd13075986fd9ae4cb678d15bc2106e252c4" "73c52dd75bac5e5bc07f89acb303317926b26b3649426e03374d1c1acaeb00c1" "f0b43e167c4cd2fb1970e9ea318b8b543fa238032df627a2669dd8e4940108cd" "c42561a04fc61f81940768490919c3c94dd1e763579ddac000816154e6fb3d5d" "63ea19080a4db079762c249bbaa0e6406b5a90e4cc29395b7bf62a4e701ed6e0" "07f909810128db2bf025db0687991c07f4ba9697993efecbb37aa2e4cce87680" "f6fb0ce9b9d77f916309e45a58e30dfb27a8a69c8926c165b1310cda42cf244e" "198d51b583d57b37d166c63fe18368db278ef4ced6a452a9e5b9181c20acda15" "8c37df91ebcf320e5f1d8497b63ab34db06f9e621c5c354de17422a5e5517a1a" "faf5db6df8b12787fd12fb599b65cd07606b5b523d8b1662baac68eb40539a00" "b4d673a15bac014a912dfab15243aa0e3cbdbc5c50b9f4cc1da04c2841e65870" "41e4dd732bccd4baa55f86113d856dbbb717b875b8dbeb9702d98c8d9e8f3c75" "f3f85a358dc6c3642bc6e0ca335c8909a2210814e5a7d4301993822bbf7db4e6" "fec529f8c673ef7de3406bfb07b34f312d0bd45a84aa07782aa0eecfbe32dbc3" "961d071949c411bfaefbbc4a9a783e3188f1a02d85ffa28ab6465a875877db65" "8e8852b7039e975ec1b933aadef8b0dbc7b26211e2ad6946c876d9a14f999147" "e461cf86789e419b735a3f3b6ce6d69197fdb86cbac0269f1067adc769ddb8f7" "9c017bdeccc504ad81ccf9632745be091be7e24fd08e96c7abe97afd8bd8f847" "4c7957f3df6bdfa12e3633084cf6d9872fdfbc6b73607c8f901fc885938af691" "204141d404d93444df0d2d1ba625818354dfcff34ece786014f61839b91daf68" "8593007c875fbcfc91d06319ebcd7e30def50931559142a7d0519fb5fc829a44" "0f5307cf5377e007a023645339da4bc8756efa44d68cc65e4ea8fb714c5e225a" "7929bcc0fa268acd6ec482d583ca97c80e89a81b422ab2eef70138461cadfb34" "ddc677a8f55a1585081d84ab9a80401d3e8052d9344092a62dff667f08f60697" "e796eb46676a0bb09696227c0a9511f433f6f2aa72a89094cb00d304ef9dbf88" "b679283a6b0b007a7868eea23ea3d51141b7c37e0db4b060b0909a6c81d084e8" "537739c9f20a685405894983a00b6f4246daea933f787ce9a286b87186ccb27f" "0d8f9785ab1cacd0d26e018d2f806831ee17c1fa5a91c9c3b1701f785b9ad0fc" "c075eb430ad6adb34afd675a2eac74703ce4a0c60ddd01acc3fd30d938bf16c3" "9967a1ad5da9ebb0bfae71fbe159f96c967befca340cf62e96ad4bf37a70dda0" "8a4a3bbd4b928a2198a0300c9f5b90259e0283da2eb9123912f1d8f0a75eb3d8" "de5d9bf3ac090c4bdad857fb814623ccb8c9a5e80e0694a0629fec2280189f20" "982fd47e5c6346686b9270e9345702573b1f205a10e48a5f68e8b5c07fd6b05a" "f1dce2276f40446a31352f0c692545e4aa917a73c5e6c462d973e9dea5e2d86d" "8c08bb9f12b5379923768aa421ce6ddfed37638cce77523fb2f90bde676fb858" "1fff0b066cb169ca0927cf221786390ac2a280e4e9b7e5b535c35cc0fcd224a5" "728a0d3858a65367ea49a2fe0b26830d603d4101da8b489657ec8929cf1a767e" "049765cc1b2f69804c8adf0f118fdf989bbafa78d12519a98c243257fc5edb35" "e4015539e6a04b69bca5a8097895bf98b625d8495a996719753a6fba7739d3ba" "181da5579ba44b21873549b4b8e5fd51ab47932f8893e2fd6e0c1ac46b90fb19" "51ddfed8731389ff86a608000e04e684f8568b9a61123f090ea15f6e5d6ea377" "cdd39a7e8b0ac9cd052797ab54e38cb0eec8aff03969b5d46ca2f0833d8ac6b9" "928b5e9cdc2eaf2b01ccbb0a8e1a7ecf77e63a0d71ca81f8a893e5a24ce0605d" "343b02962de3232de1459c6fb281b0bca1b15981d9f2a9cdac3bab8636f77c08" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" default)))
 '(fci-rule-color "#151515")
 '(magit-log-format-graph-function (quote magit-log-format-unicode-graph))
 '(safe-local-variable-values
   (quote
    ((eval when
	   (fboundp
	    (quote rainbow-mode))
	   (rainbow-mode 1))
     (haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
