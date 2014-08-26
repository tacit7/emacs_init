(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump t)

(require 'cask "/usr/local/Cellar/cask/0.6.0/cask.el")
(cask-initialize)
(require 'pallet)

(require 'pretty-mode)
(global-pretty-mode 1)
(add-to-list 'pretty-modes-aliases '(enh-ruby-mode . ruby-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(require 'evil-tabs)
(global-evil-tabs-mode t)

(require 'undo-tree)
(global-undo-tree-mode)
(setq undo-tree-auto-save-history t)
;; Disable loading of “default.el” at startup,
;; in Fedora all it does is fix window title which I rather configure differently
(setq inhibit-default-init t)

;; SHOW FILE PATH IN FRAME TITLE
(setq-default frame-title-format "%b (%f)")


(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

(global-company-mode t)
(push 'company-robe company-backends)
(add-hook 'robe-mode-hook 'ac-robe-setup)








(add-to-list 'load-path "~/repo/emacs/")
(add-to-list 'load-path "~/smyck.el")
(add-to-list 'load-path "~/repo/emacs/powerline/")
(add-to-list 'load-path "~/repo/emacs/cyberpunk-theme.el")
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'exec-path "/usr/local/Cellar/aspell/0.60.6.1/bin")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

(require 'column-marker)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))













(setq-default truncate-lines t)
(add-to-list 'load-path "/usr/local/bin")
(load "00common-setup.el")
(load "01ruby.el")
(load "03auto-complete.el")
(load "05robe.el")
(load "07yasnippet.el")
(load "09projectile.el")
(load "javascript-config.el")
(load "10smartparens")
(load "11robe.el")
(load "ido-config.el")
(load "~/repo/emacs/evil-org-mode/evil-org.el")
(load "~/repo/emacs/powerline/powerline.el")

(require 'powerline)
(powerline-default-theme)
(setq mac-command-key-is-meta t)
(setq ido-enable-flex-matching t)
(scroll-bar-mode -1)


; my keymaps


(define-key evil-normal-state-map "\C-p" 'projectile-find-file)
(define-key evil-normal-state-map "gor" 'recentf-ido-find-file)
(require 'evil)
(evil-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#fdf6e3" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(background-color "#202020")
 '(background-mode dark)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (smyck)))
 '(custom-safe-themes
   (quote
    ("df7cbbdc7289a7fa89f9099b51ab3088b33aa8851d9502e8fd4666231598faeb" "1c33bd09d62e58a6398d8d50accd6b30b6e18a615adacdc24c4c66ea724ef1c0" "a12fb2ab40be4c133e41bb57d517ea0c93b2b0f6bb32e5a883dd6bcfb5bd7945" "adabeef569215c19cd321d6791aaef6468ce3ff7e31d97c55bee482eb36b73ba" "dc693dae5fb23c686064b9864f3aa67334978aad9f4eafc35879bc4749eb862c" "aac592596645a0129b33994daefa3a8584239102507e412924c5d5163c5243c0" "886d5a10b353785bf1b1278c9b14a63ede5185bc5e0db5f8a2b7cfeed6f073fd" "8efe54bca71ae7f04d7a733bbe378ca36d5b51117b02fe7d7de7ef9ba3df245c" "e8a090b48a1dac089d0246006f05034a1c6387127bc7ee0a760165cfe384597d" "dd32e0cf8e0c956d3c6b0b044b0fa087bc79e378b9b5337ab5b8f857d556d89d" "d40d64f3ec2d594827cae5f57a64b8d8a5c83e7d6e1ad40454b6a928412e6b7a" "aa487e4be5b26b49c0446f165aaf0e199da8f03c9f30cd22925c3cae24fc05ac" "2d3f81d8da48fefcdb211a4348ad3a2cb89d6efa5cdb1f2cd391c5d8c274ec0c" "04d5ce0b7f35675e161ff630d9d8cc6d6742813da6a81f46694bd6047b1c55ca" "7c1d52c24a22e096742adabaf9e5a8a7ce141b60ffde44f676a02f77a20052e0" "2e94bcffaf0b57262cebc2d82eb4dc3fcc1220f0c5dfc0897ff1756fe4acc315" "b75476d72d5f11f79a3404e22ab8fa82ac14d1bdb8693990ebc000818628243e" "fa948f1f017fb1c9f9d65eadbca9720ad8ce878f9cbf1a136a4573a88ccdf0b3" "ab2beea55d71f3221b38af74a02d5ac725477c571f73454c8ff4783d75cf170f" "c19b5844037e24cd6b30930da758d9f6649f9d072a390dac1376f6b6a0a9c077" "0857028b49b9c9b2756a4d9ac53e5a264b5d152769e1d29000baaecbe2e55da8" "e3e4ec49145c0801957513b8c1b625a136ce6c9bb22057b1eea308d167f3f6f2" "98cdf4e626510742021df12c4241bc9fc560e20375951b26308cc72a01e21798" "d78f69ae3ce53f082d66d6e29f4c30b9a703e9da9ebca43dbe4b187f3a3428f4" "d34fda9feb8114daf3433608527be777ab1fc9297c3923f057ac93fa68acddf5" "de6bfe40d0156ac77184a72a864cb003488f2d11106fc83a134b0169ea472323" "384f92e44dad7ae8a1c8fb5fcf4a9d9fde836ed4dbcb3a353beae2ded97e429c" "36084e348dd9a87be5064a54f390fcb5b316ab1c640d06636dc07b7bf247b788" "ccfb95726127685d99bec1364476347d99123ecafcbd50a254b349072392f568" "709e6bf70b9727e0a8d17c83e987d7da8f7265a8e8dd357a8f85db55cd566be5" "0c8e1a86f0082ce9176c1d5634737973daeb779066add99a78ea8dafc09980cc" "9be61dbb855a284e21f3657d2765eeeeef798bf858c5fe002ad0a3cf319545a2" "4eee3605e315a50a45ac3a3e1331b76428ad3d57b7c0b26c888cd1720d85f7f0" "070e6fbf795c51241a34a1d9f7c54e1430e950c6bbe56d3c633338d519b7141a" "d915c02cd0c602e10c2cbbafc1c84c5b576e76eb43380c43d30051933e168a24" "cbbc1519cc25b2e8f864ebf0ad541e098ded3154bbd9dba6aefea74a0bfa207a" "3576342cc1827e1c025c4749ad66003eb2b2c997eb0aafc3d091d6adf74a888f" "f056dd2febaeb2c1b5cde5eaf85b35891878a41c0aa26bd6a3eaca40e8038832" "e76b9325a73d9ecb1bc1e2e66921d692f0bb4a5c211c5fa4ab307310f05988f1" "736e6c5af9e1dd099944f1f2a28b21004e0459971b79b4f6487e4b0f46045873" "1a07f380ba74493faac33f7abdf1dbc06b44e7cbb1d2b6ba00845e63df07719e" "835bd27aec9fe9f622aa124b8b30bc5e9eb24973fb661379f12dc7496a44305b" "04bb3dc9d02f8b34e518f34d5dc6b243d68581ee129e0c3385939969d23b0267" "1c2e48021bc30929df5f26d2006847d4b38686d6c6dd9176bc6c106f5faac58b" "da60697355ae207a824dedeebf62344eed2552cd6f964cd9aa853528f836ae04" "b32108f49a91e9a91e3fd43167a28efeff3569a9fa0387c8adaa7b5fd8253c3c" "1c77618d08452a7f766c975c533f3e958b8b859a60a185c67ed0d081735819d1" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "c9883e7cdd68fe4f9e4e14a8436e3af549542320a4ba48ce813da8d06a7152e9" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "c3fb7a13857e799bba450bb81b9101ef4960281c4d5908e05ecac9204c526c8a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "4226515beb6ca80245ca8e269386e16095a56122029190b2416f7607797c12c0" default)))
 '(custom-theme-load-path
   (quote
    ("/Users/umaldonado/.emacs.d/themes/" "/Users/umaldonado/.emacs.d/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/color-theme-sanityinc-tomorrow-20140318.527/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/cyberpunk-theme-20140630.1800/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/noctilux-theme-20140406.2/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/occidental-theme-20130312.1258/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/soft-morning-theme-20140410.1134/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/solarized-theme-20140423.103/" custom-theme-directory t)))
 '(fci-rule-color "#eee8d5")
 '(foreground-color "#cccccc")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(ido-cannot-complete-command (quote ido-next-match))
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



  (setq load-path (cons (expand-file-name "~/repo/emacs-rails-reloaded") load-path))
  (require 'rails-autoload)
