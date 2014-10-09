;;; Uriel's init file

(require 'cask "/usr/local/Cellar/cask/0.6.0/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/repo/emacs/")
(add-to-list 'load-path "~/.emacs.d/el-get/")
(add-to-list 'load-path "~/smyx.el")
(add-to-list 'load-path "~/repo/emacs/powerline/")
(add-to-list 'load-path "~/.emacs.d/custom")
(add-to-list 'exec-path "/usr/local/Cellar/aspell/0.60.6.1/bin")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "/Users/umaldonado/.rbenv/versions/1.9.3-p484/lib/ruby/gems/1.9.1/gems/rcodetools-0.8.5.0/")
; Load el4r, which loads Xiki
(require 'smex)
(require 'json)
(define-key global-map (kbd "C-c o") 'iedit-mode)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(require 'evil-tabs)
(global-evil-tabs-mode t)

(require 'undo-tree)

(setq linum-format "%4d ") ;;; add some space before the line number
(require 'linum-relative)

;; Disable loading of “default.el” at startup,
;; in Fedora all it does is fix window title which I rather configure differently
(setq inhibit-default-init t)

;; SHOW FILE PATH IN FRAME TITLE
(setq-default frame-title-format "%b (%f)")

(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))
(require 'workgroups2)
(workgroups-mode 1)

(require 'rcodetools)
(setq ido-everywhere t)
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

(require 'column-marker)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(setq initial-major-mode 'enh-ruby-mode)
(setq initial-scratch-message "# Scratch buffer with ruby")


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



(setq-default truncate-lines t)
(add-to-list 'load-path "/usr/local/bin")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(load "common-setup.el")
(require 'elscreen)
(load "ac-conf.el")
(load "ruby-conf.el")
(load "evil-conf.el")
(load "evil-star.el")
(load "elscreen-buffer-list.el")
(load "yasnippet-conf.el")
(load "helm-conf.el")
(require 'helm)

(load "projectile-conf.el")
(load "org-conf.el")
(load "smartparens-conf.el")
(load "elscreen-conf.el")
(load "ido-conf.el")
(load "undo-tree-conf.el")
(load "~/repo/emacs/evil-org-mode/evil-org.el")
(load "~/repo/emacs/powerline/powerline.el")

(require 'icicles)
(require 'evil-visualstar)
(setq mac-command-key-is-meta t)
(scroll-bar-mode -1)
; my keymaps
(column-marker-create column-marker-smyck-gray smyck-gray)
(add-hook 'enh-ruby-mode (lambda () (interactive) (column-marker-1 80)))
(add-hook 'web-mode (lambda () (interactive) (column-marker-1 100)))
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
 '(cua-rectangle-mark-key (kbd "<C-S-return>"))
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (smyx)))
 '(custom-safe-themes
   (quote
    ("c3216ec9b93639a9c4e4c1b86fb64aa664c863f7316f60c15a77a78805e01371" "ffeb540b4dba1f83f082bc6cbb43c843b70a4ba6ba07d054a4ec0dd160a0acb0" "be0d035ee425dd18e851c151020b23159e8e7a27303e8963be5e584d8f23d541" "3e9d832b8c00b481337c4675fb9e2d52773266a92f7c492b19c2271066da479e" "6d3ceca56c89480c0f9960451f349919c639721be6b186234d39b99b7cd4eebe" "8f4eaef11a44adfd9a22d821e99ae9c9bb04179cbc326c4c8f48a2327889029e" "b066990842275552123bec5c777a2c09bc5e0a06ac4d44ab20518a070972dadc" "27c2f4ccfc66a26e79caaff47d358a1a796fb82cf92f5febea9068656fb56af8" "e169d291779cc8fd3cc859fd03a8b4a2e69c3e256755ea97cc6fd4b30a3cc997" "e4cbdcebc94d50fcdcc88a4296d9b59e0194d62cd6b57cb6bf50bd3a51b84056" "7145bde5a26d4d6e949299cd2e7cff57c9bf29fa52c404124731a233252727c2" "d046d9f97b2c0f2af0094133a888c6c19c48266fe793f1af1cc69c85525b4227" "be7bc7dfde6762de82f672576fdbbf50c88b4820bad36bc1269e3b2807899411" "c03be2bcad61828b5f3b9d9a9f986c1c8b893b6db2d1c01c1324f1fe8646bc62" "34af099379691e60301af42450aadeb637dea2fcd56bbfb7dcac109c8890c79c" "1a6767ff9991ac7a82479a7b94fbb0c7917afb7f0651cfbe0da5d27481fd6f7d" "1fe2d5d68d83e615ea2feda31ff4c7418503725a392711025392bbf273bf5599" "b57ec97065a9688cb741e8cb47d1f2e55dc03f35da0a4dae9f89bfa081395a56" "ff6f2bfc50ef3ec15c92f5d21ae56dffa1f8c3293b4988ac5cebdc9dabfe8161" "5863922445ca8cc2c43c8c7a704ddb4a91eb2521c2e379b979ad17cdaf80b4dd" "7fe56fbdacc95035aacc13afdb579c2c0a3ad64d741f4ad9a3e426e71b6438e6" "be7434a9055886bb26f982810a8deb1049705ebf18181ff2118d3968fabcbaca" "71c001cf293430e5194347214ba9914b75a140227ed598b75deddfc03ea2100b" "2b22912768d64e62fcaf4051effbf083436da86528197841616f94bfd11c66c7" "3f89f688424a7d9d6306397ae7bc4d7101061636fd82c4657956373d937d956d" "76ed92c8e4355537e2363476d09739b994b20b5f0d7bae643863072bcf34d46d" "b81901a49258ae53e4badb2fc6ba3c6cd1201fcd34541d3bc3f662b6af10c282" "3972ae6211ab35c0292503725903c8a08195fdc5e8b29d98a1fb508a55129824" "43fbd3a91fd9ebbca81f227d70dc1fa7a393cfbec7a37f62a39801df017cad37" "cd8b75d53e299b8371262f1845a5579ff19418d1e0138338cf2c48f84a836ef2" "7f9b34c22cfb15b9bd39802495330a839b1d3e71c19c89f35c88bf9df45d2ea9" "5342b8df5323f18947337c7284b2ac907f0f32e0c746aa5014e66b8c27cb84c9" "99442ce400f34590abb2341098f8c287f1b059dc86527b35be8c5aefcf55e532" "95d85175278df0b55bdfdf7c344ce0363324ececaae420afadcb57333925656c" "493a5f394f146b7b26a25604cf84628e178fc7aa6c33583d18e9bbfb04d9e6a1" "575a0075ed3c816602bda44b761283de05b2f04732c918bddf192321b6ecc8a3" "8475f156b66e57a13b04b744e55defb473179f8bde86b5e1739356ceb25aeb37" "08e122c7fb04025c667e770fd6f568abf9e831b128da1be0f7e746e5474d9d5a" "3f88f88d8d54422f058ccf052d9064dc131bd10abdc0ff8d631de32a0e32ae1c" "e5726f6bfc4764ee8143446f7d1f1f45a842c60b8af6df1ce634c7e62518c34d" "cbef56e3d0135eb97d7c742aa39c79dd24fce3274e6918bdfb4f18e4f46c6b46" "b9a9fb025a6068a61476e6a6f6304b62826d4ef32d1ba0aeef79eb3c54eee1d3" "f37a804402638deb16745f066339b23419ecd74263a9adfb636dd51ce04b91ed" "55fcf7214995b53a38b2b59f50623270f58a4f506a627906b47fe8ed82a68aac" "4d75b7a1c01684d3a5870dedd4f29063e1d9ffc7dd2e445e5edbbb842ce3933e" "81c92c7988ba81129fa036ef6efa40e3d51e60ad142e026e80f2bb83fe161848" "5435c47006b07cb2a6fb48dbe9228e9897131e272306ae4079b2cb870bb25aa8" "b3a422f4f9e67dab896869ac3ad308b27ea414898bbed5fff81d2ea4bee1d976" "4acf366fb0792cd0557444c3f4698a9bbb042dfb8fdfe56bac81d17593da9e24" "b199e94ff52306ee099d54a6dcb35692fba6271fdb6554384d6462257f72946c" "0b93a9339669a09066f373f10e1136ece094af7aecea7017235ea3054b5838ff" "ac81c682899fe1b0cfe34aaa06b919ec862b37c9889552e740fa9ac318b51d12" "ac56441451d245eb2d18952bbb5f5035b1423642bf968bd84778322f588360a5" "5dc54c53bb4a2dcd821c3a55754c47967391440ff171fbf341b9cfe23b3b3536" "1ae286a68e83b6299921f9b9596b4a1db4bb79c85ec4a6f20db2b0460e9279aa" "743b366b9a42bf0be5b7338a98d916b1fa83707df3303ffd622d4a3986edb8ae" "0eb7ded10bae38a003ddec3c6c08a4e80ca854a8c44fb7c7357b106c2547f292" "9bc2271b2d9a89e9460550d4439ede5df2875bc8ba057e4d5caef09ff854f552" "666e5c46a49fa9d1f58246ccd3bd0667d68444b65492bde361ff0e9d06107263" "9476d93dab122c80e44a6fe49d6092ddba7c0067bd75893bc3ffc16726b62813" "0ab209366760d247519d60981ccc427dd094cbc744122593d439edb30d34d408" "1d8c25588dfd788e26ddda2af2c2d4f869e5ffa36b08be9eebd572ae79f14801" "6a236857be9e976fa7ca07f7c32730e40dcc14b49f0ee343a4b5657035f72653" "439abd218d1680274369f9c8e980ea17a7b3593f1464e92132a5ea9cb4d2bdd8" "3d9cf4e8f37c0298d3065163294a51e3563831fe052705b8aeca074fa85d0911" "8511d748fa207fa55db103b246c4a0c9fe26ec7900ca6e4b469981838234a09d" "d82aae3142c428dcff9eca9c86b59ba298ba3c673b36c70c1ac26afea1a2b962" "8005c9a548715eb1b3ac3c10c131604de07811ea0b6132e7126fb08805d31cc6" "2a1525294833ba37e03869e4dee97cdf1abf4a0d4d12e333ccb07ec354f81d26" "16bf83b66d17674b1578666db4e760eaa54ec9a73f29e887704016267dbb1807" "bce5d36a5d627bec39ebaf304c92698be9a436c76e0a373847d5ec7239425a18" "d8ea7f9006809e7b02bbaf160a8ce726fadb5254c76dd12e8542e170d5413f2a" "886b2635901c51682ab5e1a6a39e08e1c18280ab68106cf33b9acafb96daa5d9" "f62834f7f6f3a8a7de7ec92015293c6a1379beb9b61c218cff8caee074a659d0" "bbe03a4f0954f3bc0d050929f955fbc92a13cd681e1571918e8b9d549f748de1" "253f36e81ce42ab7af8f00a5cfd8811b7e58c670e42b5a0a81f7d9c7fdb7abc4" "ffb3d34b73c8076532b72f5b793928e87b48ae506453d25d57763aa6fb45d795" "53516b361a1cef5ed33c904e4fef7d9c7b6db100e051639689b544d751070010" "66f2238a3d2f3df65ba96f4de312e5c410ab77128e739fbc86dd473fb6e49b36" "cf3b3c081bc30e4df0ac543c407e0f8f1c9a8cd664a0e10c794f5e42dfa646c6" "48f3a39e6f19889a8d6cd19078a16985ebce09334644b6a9a7dff8be28994810" "cf19e513c8c7652d2677eac7af91308c4dc70094456e0eefc326ab76a1d78816" "61fb08a8b8d505347d212e5678a0385ca9263a90eb3eba38da74a2e202f88727" "e8493ed643ed18b406a4a3baff6158e32fd7c88ac21f30ac7cbfa42980721cc6" "ec8f9cc41241c6c9ccf3e72d1912fac099fe12d7aa6b6df54fbdfe397bfcda5e" "8f88625122a406078ed985be5a4e4427804c493586da380ad42daf1d46dcf5bf" "b5ac4acd1b79c0aada44337ccc6185069261644ffd5773806a2b46f94acc34cb" "1a2b62d96e591d9f6c6e0c6bc2ad77790e221754fdd853483fa615d9e6ef2795" "23d4db591cd1a8d78580c93b4ae89436a2741e85b14d1c94dee5a64b764213b7" "621df3773f142dc4550d494547e8a8772ae17620ded6f706c99deb91bb377909" "15eb1a59f3f0de66753a0e3419468598431a2ddceb4886c06313cd5d97ce737c" "e49afc849e0971de6c9a00f041e816c2c45094434ba8f31b8d04406f4df675de" "8be9ec86d6329ad2f0c0fe142c9427dbe81d1c1ccae9be37f9a761b1dce885e9" "2339f4d399aead44f76ed6ebff528a962b3a2904f41f04006a34ea0a5fcda2c7" "461cefcb020ab2657918d82c1dd4eecda5935cc19102fb139308ca79c19f680d" "66d687b21f1000aa833cc307964c73c03c7fb34c56860742ace7a3c14d91915b" "031b161b4c92e79017cc7aa534be163a22754ae276873294510e8293c5d50457" "c95bd5f8bdd59b765373161f0910def5cf9fded2e8ae1c94bd1a29dd06a2c676" "1240a6acbe5dcde0056ec2a73dbe2443b8ae7730074b38dcfb55718b6a88ef05" "0fc79ed447205a76a651233a55e434e6abc9e8a7e533c621cbf7f8b133a0204f" "df7cbbdc7289a7fa89f9099b51ab3088b33aa8851d9502e8fd4666231598faeb" "1c33bd09d62e58a6398d8d50accd6b30b6e18a615adacdc24c4c66ea724ef1c0" "a12fb2ab40be4c133e41bb57d517ea0c93b2b0f6bb32e5a883dd6bcfb5bd7945" "adabeef569215c19cd321d6791aaef6468ce3ff7e31d97c55bee482eb36b73ba" "dc693dae5fb23c686064b9864f3aa67334978aad9f4eafc35879bc4749eb862c" "aac592596645a0129b33994daefa3a8584239102507e412924c5d5163c5243c0" "886d5a10b353785bf1b1278c9b14a63ede5185bc5e0db5f8a2b7cfeed6f073fd" "8efe54bca71ae7f04d7a733bbe378ca36d5b51117b02fe7d7de7ef9ba3df245c" "e8a090b48a1dac089d0246006f05034a1c6387127bc7ee0a760165cfe384597d" "dd32e0cf8e0c956d3c6b0b044b0fa087bc79e378b9b5337ab5b8f857d556d89d" "d40d64f3ec2d594827cae5f57a64b8d8a5c83e7d6e1ad40454b6a928412e6b7a" "aa487e4be5b26b49c0446f165aaf0e199da8f03c9f30cd22925c3cae24fc05ac" "2d3f81d8da48fefcdb211a4348ad3a2cb89d6efa5cdb1f2cd391c5d8c274ec0c" "04d5ce0b7f35675e161ff630d9d8cc6d6742813da6a81f46694bd6047b1c55ca" "7c1d52c24a22e096742adabaf9e5a8a7ce141b60ffde44f676a02f77a20052e0" "2e94bcffaf0b57262cebc2d82eb4dc3fcc1220f0c5dfc0897ff1756fe4acc315" "b75476d72d5f11f79a3404e22ab8fa82ac14d1bdb8693990ebc000818628243e" "fa948f1f017fb1c9f9d65eadbca9720ad8ce878f9cbf1a136a4573a88ccdf0b3" "ab2beea55d71f3221b38af74a02d5ac725477c571f73454c8ff4783d75cf170f" "c19b5844037e24cd6b30930da758d9f6649f9d072a390dac1376f6b6a0a9c077" "0857028b49b9c9b2756a4d9ac53e5a264b5d152769e1d29000baaecbe2e55da8" "e3e4ec49145c0801957513b8c1b625a136ce6c9bb22057b1eea308d167f3f6f2" "98cdf4e626510742021df12c4241bc9fc560e20375951b26308cc72a01e21798" "d78f69ae3ce53f082d66d6e29f4c30b9a703e9da9ebca43dbe4b187f3a3428f4" "d34fda9feb8114daf3433608527be777ab1fc9297c3923f057ac93fa68acddf5" "de6bfe40d0156ac77184a72a864cb003488f2d11106fc83a134b0169ea472323" "384f92e44dad7ae8a1c8fb5fcf4a9d9fde836ed4dbcb3a353beae2ded97e429c" "36084e348dd9a87be5064a54f390fcb5b316ab1c640d06636dc07b7bf247b788" "ccfb95726127685d99bec1364476347d99123ecafcbd50a254b349072392f568" "709e6bf70b9727e0a8d17c83e987d7da8f7265a8e8dd357a8f85db55cd566be5" "0c8e1a86f0082ce9176c1d5634737973daeb779066add99a78ea8dafc09980cc" "9be61dbb855a284e21f3657d2765eeeeef798bf858c5fe002ad0a3cf319545a2" "4eee3605e315a50a45ac3a3e1331b76428ad3d57b7c0b26c888cd1720d85f7f0" "070e6fbf795c51241a34a1d9f7c54e1430e950c6bbe56d3c633338d519b7141a" "d915c02cd0c602e10c2cbbafc1c84c5b576e76eb43380c43d30051933e168a24" "cbbc1519cc25b2e8f864ebf0ad541e098ded3154bbd9dba6aefea74a0bfa207a" "3576342cc1827e1c025c4749ad66003eb2b2c997eb0aafc3d091d6adf74a888f" "f056dd2febaeb2c1b5cde5eaf85b35891878a41c0aa26bd6a3eaca40e8038832" "e76b9325a73d9ecb1bc1e2e66921d692f0bb4a5c211c5fa4ab307310f05988f1" "736e6c5af9e1dd099944f1f2a28b21004e0459971b79b4f6487e4b0f46045873" "1a07f380ba74493faac33f7abdf1dbc06b44e7cbb1d2b6ba00845e63df07719e" "835bd27aec9fe9f622aa124b8b30bc5e9eb24973fb661379f12dc7496a44305b" "04bb3dc9d02f8b34e518f34d5dc6b243d68581ee129e0c3385939969d23b0267" "1c2e48021bc30929df5f26d2006847d4b38686d6c6dd9176bc6c106f5faac58b" "da60697355ae207a824dedeebf62344eed2552cd6f964cd9aa853528f836ae04" "b32108f49a91e9a91e3fd43167a28efeff3569a9fa0387c8adaa7b5fd8253c3c" "1c77618d08452a7f766c975c533f3e958b8b859a60a185c67ed0d081735819d1" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "c9883e7cdd68fe4f9e4e14a8436e3af549542320a4ba48ce813da8d06a7152e9" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "c3fb7a13857e799bba450bb81b9101ef4960281c4d5908e05ecac9204c526c8a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "4226515beb6ca80245ca8e269386e16095a56122029190b2416f7607797c12c0" default)))
 '(custom-theme-load-path
   (quote
    ("/Users/umaldonado/.emacs.d/themes/" "/Users/umaldonado/.emacs.d/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/color-theme-sanityinc-tomorrow-20140318.527/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/cyberpunk-theme-20140630.1800/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/noctilux-theme-20140406.2/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/occidental-theme-20130312.1258/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/soft-morning-theme-20140410.1134/" "/Users/umaldonado/.emacs.d/.cask/24.4.50.1/elpa/solarized-theme-20140423.103/" custom-theme-directory t)))
 '(face-font-family-alternatives
   (quote
    (("arial black" "arial" "DejaVu Sans")
     ("arial" "DejaVu Sans")
     ("courier" "Monospace")
     ("monaco" "Monospace")
     ("xiki" "verdana")
     ("verdana" "DejaVu Sans"))))
 '(fci-rule-color "#eee8d5")
 '(flx-ido-mode t)
 '(font-lock-keywords-case-fold-search t t)
 '(foreground-color "#cccccc")
 '(global-auto-complete-mode t)
 '(global-font-lock-mode t nil (font-lock))
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
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/repo/")
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(safe-local-variable-values
   (quote
    ((eval when
	   (fboundp
	    (quote rainbow-mode))
	   (rainbow-mode 1)))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(tabbar-mode nil nil (tabbar))
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


