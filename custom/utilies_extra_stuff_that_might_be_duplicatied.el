;; (defun mac-notify-string (title message)
;;   "for the use of shell commands"
;;   (concat "osascript -e 'display notification \"" message  "\" with Title \"" title "\"' & "))



;; (defun mac-term-notify-string (title-arg message-arg &optional command-arg)
;;   "for the use of shell commands"
;;   (let* ((title (concat "-title '" title-arg "' " ))
;;          (message (concat "-message '" message-arg "' " ))
;;          (app-id (concat "-sender 'org.gnu.Emacs' " ))
;;          (command (if (boundp 'command-arg)
;;                       (concat "-execute '" command-arg "' ")
;;                     "") ))
;;     (concat "terminal-notifier " title message app-id command)))

;; (defun mac-term-notify (title message)
;;   (start-process-shell-command "EmacsMacNOtify" "*EmacsMacNOtify*" (mac-term-notify-string title message)))

;; (defun ugm/staging-deploy-process (process-name)
;;   (let* ((process-name))
;;     (start-process-shell-command process-name buffer-name cmd)))

;; (defun tacit7-phing-hook-on-save ()
;;   (interactive)
;;   (remove-hook 'after-save-hook 'tacit7-phing-minify))

;; (defun tacit7-apache-restart ()
;;   (interactive)
;;   (let* ((notification-start (mac-term-notify-string "Apache" "Restarting"))
;;          (notification-end (mac-term-notify-string "Apache" "Restarted"))
;;          (cmd (concat notification-start " && cd ~/repo/1kb && vagrant ssh -c \"sudo service apache2 restart\" && "notification-end)))
;;     (message "Restarting Apache")
;;     (start-process-shell-command "restartApache" "*restarting-apache*" cmd)))

;; ;; (defun tacit7-phing-minify ()
;; ;;   "Goes to 1kb and performs phing minify"
;; ;;   (interactive)
;; ;;   (let* ((notification (mac-term-notify-string "Phing Minify" "Done minifying"))
;; ;;          (cmd "cd ~/repo/1000bulbs && docker-compose exec 1kb vendor/bin/phing js-concat js-minify" )
;; ;;     (message "Starting to Minify")
;; ;;     (start-process-shell-command "phingMinify" "*minifying-js*" cmd)))

;; (defun tacit7-phing-minify ()
;;   "Goes to 1kb and performs phing minify"
;;   (interactive)
;;   (let* ((notification (mac-term-notify-string "Phing Minify" "Done minifying"))
;;          (cmd "cd ~/repo/strangler && docker-compose exec 1kb vendor/bin/phing js-concat js-minify" ))
;;     (compile cmd)))

;; (defun tacit7-phing-compass ()
;;   "Goes to 1kb and performs phing minify"
;;   (interactive)
;;   (let* ((notification (mac-term-notify-string "Phing Minify" "Done minifying"))
;;          (cmd "cd ~/repo/strangler && docker-compose exec 1kb vendor/bin/phing compass" ))
;;     (compile cmd)))

;; (defun tacit7-buffer-in-project-p (project-str)
;;   "Tells you if buffer is in project :project-str"
;;   (if (and (projectile-project-p) (string-match-p project-str (buffer-file-name)))
;;       t
;;      ))
;; ;; (defun tacit7-phing-compass ()
;; ;;   "Goes to 1kb and performs phing minify"
;; ;;   (interactive)
;; ;;   (let* ((notification (mac-term-notify-string "Phing Compass" "Compass Done"))
;; ;;          (cmd (concat "cd ~/repo/1kb && vagrant ssh -c \"cd /vagrant && phing compass\" && "notification)))
;; ;;     (message "Starting to Minify")
;; ;;     (start-process-shell-command "phingMinify" "*minifying-js*" cmd)))



;; (defun tacit7-get-file-path ()
;;   "Put the current file name on the clipboard."
;;   (interactive)
;;   (let ((filename (if (equal major-mode 'dired-mode)
;;                       default-directory
;;                     (buffer-file-name))))Do
;;                     (when filename
;;                       (message filename)
;;                       file-name)))

;; (defun tacit-7-filepath-to-clipboard ()
;;   "Put the current file name on the clipboard."
;;   (interactive)
;;   (let ((filename (if (equal major-mode 'dired-mode)
;;                       default-directory
;;                     (buffer-file-name))))
;;     (when filename
;;       (with-temp-buffer
;;         (insert filename)
;;         (clipboard-kill-region (point-min) (point-max)))
;;       (message filename))))
;; (defun tacit-7-filename-to-clipboard ()
;;   "Put the current file name on the clipboard."
;;   (interactive)
;;   (let ((filename (buffer-name)))
;;     (when filename
;;       (with-temp-buffer
;;         (insert filename)
;;         (clipboard-kill-region (point-min) (point-max)))
;;       (message filename))))
;; ;; (defun emacs-rspec-strangler-setup ()
;; ;;   (setq rspec-docker-command "docker-compose exec"
;; ;;         rspec-docker-cwd     "/Users/umaldonado/repo/1000bulbs/"
;; ;;         rspec-docker-container "strangler"
;; ;;         rspec-use-docker-when-possible t
;; ;;         ))

;; (defun tacit7-remove-local-repo-path-from-string (str-path)
;;   "Given a string that is a path, remove the local path leading to the repo."
;;   (replace-regexp-in-string "\/Users\/umaldonado\/repo/" "" str-path))

;; (defun tacit7-strangler-file-path (strangler-file)
;;   "Given a string that is a path, remove the local path leading to the repo."
;;   (replace-regexp-in-string "\/Users\/umaldonado\/repo\/strangler" "" strangler-file ))

;; (defun tacit7-get-1kb-github-link-at-line ()
;;   (interactive)
;;   ; You have to remove the 1kb from the file path.
;;   (let* ((filename (replace-regexp-in-string "1kb" "" (tacit7-remove-local-repo-path-from-string (buffer-file-name))))
;;          (link  (concat "https://github.com/1000Bulbs/1kb/tree/master/"filename"#L"(tacit7-line-number-at-post-str))))

;;     (when link
;;       (with-temp-buffer
;;         (insert link)
;;         (clipboard-kill-region (point-min) (point-max))))))

;; (defun tacit7-get-1kb-github-file-link ()
;;   (interactive)
;;                                         ; You have to remove the 1kb from the file path.
;;   (let* ((filename (replace-regexp-in-string "1kb" "" (tacit7-remove-local-repo-path-from-string (buffer-file-name))))
;;          (link  (concat "https://github.com/1000Bulbs/1kb/tree/master/"filename)))
;;     (when link
;;       (with-temp-buffer
;;         (insert link)
;;         (clipboard-kill-region (point-min) (point-max))))))
;; (defun tacit-7-load-file-to-docker-console ()
;;   "Put the current file name on the inf-ruby buffer."
;;   (interactive)
;;   (let* ((filename (if (equal major-mode 'dired-mode)
;;                        default-directory
;;                      (buffer-file-name)))
;;          (docker-file-name (replace-regexp-in-string "\/Users\/"(user-login-name)"\/repo/1000bulbs" "" filename)))
;;     (when filename
;;       (comint-send-string (get-buffer-process "*strangler-console*") (concat "load \"" docker-file-name   "\"\r" )))
;;     ))




;; (setq cd-1000-bulbs "cd ~/repo/1000bulbs/")
;; (setq docker-strangler-rspec-str "docker-compose exec -T strangler rspec ")
;; (defvar current-spec nil)

;; (defun tacit7-line-number-at-post-str ()
;;   (number-to-string (line-number-at-pos)))

;; (setq tacit7-watched-files nil)
;; (defun tacit7-watch-current-file ()
;;   (interactive)
;;   (add-to-list 'tacit7-watched-files (buffer-file-name))(setq inhibit-modification-hooks nil)

;;   (add-hook 'after-save-hook 'rspec-run-current-spec-if-current-buffer-is-watched nil  t))

;; (defun tacit7-set-current-spec-i ()
;;   (interactive)
;;   "The spec that is currently being tested."
;;   (if (string-match-p "spec" (buffer-file-name))
;;       (setq tacit7-current-spec buffer-file-name) ))

;; (defun tacit7-set-current-spec ()
;;   "The spec that is currently being tested."
;;   (if (string-match-p "spec" (buffer-file-name))
;;       (setq tacit7-current-spec buffer-file-name) ))

;; (defun tacit7-is-current-spec-p ()
;;   "Predicate that tells you if the current file si the current spec"
;;   (string-match-p (buffer-file-name) tacit7-current-spec))

;; (defun tacit7-strangler-run-current-spec-in-docker-or-set ()
;;   "When you are in a spec, send the current spec to docker to run."
;;   (interactive)

;;   (if (not tacit7-current-spec)
;;       (tacit7-set-current-spec))

;;   (let* (
;;          (docker-file-name ( replace-regexp-in-string "\/Users\/umaldonado\/repo" "" tacit7-current-spec))

;;          (cmd (concat cd-1000-bulbs " && " docker-strangler-rspec-str  docker-file-name " --format documentation"))
;;          )

;;     (compile cmd)
;;                                         ;(cd "~/repo/1000bulbs/strangler")
;;     ))

;; (defun tacit7-strangler-run-current-spec-in-docker ()
;;   "When you are in a spec, send the current spec to docker to run."
;;   (interactive)

;;   (let* (

;;          (docker-file-name ( replace-regexp-in-string "\/Users\/umaldonado\/repo" "" (buffer-file-name)))

;;          (cmd (concat cd-1000-bulbs " && " docker-strangler-rspec-str  docker-file-name " --format documentation"))
;;          )

;;     (compile cmd)                 ;
;;     (cd "~/repo/1000bulbs/strangler")
;;     ))


;; (defun tacit7-strangler-run-all-specs-in-docker ()
;;   "When you are in a spec, send the current spec to docker to run."
;;   (interactive)

;;   (let* (

;;          (cmd (concat cd-1000-bulbs " && " docker-strangler-rspec-str "spec" ))
;;          )

;;     (compile cmd)                 ;
;;     ))

;; (defun local-file-to-docker-file-path (local-file)
;;   "Given a local file path, convert it to docker path."
;;   (replace-regexp-in-string "\/Users\/umaldonado\/repo" "" (buffer-file-name)))

;; (defun tacit7-strangler-run-current-spec-in-docker-line ()
;;   "When you are in a spec, send the current spec to docker to run."
;;   (interactive)

;;   (let* (
;;          (docker-file-name (local-file-to-docker-file-path buffer-file-name) )
;;          (line-number (int-to-string (1+ (count-lines 1 (point)))))
;;          (cmd (concat cd-1000-bulbs " && " docker-strangler-rspec-str  docker-file-name ":" line-number ))
;;          )

;;     (compile cmd)
;;     ))






;; (defun start-port-forwarding-to-mysql ()
;;   (interactive)
;;   (shell-command "ssh -L 33066:10.20.100.14:3306 umaldonado@moe.1000bulbs.com"))

;; (defun ugm/persp-names ()
;;   (-map
;;    (lambda (x) (if (stringp x) x ( symbol-name x ) ))
;;    (persp-names-current-frame-fast-ordered)))

;; (defun ugm/remove-dot-dirs(dirs)
;;   (-remove 'is-dot-dir-p dirs))

;; (defun ugm/list-notes ()
;;   "List all the notes that you have."
;;   (ugm/remove-dot-dirs (directory-files "~/uriel-repo/notes/")))

;; (defun ugm/list-conf-files ()
;;   "List all the notes that you have."
;;   (ugm/remove-dot-dirs (directory-files "~/.emacs.d/custom/")))

;; (defun switch-to-last-buffer ()
;;   "Switch to the previously selected buffer in the current window."
;;   (interactive)
;;   (switch-to-buffer (other-buffer (current-buffer)) nil t))


;; (defun ido-persp-select ()
;;   (ido-completing-read "Select perspective" (ugm/persp-names)))

;; (defun ido-persp-switch ()
;;   (persp-switch (ido-persp-select)))

;; (defun evil-add-blank-line ()
;;   (interactive)
;;   (evil-open-below 1)
;;   (evil-normal-state))

;; (defun tacit7-binding-pry ()
;;   "Insert binging pry and then save the file."
;;   (interactive)
;;   (evil-open-below 1)
;;   (insert "require 'pry'; binding.pry")
;;   (evil-normal-state)
;;   (save-buffer))

;; (defun tacit7/open-org-tickets ()
;;   "Open the tickets file on org mode."
;;   (interactive)
;;   (find-file "/Users/umaldonado/repo/org-mode/tickets.org"))

;; (defun tacit7/edit-cask ()
;;   "Open the cask file"
;;   (interactive)
;;   (find-file "~/.emacs.d/Cask" ))
;; (defun tacit7/edit-private-xml ()
;;   "Open the cask file"
;;   (interactive)
;;   (find-file "/Users/uriel781/Library/Application Support/Karabiner/private.xml" ))
;; (defun tacit7/edit-org ()
;;   "Open the cask file"
;;   (interactive)
;;   (find-file "~/uriel-repo/emacs/emacs_init/custom/org-conf.el" ))

;; (defun tacit7/edit-utilities ()
;;   "Open the cask file"
;;   (interactive)
;;   (find-file "~/uriel-repo/emacs/emacs_init/custom/utilities.el" ))

;; (defun tacit7/switch-to-previous-buffer ()
;;   "Switch to previously open buffer.
;; Repeated invocations toggle between the two most recently open buffers."
;;   (interactive)
;;   (switch-to-buffer (other-buffer (current-buffer) 1)))

;;                                         ;insert mode key maps
;; (define-key evil-insert-state-map "\C-f" 'sp-forward-slurp-sexp)
;; (define-key evil-insert-state-map "\C-b" 'sp-backward-slurp-sexp)
;; ;; (add-hook 'yasnippet-minor-mode
;; ;;           (progn
;; ;;             (define-key evil-insert-state-map "\C-k" 'yas/expand)
;; ;;             (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; ;;             (define-key yas-minor-mode-map (kbd "TAB") nil)
;; ;;             (define-key yas-minor-mode-map (kbd "C-x C-k") 'yas-expand) ;
;; ;;             ))

;; (defun tacit7-reload-fedex-gem ()
;;   "Rebuild fedex gem and create a new ruby console."
;;   (interactive)
;;   (cd "~/repo/fedex")
;;   (comint-send-string (get-buffer-process "*shell*") "cd ~/repo/fedex\n")
;;   (comint-send-string (get-buffer-process "*shell*") "rake install\n")
;;   (sleep-for 2)

;;   (if (get-buffer-process "*ruby*")
;;       (delete-process "*ruby*"))

;;   (if (get-buffer-window "*ruby*")
;;       (delete-window (get-buffer-window "*ruby*")))

;;   (rvm-use "ruby-2.1.3" "fedex")
;;   (inf-ruby)
;;   (comint-send-string (get-buffer-process "*ruby*") "require 'fedex'\n"))

;; (defun ugm/project-to-1kb ()
;;   "Switch to 1kb project."
;;   (interactive)
;;   ;; (persp-load-state-from-file "~/.emacs.d/persp-confs/1kb")
;;   (cd "~/repo/1kb/")
;;   (helm-projectile-find-file "~/repo/1kb/"))

;; (defun ugm/project-to-fedex ()
;;   "Switch to fedex project."
;;   (interactive)
;;   ;; (persp-load-state-from-file "~/.emacs.d/persp-confs/1kb")
;;   (cd "~/repo/fedex/")
;;   (helm-projectile-find-file "~/repo/fedex/"))

;; (defun tacit7-project-term-fedex ()
;;   "Switch to fedex project."
;;   (interactive)
;;   ;; (persp-load-state-from-file "~/.emacs.d/persp-confs/1kb")
;;   (cd "~/repo/fedex/")
;;   (multi-term))

;; (defun ugm/project-to-razzmatazz ()
;;   "Switch to razzmatazz project."
;;   (interactive)
;;   ;; (persp-load-state-from-file "~/.emacs.d/persp-confs/1kb")
;;   (cd "~/uriel-repo/razzmatazz/")
;;   (find-file "~/uriel-repo/razzmatazz/README.org"))

;; (defun ugm/search-custom-emacs-files ()
;;   "Switch to a custom emacs file."
;;   (interactive)
;;   (let (old-dir (pwd))
;;     (helm-find-files nil))
;;   (cd old-dir))

;; (defun ugm/project-to-strangler ()
;;   "Switch to stranger project."
;;   (interactive)
;;   (cd "~/repo/strangler/")
;;   (rvm-activate-corresponding-ruby)
;;   (find-file "~/repo/strangler/"))

;; (defun ugm/project-to-eden ()
;;   "Switch to eden-search project."
;;   (interactive)
;;   (cd "~/repo/eden-search/")
;;   (helm-projectile-find-file "~/repo/eden-search/"))

;; ;; (defun ugm/find-notes ()
;; ;;   (interactive)
;; ;;   (setq current-prefix-arg '(4))
;; ;;   (cd "~/uriel-repo/notes/")
;; ;;   (helm-projectile-find-file "~/uriel-repo/notes/"))

;; (defun ugm/find-notes ()
;;   (interactive)
;;   (counsel-file-jump nil "~/uriel-repo/notes"))

;; (defun edit-1kb-notes ()
;;   (interactive)
;;   (find-file "~/uriel-repo/notes/1kb-proj.org"))

;; (defun view-strangler-log ()
;;   (interactive)
;;   (find-file "~/repo/strangler/log/development.log"))

;; (defun edit-dev-log-strangler ()
;;   (interactive)
;;   (find-file "~/repo/strangler/log/development.log"))

;; (defun ugm/find-custom-file ()
;;   (interactive)
;;   (setq current-prefix-arg '(4))
;;   (cd "~/uriel-repo/emacs_init/")
;;   (helm-projectile-find-file "~/uriel-repo/emacs-init/custom/"))

;; (defun ugm/find-agendas ()
;;   (interactive)
;;   (setq current-prefix-arg '(4))
;;   (cd "~/uriel-repo/notes/")
;;   (helm-projectile-find-file "/Users/urielm/uriel-repo/notes/agendas/"))

;; (defun ugm/edit-1kb-agenda ()
;;   (interactive)
;;   (find-file-other-window "~/uriel-repo/notes/agendas/1kb.txt"))

;; (defun ugm/edit-1kb-notes ()
;;   (interactive)
;;   (find-file "~/uriel-repo/notes/1kb.txt"))

