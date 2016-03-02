;;; package --- Summary:
;;; Commentary:
;;; Uriel's init file
;;; Code:
(require 'cask "/usr/local/Cellar/cask/0.7.2_1/cask.el")
(setq thesaurus-bhl-api-key "01e6e9275c9816aafcd3ebb25cef7205")
(setq package-archives
			'(("gnu" . "http://elpa.gnu.org/packages/")
				("org" . "http://orgmode.org/elpa/")
				("MELPA" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(cask-initialize)



(setq inhibit-startup-screen t)
(setq initial-buffer-choice "~/uriel-repo/emacs/welcome.org")

(elscreen-start)
(require 'package)
(require 'hydra)
(require 'powerline)
(require 'helm-config)
(require 'neotree)
(require 'ibuffer)
(require 'column-marker)
(require 'ido-vertical-mode)
(require 'ibuf-ext)
(require 'linum-relative)
(require 'undo-tree)
(require 'yaml-mode)
(require 'expand-region)
(require 'guide-key)
(require 'tramp)
(require 'smart-mode-line)
(require 'pallet)

(yas-global-mode t)
(persp-mode)

; packages not in melpa
(load-file "~/uriel-repo/private.el")
(add-to-list 'custom-theme-load-path "~/uriel-repo/emacs/smyx-theme/")
(add-to-list 'load-path "~/uriel-repo/emacs/web-mode/")
(add-to-list 'load-path "~/uriel-repo/emacs/evil-eww-mode/evil-eww.el")
(add-to-list 'load-path "/Users/urielm/.rvm/gems/ruby-2.2.0/gems/rcodetools-0.8.5.0/")
(add-to-list 'load-path "~/uriel-repo/emacs/evil-jumper/")
(add-to-list 'load-path "~/uriel-repo/private/erc.el")
(add-to-list 'load-path "~/uriel-repo/emacs/rainbow-mode/")
(add-to-list 'load-path "/usr/local/bin")
(add-to-list 'load-path "/usr/local/lib/node_modules/")

(add-to-list 'exec-path "/usr/local/Cellar/aspell/0.60.6.1/bin")
(add-to-list 'exec-path "/usr/local/bin/")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Custom setups

(load "~/.emacs.d/custom/common-setup.el")
(load "~/.emacs.d/custom/yasnippet-conf.el")
(load "~/.emacs.d/custom/evil-conf.el")
(load "~/.emacs.d/custom/evil-star.el")
(load "~/.emacs.d/custom/helm-conf.el")
(load "~/uriel-repo/private.el")
(load "~/.emacs.d/custom/projectile-conf.el")
(load "~/.emacs.d/custom/ruby-conf.el")
(load "~/.emacs.d/custom/flycheck-conf.el")
(load "~/.emacs.d/custom/ido-conf.el")
(load "~/.emacs.d/custom/undo-tree-conf.el")
(load "~/.emacs.d/custom/hs-conf.el")
(load "~/.emacs.d/custom/org-conf.el")
;(load "~/.emacs.d/custom/auto-mode.el")
(load "~/.emacs.d/custom/hydras-conf.el")
(load "~/.emacs.d/custom/erc-conf.el")
(load "~/.emacs.d/custom/elscreen-conf.el")

(setq magit-status-buffer-switch-function 'switch-to-buffer)
(setq magit-auto-revert-mode nil)
(setq persp-modestring-dividers '("❰" "❱"  " ♦ "))
(setq ibuffer-expert t) ; dont ask when killing a buffer
(setq-default truncate-lines t)
(setq neo-theme 'nerd)
(setq recentf-max-menu-items 25)
(setq ido-everywhere t)
(setq-default frame-title-format "%b (%f)")
(setq inhibit-default-init t)
(setq system-uses-terminfo nil)
(setq indent-guide-char "│")
(setq guide-key/guide-key-sequence
			'("SPC"
				"SPC e"
				"SPC o"
				"SPC r"
				"SPC h"
				"C-c"
				"C-x"
				))

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
	`((auto-complete-mode . "AC")
		(yas/minor-mode . " υ")
		(yas-minor-mode . " υ")
		(yas-global-mode . " υ")
		(smartparens-mode . " ❨0❩")
		(smartparens-global-mode . " ❨✷❩")
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


;; make tab key do indent first then completion.
(setq-default tab-always-indent 'complete)
(defvar rotate-text-words
	'( ("true" "false")
		 ("put" "post" "get" "patch")))
;; default terminal application path
(defvar iterm-path
	"/Applications/iTerm.app" "The default path to terminal application in MacOS")
;;; function to open new terminal window at current directory

(defun ugm/open-current-dir-in-terminal ()
	"Open current directory in dired mode in terminal application.
For MacOS only"
	(interactive)

																				; open a new instance (-n) of application (-a) iterm 
	(shell-command (concat "open -n -a " iterm-path
												 " "
												 (file-truename default-directory))))
;; Thanks to: https://github.com/winterTTr/ace-jump-mode/issues/23
(defun ace-jump-two-chars-mode (&optional query-char query-char-2)
  "AceJump two chars mode"
  (interactive)

  (evil-half-cursor)
  (setq query-char (or query-char (read-char ">")))
  (setq query-char-2 (or query-char-2 (read-char (concat ">" (string query-char)))))

  (if (eq (ace-jump-char-category query-char) 'other)
    (error "[AceJump] Non-printable character"))

  ;; others : digit , alpha, punc
  (setq ace-jump-query-char query-char)
  (setq ace-jump-current-mode 'ace-jump-char-mode)
  (ace-jump-do (regexp-quote (concat (char-to-string query-char)
                                     (char-to-string query-char-2)))))
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
(autoload 'ibuffer "ibuffer" "List buffers." t)

(defun recentf-ido-find-file ()
	"Find a recent file using Ido."
	(interactive)
	(let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
		(when file
			(find-file file))))




(defun ugm/go-to-api-branch-at-point ()
	(interactive)
	(cd "~/repo/api-socialcentiv-com/")
	(make-frame-command)
	(magit-log)
	(delete-other-windows))

(defun ugm/delete-buffer ()
	(interactive)
	(kill-buffer (current-buffer))
	(delete-window))

(defun ugm/new-entry-proj ()
	(interactive)

	(find-file "~/repo/org-mode/projects"))
(defun ugm/transperancy (num)
	"Set the transperancy of the window."
	(set-frame-parameter nil 'alpha `(,num ,num)))

(defun what-face (pos)
	(interactive "d")
	(let ((face (or (get-char-property (point) 'read-face-name)
									(get-char-property (point) 'face))))
		(if face (message "Face: %s" face) (message "No face at %d" pos))))

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

(defun ag-projectile (string)
	"Search using ag in the project directory for a given search STRING,
with STRING defaulting to the symbol under point.

If called with a prefix, prompts for flags to pass to ag."
	(interactive (list (ag/read-from-minibuffer "Search string")))
	(ag/search string (projectile-project-root)))
(indent-guide-global-mode)
;; guide key
(defun guide-key/my-hook-function-for-org-mode ()
	(guide-key/add-local-guide-key-sequence "C-c")
	(guide-key/add-local-guide-key-sequence "C-c C-x")
	(guide-key/add-local-highlight-command-regexp "org-"))

(add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)

(if (not (getenv "TERM_PROGRAM"))
		(let ((path (shell-command-to-string
								 "$SHELL -cl \"printf %s \\\"\\\$PATH\\\"\"")))
			(setenv "PATH" path)))
(guide-key-mode 1)  ; Enable guide-key-mode
;; (sml/setup)
;; (sml/apply-theme 'dark)
(rvm-use-default)
(global-evil-jumper-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'term-mode-hook (lambda()
														(yas-minor-mode -1)))

(add-hook 'term-mode-hook
  (lambda ()
		(setq term-buffer-maximum-size 10000)))
;;; BAD

;;BAD

;; Disable loading of “default.el” at startup,
;; in Fedora all it does is fix window title which I rather configure differently

;; SHOW FILE PATH IN FRAME TITLE


(ido-mode 1)
(ido-vertical-mode 1)

(recentf-mode 1)

(scroll-bar-mode -1)
(global-linum-mode t)

(global-set-key (kbd "C-c A") 'ag-projectile)
(global-set-key (kbd "C-c d") 'ranger)
(global-set-key (kbd "C-c r") 'rotate-text)
(global-set-key [f8] 'neotree-toggle)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "RET") 'newline-and-indent) ;; Auto indent when you hit return
(global-set-key (kbd "C-c o") 'iedit-mode)
(global-set-key (kbd "C-c C-o") 'ugm/open-current-dir-in-terminal)
(global-set-key (kbd "C-c C-k") 'ugm/delete-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
	 ["#191919" "#FAB1AB" "#CDEE69" "#FFA600" "#7b68ee" "#FBB1F9" "#77DFD8" "#F7F7F7"])
 '(custom-safe-themes
	 (quote
		("d8be6bf397f6b9021ff0f84c38c838259b31b19a4b8b37e79edae8ade9834a9b" "a83d71f4fd49f619b0fb56297732ed34f719ea20425e656dcb0a2d8df6d81c6c" "c76469ac42d89a5008d35ceb5ee12db4211ee0602ca86e9ae252c5de7edd6c8c" "bf6b8939c7a3685c7aa1b4ad4a61606915f6bde4b0963fc33ea72f01efbe3213" "07eead7bfbab5540c58cce1dce18ad1c5e01b8c4223c5985ce840979953c2be7" "bd1bfdeaf852c29c2504b44d6462090ea101b439746b9fd8ed3fae895555c81f" "914e59a7236443986197a1f257d6df83826a0cc0f1d51688859e4e3e359320e1" "3bac07bb731bdb81b66af2f42503dba65109677464ab0f79d2c89e7b6bbb5b4b" "fe0165c2428e0be6b8e2885709656a5132a23aea7380b88a8270b119d4c5183f" "4ebf0a920b177c8f6b9afdef33a1c38fada719f81a5501dd2487afcf41cab220" "a98bb4d85114dc5d8ad5a3a3de54f7c60c9e3a58b378634e729a8131c52374cc" "8e9491c1f95e67e34224cb50df179d33394d0f820315ae7f890505465aa5660d" "6ffec349e97052d5b985ea476b90675891d2f13b7205a748799582517a2da618" "aaa3bc45b89c0d16f248c9f9c84f2e7b3e81c97c5073571710b7b7cbe8ece172" "eaae9f2e418a9c0d429da563a73c78b73a44b4293f782e455f264f2c59bd3596" "c1b7bf3f37b101a6401c8bcd4629d40fa7e8ba1d8f5c6ee7a024fb53fc171191" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "f685736abbfaf09e605c423bf425381dffe5d50265fbfbab8354e3099ecedffe" "bedd493501f498e12c015e75d5a3a4b4fd6059031468e44e83af713c37007a59" "2139f04bba7f2d9481a086d01d9861fbf358df34d1e87d0ea2bd455566a408a5" "7aedd32bf5b9504344138f86e3a4e548fef36ed7e67b4cd6a211a94dddd2417e" "018f19ae247d7f783b801f33302b685d98add7add9f6ec3f2b75cb23591bd234" "dcb49b6f70742ad5c899283a50eeebbdc608f87217e8afc1c3e3d300e003b538" "4a5125deb46b951d11da2be542f11198b92d8f9c967ed4dafa7c732bbd55dea1" "2ac47b3e421310724ca1b32109c70477c296c5abc2e3c17b7b6e24dd28cc3e3e" "0a59785d697a32bada4c32f575fd5921debc8c7cf0e06dc7b82ce0d486b939d7" "967ad92553908db85e74f01834a5605138a02e4b194e6a5975dd019b152bbf43" "52d0a94357eeaaf27471f1e41b625fa937843c0b7ef0eca7ec66116be645073e" "940c7d91603175a689d0f3db03ab2a6d1906f987bfea6989efaae34fb77bd130" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "060c13412352d6e4b69c963943e3233bc447a25807c46a5865bc0dc199c35864" "8740fab27bfaa85b4e35201ae7533dd3148b8dc19e5ec45e05991d69b5c6de98" "23423e4b8a6904c5dfc2f9c54539c64fecde5dda5b7b8757daba1b70cef59e57" "f89ea8560f52aad38edab05d6b91d271ed8589e4ac312393988e4fbaaae3cbdb" "f448d51d2ecc2f26125475ed4bb02cb27f997bfb86c55257f18045f55ff87727" "2de9700d8170db55085a29e1fb2bfd00e712dcb7579c0a8b6cc32286f216feb9" "154f9e65ec17133fd0caeab57e8736e872c6a8165163471847abd96d1f4d5c5c" "d3790a4aa06123f169aa1231c12c0283eef7bdfc064d9cf5591aa43e0d4172a6" "2e83f1d22e9cf83a2e4de667fe1e75b5258007f941a6487110337aa8d12ffe77" "d863fce077ed36e135d06612421f8eef52f1695ed471907a4835f60435e0b110" "4310fa6216922dc70478e92bff2913ecbe3234c7d0a43217723ba60f23f7a59c" "71e007959ba25e218ee9fb983b0012d06d71ab0d2ff0a4dc9f47b011713cde38" "71e0239924b3189ccd9b2ce5999e89db4e8bdf8f63e8ff8892dcd207b6a18b9e" "d6903dfc2c369e4167ac401b97d962fc4219023d7430d1f6ba84b08b0eea3e46" "635f05f834dae55ac83ea048db5048473f82161adced958867aba54244adff5d" "b13cd33c9ef59c4501d1fecc874fc0a7c080907f8c10519f3d820eb426f10956" "c90f3d1cad362986eb2853474135a160f60904a214af9157905be87844479f69" "d0307b3ff49c31333ea9d732024079dc5c71cb20e01c1d7031ba26385dce63b8" "c60f2ac915d367fd5f7c72902891546aade2712be85e3341c2b13eca82d40a98" "686dad28b4a7ff4e2daf47459eda993f9433de0ec8d8d69b8b651b934ebc42a0" "71b6e11f3540dbf65469da905d454b75d3b1343a1ef828a510c0e497907e9b3b" "f6770805c6048faacd77b869cb59dd1d096024f0dad0570ef678b099c9bb2d09" "2959e67ce5a2a986f28b2cb7eb551856195e24057af269eee799514ac09dc8f4" "f1c9f7844ccb730a77c7953a2a05189ec98dded1f3eda14539ce33d88ea345a9" "d196c243b372813ae1a29bbded46f23da83d900d8a04183127aac9a8eabf3bc2" "f4303212ea5743e1a6285a31c23a745f85662e047fa5cb8bbe0acac3cc9f68f4" "7f5c8144809bedbc5e86d590dd91b4e6fe6c5bb9e58e4c523a753c7f75264891" "18afd01bdf26af22762b8233cb3c32112f436d6a477261a7ea38413c91d4786c" "77ae2746253d13f8d1df958637d87c7e9f51ba06c18b28dca6a64dad620ccee2" "3a3980d33a9098fb87aaacf39c2d5b425723a35cf30a98cf9ff332a2333faaa9" "77dafd86c8e9b08e7997ea1a6fbf1996be5cb87ddf57dfec0b9580120449f4e6" "0d8f9e7df9c57dc56062a89802ef0ea4d80aa0d2a11abac079d3c51d89cc1c3a" "5c7c9258ddb4a2730b236665b5483fefb879681ce3f112893c5027403e23d759" "18b4f47fa14bcd9744cd697f6c9dc404d91b767d89e14eeb0641c6fb3da25bc0" "de3f43cad4e79454514dcd215b3745c7e1b690d268e606b299904e75e35f21c9" "84ef42419dfc0d07986b82706b5c91190863411402456720e6ef526bf3be2b5f" "74601bd84e8336d5f2b129eca958fe1d80a25e0ae323e87b0e1252966ae2a760" "70c6781fc4d56b96f6b6b20e104768c8fa4527c7387206a0cc8863b561dfa8e2" "d534fa166ef99cd0d4c760115f9f031e68670e411c451e07dec614ebb3f2ddc0" "bbce7a7ff7075d580fce157df7c49aa1f62fadf323be60712987f8b186ac291a" "84c350d610b05995158c7cf321a481fbdcdba699a79fa98fc0ee7a1dbb9ad0c1" "0589cabe4289771683e80cd812120dba9507d813b7785b7c73f7cb428c472160" "7dfbb2d5dbf70fc3e1c915029488a0eff43dfcc6dd146bb7dbaf98b08e0703a3" "bf3020d0d6312c52efc7b34e4858e944e156dba4b539cb9058e2e4ca07d982c2" "b40dc094b919f4336c5fb41fbd9abc3043a93f2bfdac4cfc652c146d5ff2aa8c" "602b2963ff474c38b11117fc0ba9a3a364cc0b539811388387e1d0f07ac318e3" "c63640475b0953ee8204d7c00ad66d6e1a3e1e17dd89bab35a3d5bee76eb132c" "95f8d657fc3af36122b39e70e11418c16e0d41af83d8021018c5cf802f6e1bbe" "b0cff4f5fe0bb45fed0fc4813a5c45ca08110b4fd721a00374014462d460ce66" "e2837ef6f5ecea572d32c405c7e13b3673a1b2fa3565061c770282ceedab7a96" "d57fe62f7f592c24c58294f6f13aab2ee58786dacebe1936c8bb33a237e6f713" "f78152d650aeed16fbb3f6b9d3514eb7afe5646ffed5cb34a6b23608d4dd6117" "8d1cdeaf4c253e8a7f1a224c9b9a7b526a321a5cd045e274c00e94e6f0af83b8" "e0acacaed6733c883082e3130b2b69f37e1befb7670992cbd2ab72bc13fb761c" "bf3e1f1d33bc10a55cbf642bb2e7f95cf55c096293f6a8aaab5a3273d6298abc" "f49b6f2067b3c3bff4fa22cc4cd215e90e0525ce6118379a7bda507e3ea7e204" "9aa59b3bb98184f7a762df661afa02530c1bda8f2f2af2359b37bde8ff4a38c0" "099513842045c23be80fd5ae5b8cf00183270aadc7851539d7ae932d8cd759ab" "289dd8af124626662e3a965934a1a6eb0a8147224903ff905731dad53132038a" "21713cb75a8134e4917146a6e0a652f8a7dec575b478e3e92a8dbf02a377a818" "4779b05296eb930692d6cf038a48ff54e8df8f19a4356ab62313af9f5fa85181" "ab7a51d4b70352bc0ab6112587e551ff2514dceb54ccd897aeecba0ff2445900" "32e5263245a1fe003060f919b7c2d4556ded8c9a41a579eab22e08bf876282b9" "030c65244010be7949b5785a6a8950cd27fcff71cf3b93e74ab3739b3e060b7f" "7bd47456180b096645205450b3b2833042e1d7cd0873bcc7e78e82f61c25ea06" "f006e357416fb143c69eb3610d53b26c20ee1fd49c161b9f855603e661b9028e" "7d0ca1b04392ddf2842dbf3e391d10423d98a8acb69f798f101bbc9848eaa64d" "ebca6e33bb5956b67b79f5e77b3e0c65a56342b5bf380b1b9fe4a46873da411f" "fe0c3f078f95636bd2f38981e0a36f441df9987bc0a37b90be1d84149b444976" "4a380cd50e8156f251cf5f3b1afb246aad1579646285085452fb6bfb41b1a23d" "09177aa39bab015fb2b0f2ac091e552ba68b438a7e3e4f008743d41553736ed5" "79d1aef500526a1c5309ad8690ba2c09ebb5b424ca56a63c8d29f217bd2a9a32" "15d4ce06c1a6c02a3b77b0173f2c207a0ba693170b777628c65e3d51d00ff80a" "9d8afbea2074461e6e3f6afb0aa4559c59f200ec55433f7c9d49a5c9d0ef1402" "268154d9c3f9ddaabadd54e2032b50f4151a0d6cf25414e2426f12e266d2e800" "cb110e3ce588516da96a88c9a6022b8cbe75409eac3685ff9ae87242e6258dc2" "3b3be61bb518e81496c79a690c4cc324ab2282d1bfba237ba1db00da30a344bf" "40c5e01dcfde469d8a76a060597ad981ec649eb40009cb3a80dada92a22d2658" "8911c07bcd8ed1aa2ee55181b8a276788d6f7983992adf7a0702a695c25d97cf" "0ea220363dd16e13825901b3625de1d9f7f3f5ced4dc9af2ed215fa1c9bfa6b4" "31cc544be0b0d366e43569bb8c75a67a68bd107fd251614f22f72d29d963f5b8" "422a250393eac396faad6810814806dd99e4ea09215d7f600b87fbf9563a0b54" "f699a329afe1d122b98209cae42d31cbcaaad5c119f77143200c4717516023cc" "d87d16c12562279b18bba231407e0e6547dddeca62d6827a403db789a09b7c1c" "03baca27f27d6353905eb401b5a4057000428380c87537a61ce65e50c50d9f88" "40a1e533c9c1db2e9a9580b4f3e167f775579458aab32acd69f27d14455dfd13" "f88af9ebed35d344b0a2d00010818a90ef6215b579fa7888c14827e61702c518" "b06aaf5cefc4043ba018ca497a9414141341cb5a2152db84a9a80020d35644d1" "f06ab469710e669dd07ff1d07c562a64f7fb376e5f1adc038b8df092bd3c8357" "f8c4be6357b4c1e74936f21af2969cc5e34142c2c6f23747bcf58bfa299fef23" "1d9f0f7032af489baf3b5c13ebbdae96fb758ccff9a3072685b9bdc28675cbd4" "cfd9c0a0e12b676cb98abc4035426323b7fca1a54639fd6f6295479ba3e91959" "67162d4cf6364e679c7fbf2cadf205448a59a83a34bb9543269742965aa5ff08" "599916ea1f5bf6e189e0b7542d087e38e10158017c4fa1acac221489531310a4" "411331c8782c5175381957576b7ab32f17771059dc754b1aa00a7e4512f47df9" "cc8e58b918b57ca21f9b3ccf2d2ec4d4cbda0f14301c6f794971342f658e93f5" "3edee8e747c137038d5c8f62025a084784e01ef76ff27ff9d6d2f5678cd585be" "64be6e9cc8632fca0351dc27af837e668a04d4280b6be8af02fbbd1e758c41ab" "218e3db3b1b0692e49c134299228dc7832d665176ebf6c0e4c188b5d928a3419" "4fa0efaefcfd053e977198b091085d79b9eadd02effdea4b2abdc028fd340407" "3d9c973bb05fd670c3fc4c8ce4f670762b8f2b5695440e081b53580b7c1c43f0" "fb002595a86803c244cd85a527a4a74b8df71b7edbf15b99f80164f6f5ff730e" "2fe6c6246ebe9358ce049f76a1239c76b9debd5abc5e293446d34f924e415967" "982746ebd90e93024a927d7a417a228148642bc8f5f2f80891c1901caf38764b" "5af94d1df032d42770a0c741505f530689a45bfc80ed4b133422af6caad0cb57" "1bca369f65c2bb70b5f1dc1fc69730760f75cde800f26ce7674e6c3a96dfd49a" "8f7eb67e53e91ac4dc74f265780359673dd6d42c8d75b751faa87e2cd22e5b7d" "2d6f351e142ba354bf8d2376c238efb24627e4c3dc399876afcace15cf81b3fb" "9c79ecb06a8bf28f782be50d8400edba9158dc8391412b852eebdf0c2dc5a491" "f56f9be51870f4a0b514d1abd842ec867686a6f63b01bf09b9b506db79b66636" "d83dd679c9069c3a8e5e21f8a267c69fef12e10a9988ed22f24e48f2cf140dcb" "d16fba8d9fff90681faf441057d8298e06e2df9ca1e6c625e7a616666b2e2522" "696d262c86617ed2f61f19a4140895c1c04575858d2c2d3f294c921f64a85b5d" "9d2d315abfec1c9d06e6fd306206192ccf4b7a90f3178c08cfdc313b837deefd" "5ed61ab087d26213df0ff826050af8234ace1a3eedc30f20c665105287eb7c1f" "5be7219d22ea620a17221ed1726774efc713a87f6d6bda178af2aca13df748bb" "8a9596b439fe287a74ceec43c399a1c7e1f7a7b0e32fbf97468fda41831a568c" "d683b7cf8bf6e08406f230555930772d2c11cfcb90a6417cb8e0b37ac4374d1d" "c68fa777c63cf3d2b55ea439b1f571ab23778a17b8fa646c4ac4df3529d38b32" "e81925a5b63a456e1280bcd0adc93edfea4e00b504a6876211a6094cd4e1f8c0" "ed06e0028dc1708de51db87eebdaebae6e8c03fe6a374f5caae3f6a990f49609" "8331e0d1e7291767ee922cc9f524ddb2e41fe3b9cb9fd87e872686889ba4d537" "e3bd6797c17578bcef7e8c30e281cc42ef718571078b3c83aa8b359435f00fe4" "cfc1359de8c98dcb100bb700c9b82f98ebe0b879192eb878f5c54f6235700bd1" "0e8b7aaca182c559345d72431d3e9bfe1a0dafca0229d8bef919d23715a9ff24" "c6dfec0bf27da01fd13b231713bca89c67a26e1c26dc0a3c84f2d4f5c6042b15" "863c38c18d2c932aae4e940a870699817d71be008ae21d6073b4d6dd45e27983" "e5e87e625c905e5e41bc353b2b1bb2091b5a64e21bfb257c3a159bc766a11763" "db63ae9f5db25d2b05749d5bd51561936d88627c6b56cbce51bd4f458b515aee" "4846b53cb61451b5805a57b836ecc1a761ed1f72b6d630047e88cbabb14dbc44" "7a5247c4e6fc2284fea4c9647f2fb41b65bf32daa0e2aba202f6ad4cfb69f9b8" "f3309d84e58c2620ca1a4027dc233ef481f6cd3de293fc9dab09b41dc9a6db3e" "40b0e96dabb8b5577182eaee95c82beb695bffb3dcb2209dd6c4c6e39fe1a322" "13e7c49132b293b2596d641aaf03ec14db2c4ca32015c98cff32e1359c6c9475" "b7bb46df8718296affced8ed429b95f96cef0b44b5f1aeee670095f501418684" "b539cb8dd37c76c2b2d80beeb342d78be5fa7e0700cd3fd7e020dadc06b0a26a" "4294fa10e0f0d7584226d0874812ff3d951227d7398a3a817736b0de85c04898" "5bef805729fe4f79b809cc69c1a69c3298d47a81d5ca57025871dd3c1430e3eb" "71a71dc2494a0d80c9fcc1b7f19376d32cdfa2938b240d52c7106f5adc268c5e" "00a47097e44218afaf6bd6ed6af9b876afe020a8b7bef36725156f8448185c6f" "b918b7c3917bb72c1194feb5a9e76a9950ad65496c770e640a77b033ed5f925c" "5f8270e98cee72eb7c5987d2affb445d23f32398aeaa73954dc9cf800a0af7aa" "8b2c1a0e7f262f47afdd26691fa2efdf7c9214dd6eca342ef1e36182992d597d" "f1d9bbc154217d3cd8b4702ab232a22a64a8fcc01298ba213ec52ebc3458b556" "b6346f308e1f51ce79cf3f471eadfb65d0546e9411427a5711b4bfa5825863d3" "7d9040c9bc49338cf0ab752f88d11017fb795366c6361dc7919a51a0427ec6e5" "5c882d4c1398aac9a5b688eda6f1675e2a26abb7bfc9dc6883cba281c96c57e6" "030e79e2d5262fb79b997c20747aa03a92dafee3b1f30b79670eb553429d5ee3" "fd8c67d5a2c3def1003dc1f4b9d7438ec4fd5e34560fd723759f5155f8515950" "215fb69582d72ab1be8ca60fd24c949b9b7c59b9e8001b6a51200ae4b144bc67" "12c6923015b7aa7809a7485325a44883bdb1af74f3c51e2d475e25fe4764babe" "9620faf8d21a3e25b402d16e962bf4ff4d3d4bfce60eba18b5b463f9b485fb37" "7253ac5f8a4de0f5f080ce7804c4d5fb7348ab198cbe77a2a9b075b209730c8f" "1fc1f96d1d96ec910fd69b85c84668cfddfb55a909abaad52e7d1a21158a02fb" "631a97dd23755893388892acd17d487e8c0c80e75c00d1e5e74e159f45863000" "374cea2e1d0c34aa40a0a8727079b5fa1d72b4fa225abf610e845399f8d716b6" "9444a75bde1be64fa27d8b232b98f21a5e5de3636fe1d9dc6b7a79c3a8f3f43b" "007eb0b20887cff73cdb757022906e2d0bd934336f7047f7c444b3313b811a36" "37c5f877d776ed50ec994fb2491a086ad2534b49dbb84cde6b7a6fc20dd46c7c" "db25516804456cb85e59681373d4254f11ffe8d915bb5fa5ffe9218126fad568" "fa0b7b72c98354b462a44c64aed57191243959f5c95efc3b97d5b47560056b01" "336add1d3bb55fd06fdd0b3c7b8f5b2797139c63a04cab4669699f6dabd73787" "4af20413300b3ef4b4f61276c5b79a259c23efa1545d7bf231aa47b19e4962eb" "64427b71e003c52e95b660dedc0d6d691e9505d41c7eed4868f9329e80b9c6a9" "b9576b1c0b17388849bdd12d2242c2d821b6f383f7f4124a9cd55daa139738be" "5d6584646cb677116469480386c510220a410e39cee2c5c2ad0f3434156db821" "9e6e57ef3df13707c2ea84124ed021b797a84a3958c88a244f6a2ffcbd2ebca0" "f8232b25932e0f4b42a5f2cc5fd4c186a99cb9d2ec59949a86a69d5656cd7935" "79729cc4f86d79230e2b960ba445c0cdcfc99e6c2d46e81182bd1be63f13a616" "35e889a56f0339cd69577347efcf7ae38b2590dabb797d3d067acb99d22c5a11" "6df93d4afc4f905893ea7ebc66decb502aede078019199cc414d391754807e91" "71ee2decd9f284f68c1c74556525d9982f58ec5ebcec953e6e94d9a35f3c2c66" "2dbe5485721e30f2e7c07bc2e8d9ac292f2305238c3cdd38175efffde5aa48d0" "817d3589f5a9114093741ea23f103a932f35b8759c633ad5993b491a3174cb62" "6290ccddb79c6391f891e6ad9187052892ec6e87efac3c9141ed91f84e60afba" "bc11d463b6936a3185bd7697a07cf8016e58fcbb5847cacfd8550ead280b6e27" "097f4921ce4fd60c42fb69db83bfa33386d035d588c7e98b1693ec208b5fd3bd" "0d6648112913739314a2ef3b697977a65d4a9d8da7786976f16fd807bca087e2" "6579497f623ecab4a2256f261e589e99c1ff5142902b6438142c7ab6f941a9fa" "48850194136cd2ed970735a4fee16bf70041cca7264833138a4fd391079907a0" "fcc68a553a4e6845d243c717a0175cf2277da1370cc2b6443b14599bd275624b" "30255d883163634c3d50b31e852d0906eebf2628cc585e2bbb7b99f9a80ba604" "8dd6d0350905cc239525155a8f94557e57a11a0f358f7014f241a116d67717a2" "992f9c88cb5e355ab7de4d92f87de14428908c67b85aec64271a9d458ae92abe" "3de6189f1d140723faa8ac36527b11dfebb9f464d420e02cedc8f125ecb61056" "59d0826dae3d82d183b7b2b330aca5ecd1f60d887af3abc23efd1f91df01e04f" "c11b7075b6deef63b85454d2a2ac1ce9156b9896c47265046fcb4a4f027f6472" "7abab1dffc020fb7f604948ed9a53ecc40b170a5e4485c8e7ff532025401df96" "3f4099524aaf9933fb39f57060683e93226ca69f0f308a5969c665dbfb381e3c" "84304dd1a5f4994239edd65584a7502b1670fb41c972ef18554a3f58a066ce99" "bb5be4ef55e7ec3a040ef2966c418dcc5073bd78417c17a9635afb6c62b7f97c" "3106426efe01e06823166f821334f405beefdde5d8469d955b70f55fe4e0c721" "2c0b788912b8109c4a03bc0fad6b57c2ef3e99b79c3a679db8c19f7738ad44e5" "404021b6675101e5f3bf568832a2745e7525b654cddef1d60355bb186d96f852" "b9e9999e8b35eea84a046171e66ae12f43f6dab0ae12e3618809385644d6888e" "9481f27fca91bf9e54fd066771bd8dc111d902faa484bcb2a7088c2b9facbc85" "d1a377b984b17b3da14776330e3fbecf09c69e819b684558b4be19e873a035d9" "829b7aef319d2f17c4821b8b24ba3736417c05e42f545cbb585b4bb4d96ecc21" "d809200f35afc747acd0fba38ede488458db2c1043d4cf510b4547675a6c1eb1" "8d2f3071c2b7f43139160333153dfbc35108a990dd50a659858f9d074aceed5c" "4f0f8e36bcbe6dd2e66f08a274fcd1a416f63cdfdb260d25cd851ba5c1e273a7" "720758b2334ba85e9711d9c3607833d829b2d4b9e619ebb87ebadab0e198f565" "2cbe24bb21ca5491893f20b4d91e65942ceb9933f92204c0d6aa63334b7465a5" "f26f1f0253fe278d02f868fe93fed8870e290c1eb5dd97bb9f2110179104e0ad" "126c53ad44bea8ab4bd80112b91b8acc4f0b769128d39bd1903680e1ec63bfef" "2927373514e134e4b0dbfe3fcaa52c98c110ec41c3913b561f018dc5f90480ec" "9ed4aa6c8573fba8354d753b03224de20566bff6d9b09527b1e7430418155b61" "390b0018c94b764b06f6e930e964496e9fb64225218c6d7a0f2c9d0b39d9a5e6" "ec2634a918b88c2760f38bb5bb5b3776712200074bd0e9de44290f56940bc8ed" "16b6331924df43f69018a16982a406d35923df872a487044eb87b4178e9e6ed1" "bae8b63c82859205b2cc9666cd42b296c07f3717ea9d1d27a89df531909587be" "df89c067333167872d98d5c2730d02fb86da408ba253b7a0e4370fc9c2584f7e" "c0c95bdb2aa8d07a7c54717c1f176baab000865426d099769fd82a1e5ef5ce59" "e314d3cefb3f0fcf9a93927fe033b6769a51121f01fc155b4194a1383e65b905" "25edafe9f0625ac6f69c22d9fc0b189e6d39e451065a190dd892ab1ac33ca12f" "aceb8429734587abd923040c0d02b3275728396d98f956fa0e7472f807cb463e" "7b110e3ac45fe5684edacd31380653eafbc902ce0704cb091ab275e3167ebcef" "d1d67cf8dacee90a67598c1c089e3fb03e0af22e2ebd851ed763a27d463058b1" "b6927c5b75e3742afe03b2524084ebd410a0c7a92704be25cb6dfd3cd668d1d0" "2a86af76f621a83fdd2256f808128b247e91a8a7c9bb751bc4a5f77a8ebb9710" "b5e4e252b894abaa6caa573a11c4b640a0b83efebd1fb22c48ea88e87abc56da" "e4eb59d4eef18c5aad35760a0dbca814e93d5c175a05c33cc200f59552492e26" "4ee767bb71241a8e20a4d53b34603e83269f587a36b60b1562bceb955419087d" "4a519cb9395471f3aec28b03c438770c1802b865b89275194530173b9835d085" "f4a3abefb86fe39928540f2911c1827646a63aadbc5654a137e37f7c38b69ace" "52d6e18844dcce8a6d3323636e94350e8a40d272650d326bc9346e5f014b7552" "c4c3322cd03cd668792bdfc0529b13bd6829c94453886e671333b7cc9b5557aa" "cddb72c3e1c23729c0bfc5f3bc0e954f8106eadf5e7df5e4fe5e52fa8c15267f" "8172ed4347140c2fb426a80b7ec295bc5d4cd2bda6d26f7a40188a1ea03ce36a" "32b780b9c30195de17ee7d42c7b27f2bdb9a74a06126565dce5ef099336ab3b5" "8f01844df9ca93a54d7d0a035f6fe1082d4cf7fda7f1efa4bd9506a69a6fe1c8" "b13846b225610f31fa43588e5cb68eb65a06e96787d33008c54e84e80e752a66" "bdeb310d343e3a2b8124e3fcfa7a152c4bd64633ed500a555c39124dbb772ff4" "47444f0957d62b01a673f728669170fca99f70da66b33d7f39c2e8574d1f2bb6" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "535e812d2e7743efe63f925a4b63dcc1cce5ed76101aea087fd43fecb1b184f5" "bc8d8a2639c2ced6ab7aa1c2715c75be4d719ee801b8d85295c0c678f5784865" "bf0d1f9681ca12cf2b81ad5b957691c9262cf7998dc4dd1169d5e8ae881eaefe" "cce0922a8ccd83f160b8c9c950c7ef4c1c102f685485743141c8f8ebbaf548cc" "8c28b6a38e5289b0037d5c75aa4bf539bfd5982f792e10d834821d831d117efe" "75451efa3d6bcf86a0bd073530d5aa201f32c391bfa920ed63a3c0d41814c5c1" "bd89966dceed21a386abccc8f14cb710705141b380a95504ff71eba577049f73" "464e9ae9bd79330f97c73dfc8f0c61456aa0a9ecb35e62bbb9abc751a7ab2a3e" "e67f6ab4d1919e89cd2f0e0fac8fc8643e44074a41b1b249d27169c8ee4e4ca6" "21dc45232458293dbbfe8be6c3a865e9cc96f9f1a5f3f9feae740340f56e757d" "19df744e92ad2c1361d50aaeadfefc1755628f7516c2b6dbe75a7ec541a10e2c" "c591f386024ea45b2eb06cf453667ec8ac21a0a317ad58e623867d030eeb5e95" "1d473e48201ce4bff3daaa0ef9850de9dfb841508d931378ffa9224f9daff183" "adbe62bd4752af9ca4da38cb34d1ac1a2d9d0feb935ba2a7c0f7185d9993cc6f" "a04764f59d957cc6de179cf1337d49859140f62443e89d34999dd2c6adf203c0" "b6f90696a1383eb731c2a2bcbdbe940124d873e07c2bee8b3461d7107f261ec5" "e842be0f7791b65556f557c49f62068aade2e9deeec58c00a9015ef50b993584" "e6a2a6296531458fc3a31cdecc9168dc392e9e73f443d9f12f40a2e2e7918ab6" "46577cc8193c51db01e121e9d35b9e26dd933680ff3b8593d1ce201eb3d9f11a" "7127a2bb56533b4a24e717a6d8ffa75bc18765a49608f806eb145b8fd5a82f58" "c52acd08c890e0911a448d8973ed9f3ef3a0d99baef8b44f57edda4585d17ccd" "e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "accb248b5e48ccd64698e4d8074ed85d654c27204d4a340a14ac96f49c22aad3" "4a7318f3227086da03f6b1f864866a314c59b2c480b1c3ada0d7ba3dddd14bfc" "c9c93703c8fad5d642559b451b288b4c7a0bd9d71f6ced3da19c633fb842d0a2" "f4f8576fe07fc3af67502138390ee3e5e87c04955a9546f7130c62c2bd0e91c7" "4ef679cc918bf5a15bb8083d6973bd7cf09dbee7767bca7972b3a9d1a6059dfe" "658e419791489181d9eca29bda5adb6db1f83c8d329c890f1db82bb5229e56e9" "c48a51eb37c6d7d2e0bd1d7702dbe22f5f1f200f73e502b8674ee76b882b5325" "315c803fa6b2ca79d3bbdc72ca48d90dcf754351675a4ac9087fc7fdf2848f0f" "386fae5b62db6fdebe6308d45092f61e4a00f7d386a4a3262d0526eabbcd396a" "42eac23bb0b30c62fc7e362baf5aadc7721b158dfcdfb9e6d1f39678c7d09afa" "5795f513cecdc9bac2ffc7dc9f0345568fd77dbb112950fd68d2bffe1f03dac1" "a9c7c29d1b8b4624262f5f1060695762ac959100ae8511110944e473a2d137f9" "f8c3adbd854f6a4c07b7a4495e762afd16236c11a1d7e5e692ea411cd2c83922" "5e2613552e00cf6e202342628bb6091889e5584d2744378eeb9c7c3a51a21883" "5003c2869df42ded63fc03c1e0e137c2fa80d393ecfb36f245228594aa1673b1" "d450600be457b75971859e5284d0f00042f49473d0888a956e6b6683097a772f" "76c388d24276bdf01bbbe6c75b1af0b76a16026f2d181a5ae6fb72bb9b2e8d44" "bebbaadce43fdfe82fd453969f4f877799c4f4973d5c9192b1186aa0c058f2ae" "2c058064c9abac150e45f023b8b8fd517e1398f68d409eef1dcb9898897d374d" "2ce73702b05bf6c30d769c4bb04a79bbde1b189e5ea8c03deb224009fe2937ae" "93474ff98fdae64502e72d31b0585043d82778706e3a8c8f0ed93cde8d1bad77" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "2764d37d3fd3429a1efa6d0a5e261c2ea46f999525cfb07dd609266b05ed102d" "7f7d401d49912861cddfe72fa98fde1080e917d91b3ad44bf814ab9e566fb059" "35661b0091bfac46b0b363a47746d04695916c8b20e51a09f7ac446c18144c0a" "b847b0cf684d9ccb969f8868b29f1c83a88abdce974009801a0854a3eaeb3b57" "0d78be97cb294ee45add15a9dde4a02d108eb627c51c401d0513dc60c21f9798" "baf8ee8730814bc8ba999a8e810410891f2509daeb28b4b517b1eb6bd5453965" "f9fb31369819ed08e231c1b69dc0c5e1bb8b52563d60a0dbcb577e47d33b39fe" "7f6d903b875ce4d2f1834211e8b32a2172b7171adef428222ec64dda6f3bbf4d" "a6f737e76be7891e2cf84f9da6e1b42622f01d504058961d60bfe271e75844dc" "6594e3106eeee750952a5adcb09e45f2a4d7b0d1ba7636d146b1ee25273cc503" "559b61aeea22f87ad68869eba08750d5cd6812732ad0eabd3c7d7d710207b422" "d0b289cc0d83cede021418f7e6bc1be02102e086e0d1d5ccc202d2c0d9145dba" "06b5bb3b81404b669f333b4ee895980ed9542bf6c1a16f2eff12d8e83b4d9177" "6a2fca26dcb3421c90e2a5cd8209b1cfc696eca9c4f2f3baa8044268bdae1275" "125c5a9d7a13d23701b5ddb8ec32ca2fc3a12af03b86fe75120556f5774ba478" "d21f4b910f540b7a1bb556c6fd9e872e8ea4f96763808f127741e1821e59d57e" "6b65c53d36b423e01c2dfb2e2ff15d155efe54d23d61b33ac8eea0c4c6192259" "6b7065007cbb2fd84cb64c47f26052f2142fdb47cb89cfc1b2037147844bb960" "c23d376d252905d68d028da63e0e8892a7bbeb8d085cf5d9cd04039f1f969bff" "042764fe6116fad118e545807f4e1634e1d7364f5e41dfeba589d19cea1687f6" "0f002f8b472e1a185dfee9e5e5299d3a8927b26b20340f10a8b48beb42b55102" "4bafdf555f23506274614cd17ca564fae34c833ff1d0a5fa04e5034823d56d81" "8e29973bf8aee4b708c8ef9c512b90d1acabe4a5c15b571c6f57e140264d44d3" "97c3898362f36417cf9bece98a9fad1ba8bc145043097a5b9bb8a7e66addec6c" default)))
 '(evil-jumper-mode t)
 '(fci-rule-color "#000")
 '(global-company-mode t)
 '(jabber-account-list
	 (quote
		(("uriel781@gmail.com"
			(:password . "Edit.isa22")
			(:network-server . "talk.google.com")
			(:port . 5223)
			(:connection-type . ssl)))))
 '(magit-diff-refine-hunk (quote all))
 '(magit-log-format-graph-function (quote identity))
 '(minibuffer-prompt-properties
	 (quote
		(point-entered minibuffer-avoid-prompt face minibuffer-prompt point-entered minibuffer-avoid-prompt)))
 '(org-link-frame-setup
	 (quote
		((vm . vm-visit-folder-other-frame)
		 (vm-imap . vm-visit-imap-folder-other-frame)
		 (gnus . org-gnus-no-new-news)
		 (file . find-file-other-frame)
		 (wl . wl-other-frame))))
 '(org-log-into-drawer t)
 '(org-modules
	 (quote
		(org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m org-depend org-drill)))
 '(package-selected-packages
	 (quote
		(emmet-mode dired+ coffee-mode emms pianobar perspective workgroups2 hydra rotate thesaurus elm-mode fullframe plantuml-mode helm-dictionary go-mode org-drill-table request helm-ag haml-mode solarized-theme imenu-list indent-guide ruby-refactor erlang define-word lua-mode smooth-scrolling smooth-scroll avy hl-line+ hl-spotlight yari helm-c-yasnippet centered-cursor-mode projectile ocodo-svg-modelines org smartparens yascroll yaml-mode wrap-region workgroups web-mode web-beautify vagrant-tramp vagrant tern-auto-complete tabbar-ruler smex smart-mode-line slime shm shell-command rvm ruby-tools rubocop rsense restclient relative-line-numbers recentf-ext rainbow-delimiters projectile-rails project-explorer pretty-mode powerline paredit pallet org-journal org-bullets occidental-theme noctilux-theme neotree multiple-cursors multi-term moz-controller mew maxframe markdown-mode magit linum-relative jabber idomenu ido-vertical-mode icicles helm guide-key grizzl git-timemachine git-gutter-fringe git-blame flymake-ruby flymake-cursor flycheck flx-ido floobits findr expand-region exec-path-from-shell eww-lnum evil-tabs evil-surround evil-leader evil-jumper escreen enh-ruby-mode enclose elpy ecb drag-stuff dirtree dash-at-point cyberpunk-theme company-inf-ruby company-ghc column-marker color-theme-sanityinc-tomorrow clojure-mode calfw bash-completion babel arduino-mode anaphora ag ace-jump-mode ac-js2 ac-haskell-process))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'smyx)
(setq ns-use-srgb-colorspace nil)
(setq powerline-default-separator 'slant)
(powerline-default-theme)
																				;(powerline-default-theme)
;;;
;;;### (autoloads nil "../repo/emacs/rvm.el/rvm" "../repo/emacs/rvm.el/rvm.el"
;;;;;;  (21707 27595 0 0))
;;; Generated autoloads from ../repo/emacs/rvm.el/rvm.el

;;;***
(put 'dired-find-alternate-file 'disabled nil) ;g

(put 'narrow-to-region 'disabled nil)
(smartparens-global-mode)
(linum-on)
