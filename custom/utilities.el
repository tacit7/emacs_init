
(defun is-dot-dir-p (file)
  "Check if FILE is . or .."
  (-contains? '("." "..") file))				;

(defun tacit7/in-1kb-project-p ()
  (s-equals? (tacit7/project-dir-name) "1kb"))

(defun tacit7/project-dir-name ()
  (car (last (-reject 's-blank? (split-string (projectile-project-root) "/")))))

                                        ; You can do this using javascript
                                        ;  /System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc
(defun mac-notify-string (title message)
  "for the use of shell commands"
  (concat "osascript -e 'display notification \"" message  "\" with Title \"" title "\"' "))



(defun mac-term-notify-string (title-arg message-arg &optional command-arg)
  "for the use of shell commands"
  (let* ((title (concat "-title '" title-arg "' " ))
         (message (concat "-message '" message-arg "' " ))
         (app-id (concat "-sender 'org.gnu.Emacs' " ))
         (command (if (boundp 'command-arg)
                      (concat "-execute '" command-arg "' ")
                    "") ))
    (concat "terminal-notifier " title message app-id command)))

(defun mac-term-notify (title message)
  (message (mac-term-notify-string title message))

   (start-process-shell-command "EmacsMacNOtify" "*EmacsMacNOtify*" (mac-notify-string title message)))

(defun tacit7-get-file-path ()
  "Put the current file name on the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
                    (when filename
                      (message filename)
                      file-name)))

(defun tacit7-show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
(defun tacit-7-spec-at-line ()
  "build rspec command to test spec at point"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (concat "rspec "(buffer-file-name)":"(tacit7-line-number-at-post-str)))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun tacit-7-spec-file-path ()
  "build rspec command to test current specification"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (concat "rspec "(buffer-file-name)))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun tacit-7-filepath-to-clipboard ()
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

(defun tacit-7-filename-to-clipboard ()
  "Put the current file name on the clipboard."
  (interactive)
  (let ((filename (buffer-name)))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun tacit7-remove-local-repo-path-from-string (str-path)
  "Given a string that is a path, remove the local path leading to the repo."
  (replace-regexp-in-string "\/Users\/umaldonado\/repo/" "" str-path))

(defun tacit7-project-file-path (str-path)
  "Given a string that is a path, remove the local path leading to the repo."
  (replace-regexp-in-string "\/Users\/umaldonado\/repo/" "" str-path))


(defun tacit7-line-number-at-post-str ()
  (number-to-string (line-number-at-pos)))

(defvar current-spec nil)

(defun set-current-spec ()
  "Set the current spec to run"
  (interactive)
  (setq current-spec (buffer-file-name) )
  (call-interactively #'tacit7-watch-file))

(defun run-spec-in-terminal ()
  (send-to-iterm (concat "rspec " current-spec)))

(setq tacit7-watched-files nil)
(defun tacit7-watch-file ()
  (interactive)
  (add-to-list 'tacit7-watched-files (buffer-file-name)))

(defun rspec-run-current-spec-if-current-buffer-is-watched ()
  (if (-contains? tacit7-watched-files (buffer-file-name))
        (save-window-excursion
          (run-spec-in-terminal))))

(defun rspec-notify-failure (buffer msg)

  (mac-term-notify "Rspec" msg)
  )
(add-hook 'after-save-hook
          'rspec-run-current-spec-if-current-buffer-is-watched)
(add-hook 'compilation-finish-functions
             'rspec-notify-failure)

(defun rspec-run-current-spec ()
  (interactive)
  (rspec-run-single-file current-spec))

(defun tacit7-set-current-spec-i ()
  (interactive)
  "The spec that is currently being tested."
  (if (string-match-p "spec" (buffer-file-name))
      (setq tacit7-current-spec buffer-file-name) ))

(defun tacit7-set-current-spec ()
  "The spec that is currently being tested."
  (if (string-match-p "spec" (buffer-file-name))
      (setq tacit7-current-spec buffer-file-name) ))

(defun tacit7-is-current-spec-p ()
  "Predicate that tells you if the current file si the current spec"
  (string-match-p (buffer-file-name) tacit7-current-spec))

(defun tacit7-strangler-run-current-spec-in-docker-or-set ()
  "When you are in a spec, send the current spec to docker to run."
  (interactive)

  (if (not tacit7-current-spec)
      (tacit7-set-current-spec))

  (let* (
         (docker-file-name ( replace-regexp-in-string "\/Users\/umaldonado\/repo" "" tacit7-current-spec))
         (cmd (concat cd-1000-bulbs " && " docker-strangler-rspec-str  docker-file-name " --format documentation"))
         )

    (compile cmd)
                                        ;(cd "~/repo/1000bulbs/strangler")
    ))

(defun tacit7-strangler-run-current-spec-or-set ()
  "When you are in a spec, run it"
  (interactive)

  (if (not tacit7-current-spec)
      (tacit7-set-current-spec))

  (let* ((cmd (concat cd-1000-bulbs " && rspec"   docker-file-name " --format documentation")))
    (compile cmd)))

(defun tacit7-strangler-run-current-spec-at-line ()
  "When you are in a spec, send the current spec to docker to run."
  (interactive)

  (let* ((line-number (int-to-string (1+ (count-lines 1 (point)))))
         (cmd (concat "cd ~/repo/strangler && rspec "  (buffer-file-name) ":" line-number )))

    (compile cmd)))

(defun ugm/persp-names ()
  (-map
   (lambda (x) (if (stringp x) x ( symbol-name x ) ))
   (persp-names-current-frame-fast-ordered)))

(defun ugm/remove-dot-dirs(dirs)
  (-remove 'is-dot-dir-p dirs))

(defun ugm/list-notes ()
  "List all the notes that you have."
  (ugm/remove-dot-dirs (directory-files "~/uriel-repo/notes/")))

(defun ugm/list-conf-files ()
  "List all the notes that you have."
  (ugm/remove-dot-dirs (directory-files "~/.emacs.d/custom/")))

(defun ido-persp-select ()
  (ido-completing-read "Select perspective" (ugm/persp-names)))

(defun ido-persp-switch ()
  (persp-switch (ido-persp-select)))

(defun tacit7-insert-trail ()
  "Insert trail."
  (interactive)
  (save-excursion
    (evil-open-below 1)
    (insert "puts \"\t\\n\\n\\n\\n \\033[1;31m >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{__FILE__}:#{__LINE__} <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\\n\\n\\n\\n\ \\033[0m\"")
    (evil-normal-state))
  (save-buffer))

(defun tacit7-insert-comment-trail (comment)
  "Insert commenttrail."
  (interactive "sEnter comment: ")
  (save-excursion
    (evil-open-below 1)
    (insert "puts \"\t\\n\\n\\n\\n \\033[1;31m >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{__FILE__}:#{__LINE__} <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\\n\\n\\n\\n\ \\033[0m\" \n")
    (insert comment)
    (insert "\n")
    (insert "puts \"\t\\n\\n\\n\\n \\033[1;31m >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{__FILE__}:#{__LINE__} <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\\n\\n\\n\\n\ \\033[0m\"")
    (evil-normal-state))
  (save-buffer))

(defun tacit7-binding-pry ()
  "Insert binging pry and then save the file."
  (interactive)
  (save-excursion
    (evil-open-below 1)
    (insert (concat"require 'pry'; binding.pry # "(buffer-file-name)))
    (evil-normal-state))
  (save-buffer))

(defun tacit7/open-org-tickets ()
  "Open the tickets file on org mode."
  (interactive)
  (find-file "~/repo/org-mode/tickets.org"))

(defun e-pryrc ()
  "Open the cask file"
  (interactive)
  (find-file "~/.pryrc" ))

(defun tacit7-edit-cask ()
  "Open the cask file"
  (interactive)
  (find-file "~/.emacs.d/Cask" ))

(defun tacit7-edit-org ()
  "Open the cask file"
  (interactive)
  (find-file "~/uriel-repo/emacs/emacs_init/custom/org-conf.el" ))

(defun tacit7-edit-utilities ()
  "Open the utilities.el file"
  (interactive)
  (find-file "~/uriel-repo/emacs/emacs_init/custom/utilities.el" ))

(defun tacit7-edit-bashrc ()
  "Open the bashrc file"
  (interactive)
  (find-file "~/.bashrc" ))

(defun tacit7-edit-pryrc ()
  "Open the bashrc file"
  (interactive)
  (find-file "~/.pryrc" ))


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
  ;; (rvm-activate-corresponding-ruby)
  (strangler-console)
  (find-file "~/repo/strangler/"))

(defun ugm/project-to-eden ()
  "Switch to eden-search project."
  (interactive)
  (cd "~/repo/eden-search/")
  (helm-projectile-find-file "~/repo/eden-search/"))


(defun ugm/find-notes ()
  (interactive)
  (counsel-file-jump nil "~/uriel-repo/notes"))

(defun edit-1kb-notes ()
  (interactive)
  (find-file "~/uriel-repo/notes/1kb-proj.org"))

(defun view-strangler-log ()
  (interactive)
  (find-file "~/repo/strangler/log/development.log"))

(defun edit-dev-log-strangler ()
  (interactive)
  (find-file "~/repo/strangler/log/development.log"))

(defun ugm/find-custom-file ()
  (interactive)
  (setq current-prefix-arg '(4))
  (cd "~/uriel-repo/emacs_init/")
  (helm-projectile-find-file "~/uriel-repo/emacs-init/custom/"))

(defun ugm/find-agendas ()
  (interactive)
  (setq current-prefix-arg '(4))
  (cd "~/uriel-repo/notes/")
  (helm-projectile-find-file "/Users/urielm/uriel-repo/notes/agendas/"))

(defun ugm/edit-1kb-agenda ()
  (interactive)
  (find-file-other-window "~/uriel-repo/notes/agendas/1kb.txt"))

(defun ugm/edit-1kb-notes ()
  (interactive)
  (find-file "~/uriel-repo/notes/1kb.txt"))

(defun ugm-switch-to-strangler ()
  (interactive)
  (cd "~/repo/strangler/")
  (find-file "~/repo/strangler/strangler.ln.txt"))
  ;; :(rvm-activate-corresponding-ruby))

(defun ugm-switch-to-strangler-checkout ()
  (interactive)
  (cd "~/repo/strangler/")
  (find-file "~/repo/strangler/strangler.org")
  (rvm-activate-corresponding-ruby)
  (magit-checkout))
(defun ugm/edit-gemfile ()
  (interactive)
  (find-file-other-window (concat (projectile-project-root) "Gemfile")))

(defun ugm/edit-abbrevs ()
  (interactive)
  (find-file-other-window "~/.emacs.d/abbrev_defs") "Gemfile")

(defun ugm/read-abbrevs ()
  (interactive)
  (read-abbrev-file "~/.emacs.d/abbrev_defs"))

(defun ugm/new-line ()
  (interactive)
  (end-of-line)
  (open-line 2)
  (forward-line 2)
  (evil-insert nil)
  (indent-for-tab-command))


(defun ugm/edit-evil ()
  (interactive)
  (find-file "~/.emacs.d/custom/evil-conf.el"))

(defun ugm/edit-1kb-journal ()
  (interactive)
  (find-file "~/uriel-repo/notes/1kb-journal.org"))

(defun ugm/edit-smyx ()
  (interactive)
  (find-file "~/uriel-repo/emacs/smac-theme/smac-theme.el"))

(defun ugm/load-smyx ()
  (interactive)
  (load-theme 'smac t))
(defun ugm/edit-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(defun ugm/send-previous-region ()
  "Send previous selected region."
  (interactive)
  (evil-visual-restore)
  (ruby-send-region (region-beginning) (region-end)))

(defun tacit7-go-to-a-random-product ()
  (interactive)
  "Takes you to a random product on your web browser.\n"
    (comint-send-string (get-buffer-process "*strangler-console*") "random_product_go\n"))

(defun tacit7-go-to-admin-product (str)
  (interactive "sEnter product id: ")
  "Takes you to a  product in admin on your web browser.\n"
  (comint-send-string (get-buffer-process "*strangler-console*") (concat "admin_product "str"\n")))

(defun tacit7-go-product (str)
  (interactive "sEnter product id: ")
  "Takes you to a  product in admin on your web browser.\n"
  (comint-send-string (get-buffer-process "*strangler-console*") (concat "go_product "str"\n")))

(defun tacit7-rollout-1kb (key)
  (interactive "sEnter your key: ")
  "activate rollout on 1kb"
  (start-process-shell-command "strangler" "*strangler-server*" (concat "cd ~/repo/strangler/ && docker-compose exec 1kb ./bin/rollout a " key))
  (set-process-query-on-exit-flag (get-buffer-process  "*strangler-server*") nil))
(defun tacit7-toggle-rollout (key)
  (interactive "sEnter your key: ")
  "Toggles rollout features"
  (comint-send-string (get-buffer-process "*strangler-console*") (concat "toggle_rollout \""key"\"\n")))
(defun tacit7-auto-save-send-to-pry ()
  (if (and
       (string-match "rb$" (buffer-file-name))
       (not (string-match "spec" (buffer-file-name))))
      (tacit7-reload-file-in-pry)))

(defun tacit7-reload-file-in-pry ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "load '"file"'\n")))
    (message cmd)
    (comint-send-string (get-buffer-process "*strangler-console*") cmd)))

(defun tacit7-reload-env ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "load '"file"'\n")))
    (message cmd)
    (comint-send-string (get-buffer-process "*strangler-console*") cmd)))
(defun tacit7-show-console (prod)
  (interactive "P")
  (if prod
      (if (get-buffer "*strangler-production-console*")
          (switch-to-buffer "*strangler-production-console*")
        (strangler-production-console))
    (if (get-buffer "*strangler-console*")
        (switch-to-buffer "*strangler-console*")
    (strangler-console))))
(defun tacit7-pry-help ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "help\r")))
    (message cmd)
    (comint-send-string (get-buffer-process "*strangler-console*") cmd)))

(defun tacit7-reload-file-in-rails-pry ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "load '"file"'\n")))
    (message cmd)
    (comint-send-string (get-buffer-process "*rails*") cmd)))
(defun tacit7-reload-strangler ()
  (interactive)
  "Reload Strangler server."
  (kill-process (get-buffer-process "*strangler-server*"))
  (kill-buffer "*strangler-server*")
  (tacit7-prg-start-strangler))

(defun tacit7-start-strangler ()
  (interactive)
  (tacit7-prg-start-strangler))

(defun tacit7-prg-start-strangler-process ()
  "Start Strangler server."
  (start-process-shell-command "strangler" "*strangler-server*" "cd ~/repo/strangler/ && unicorn -p 3000 -c config/unicorn.rb")
  (set-process-query-on-exit-flag (get-buffer-process  "*strangler-server*") nil))

(defun tacit7-prg-start-strangler ()
  "Start Strangler server."
  (ansi-term "bash" "strangler-server")
  (comint-send-string (get-buffer-process "*strangler-server*") "cd ~/repo/strangler && unicorn -p 3000 -c config/unicorn.rb\n")
  (set-process-query-on-exit-flag (get-buffer-process  "*strangler-server*") nil))

(defun tacit7-inf-ruby-send-next ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (comint-send-string (get-buffer-process "*strangler-console*") "next\n"))
(defun tacit7-inf-ruby-send-exit ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (comint-send-string (get-buffer-process "*strangler-console*") "exit\n"))
;;;; Code that is not really used.,

(defun ugm/forward-center ()
  (interactive)
  (evil-scroll-down nil)
  (evil-scroll-line-to-center nil))

(defun ugm/backward-center ()
  (interactive)
  (evil-scroll-up nil)
  (evil-scroll-line-to-center nil))

(defun tacit7-find-next-center ()
  (interactive)
  (evil-ex-search-next nil)
  (evil-scroll-line-to-center nil))

(defun tacit7-inf-ruby-debugging-bindings ()
  (local-set-key (kbd "<f5>") 'tacit7-inf-ruby-send-next) ; add a key
  (local-set-key (kbd "<f6>") 'tacit7-inf-ruby-send-exit) ; add a key
  ;; more here
  )
(add-hook 'inf-ruby-mode-hook 'tacit7-inf-ruby-debugging-bindings)

(defun tacit7-reset-checkout-file ()
  "Do a git checkout on the current file."
  (interactive)
  (shell-command (concat "git checkout " (buffer-file-name (current-buffer))))
                                        ; revert buffer and dont ask y/n
  (revert-buffer t t)
  (message "File has been reset."))

(defun tacit7-staging-1kb-tramp ()
  "Get a tramp console for staging 1kb."
  (interactive)
  (find-file "/scp:admin@50.57.18.229:/var/apps/1000bulbs.com/current"))

(defun tacit7-transparency (num)
  "Set the transperancy of the window."
  (set-frame-parameter nil 'alpha `(,num ,num)))
(defun tacit7-transparent ()
  (interactive)
  (tacit7-transparency 93) )
(defun tacit7-mini-todo ()
  "Open an org file for a very breif to do list."
  (interactive)
  (find-file "~/uriel-repo/notes/mini-todo.org"))

(defun tacit7-rifle-notes ()
  (interactive)
  (helm-org-rifle-directories '("~/uriel-repo/notes") t))
;;;; utilities ends here
(defun lunaryorn/init-beacon ()
  (use-package beacon
    :init
    (progn
      (spacemacs|add-toggle beacon
        :status beacon-mode
        :on (beacon-mode)
        :off (beacon-mode -1)
        :documentation "Enable point highlighting after scrolling"
        :evil-leader "otb")

      (spacemacs/toggle-beacon-on))
    :config (spacemacs|hide-lighter beacon-mode)))

(defun load-file-p (file)
  "load the file if it exists"
  (if (file-exists-p file)
      (load-file file)
    (message (concat "The file "file" does not exsist."))))

(defun add-to-exec-path-p (file)
  "load the file if it exists"
  (if (file-exists-p file)
      (add-to-list 'exec-path  file)
    (message (concat "The file "file" does not exsist."))))

(defun check-dir-or-create (file)
  "Check if direcotry exists or create it."
  (if (file-exists-p file)
      ()
    (make-directory file)
    ))
(defun ranger-1kb ()
  (interactive)
  (ranger "~/repo/1000bulbs/1kb/"))

(defun ranger-strangler ()
  (interactive)
  (ranger "~/repo/1000bulbs/strangler/"))

(defun tacit7-prog-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun tacit7-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun tacit7-reddit-link ()
  (let* ((subreddit (org-entry-get nil "subreddit" t))
         (reddit-id (org-entry-get nil "reddit-id" t))
         (whole-link (concat "reddit.com/r/"subreddit"/"reddit-id)))
    (message whole-link)
    whole-link))



(defun send-pry-and-save ()
  (interactive)
  (save-excursion
    (end-of-line)
    (newline-and-indent)
    (insert "binding.pry")
    (save-buffer)))

(defun send-to-inf-ruby-and-go ()
  (interactive)
  (save-buffer)
  (tacit7-reload-file-in-pry)
  (eyebrowse-switch-to-window-config-9))


(defun kill-rspec-compilation ()
  (if (get-buffer-window "*rspec-compilation*")
      (delete-window (get-buffer-window "*rspec-compilation*")))

  (if (get-buffer "*rspec-compilation*")
      (kill-buffer "*rspec-compilation*")))

(defun kill-compilation ()
  (if (get-buffer-window "*compilation*")
      (delete-window (get-buffer-window "*compilation*")))

  (if (get-buffer "*compilation*")
      (kill-buffer "*compilation*")))
(advice-add 'rspec-verify :before 'kill-rspec-compilation)
(advice-add 'tacit7-strangler-run-current-spec-at-line :before 'kill-rspec-compilation)
(advice-add 'tacit7-strangler-run-current-spec-at-line :before 'rspec-notify-failure)

(defun tacit7/in-1kb-project-p ()
  (s-equals? (tacit7/project-dir-name) "1kb"))

(defun tacit7/project-dir-name ()
  (car (last (-reject 's-blank? (split-string (projectile-project-root) "/")))))
(defun ugm-switch-to-1kb ()
  (interactive)
  (cd "~/repo/1kb") ;
  (find-file "~/repo/1kb/1kb-proj.txt")
  (rvm-activate-corresponding-ruby))

(defun ugm-switch-to-strangler ()
  (interactive)
  (cd "~/repo/strangler/")
  (find-file "~/repo/strangler/strangler.ln.txt"))
  ;;(rvm-activate-corresponding-ruby))

(defun ugm-switch-to-strangler-checkout ()
  (interactive)
  (cd "~/repo/strangler/")
  (find-file "~/repo/strangler/strangler.org")
  (rvm-activate-corresponding-ruby)
  (magit-checkout))
(defun ugm/edit-gemfile ()
  (interactive)
  (find-file-other-window (concat (projectile-project-root) "Gemfile")))

(defun ugm/edit-abbrevs ()
  (interactive)
  (find-file-other-window "~/.emacs.d/abbrev_defs") "Gemfile")

(defun ugm/read-abbrevs ()
  (interactive)
  (read-abbrev-file "~/.emacs.d/abbrev_defs"))

(defun ugm/new-line ()
  (interactive)
  (end-of-line)
  (open-line 2)
  (forward-line 2)
  (evil-insert nil)
  (indent-for-tab-command))


(defun ugm/edit-evil ()
  (interactive)
  (find-file "~/.emacs.d/custom/evil-conf.el"))

(defun ugm/edit-1kb-journal ()
  (interactive)
  (find-file "~/uriel-repo/notes/1kb-journal.org"))

(defun ugm/edit-smyx ()
  (interactive)
  (find-file "~/uriel-repo/emacs/smac-theme/smac-theme.el"))

(defun ugm/load-smyx ()
  (interactive)
  (load-theme 'smac t))
(defun ugm/edit-init ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(defun ugm/send-previous-region ()
  "Send previous selected region."
  (interactive)
  (evil-visual-restore)
  (ruby-send-region (region-beginning) (region-end)))


(defun tacit7-reload-file-in-pry ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "load '"file"'\n")))
    (message cmd)
    (comint-send-string (get-buffer-process "*strangler-console*") cmd)))

(defun tacit7-reload-env ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "load '"file"'\n")))
    (message cmd)
    (comint-send-string (get-buffer-process "*strangler-console*") cmd)))
(defun tacit7-show-console ()
  (interactive)
  (eyebrowse-switch-to-window-config-9)
  (if (get-buffer "*strangler-console*")
      (switch-to-buffer "*strangler-console*")
    (strangler-console)))
(defun tacit7-pry-help ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "help\r")))
    (message cmd)
    (comint-send-string (get-buffer-process "*strangler-console*") cmd)))

(defun tacit7-reload-file-in-rails-pry ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (let* ((file (buffer-file-name))
         (cmd (concat "load '"file"'\n")))
    (message cmd)
    (comint-send-string (get-buffer-process "*rails*") cmd)))
(defun tacit7-reload-strangler ()
  (interactive)
  "Reload Strangler server."
  (kill-process (get-buffer-process "*strangler-server*"))
  (kill-buffer "*strangler-server*")
  (tacit7-prg-start-strangler))

(defun tacit7-start-strangler ()
  (interactive)
  (tacit7-prg-start-strangler))

(defun tacit7-prg-start-strangler-process ()
  "Start Strangler server."
  (start-process-shell-command "strangler" "*strangler-server*" "cd ~/repo/strangler/ && unicorn -p 3000 -c config/unicorn.rb")
  (set-process-query-on-exit-flag (get-buffer-process  "*strangler-server*") nil))

(defun tacit7-prg-start-strangler ()
  "Start Strangler server."
  (ansi-term "bash" "strangler-server")
  (comint-send-string (get-buffer-process "*strangler-server*") "cd ~/repo/strangler && unicorn -p 3000 -c config/unicorn.rb\n")
  (set-process-query-on-exit-flag (get-buffer-process  "*strangler-server*") nil))

(defun tacit7-inf-ruby-send-next ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (comint-send-string (get-buffer-process "*strangler-console*") "next\n"))
(defun tacit7-inf-ruby-send-exit ()
  (interactive)
  "Reload current file in pry.\nSends load function with current file"
  (comint-send-string (get-buffer-process "*strangler-console*") "exit\n"))
;;;; Code that is not really used.,

(defun ugm/forward-center ()
  (interactive)
  (evil-scroll-down nil)
  (evil-scroll-line-to-center nil))

(defun ugm/backward-center ()
  (interactive)
  (evil-scroll-up nil)
  (evil-scroll-line-to-center nil))

(defun tacit7-inf-ruby-debugging-bindings ()
  (local-set-key (kbd "<f5>") 'tacit7-inf-ruby-send-next) ; add a key
  (local-set-key (kbd "<f6>") 'tacit7-inf-ruby-send-exit) ; add a key
  ;; more here
  )
(add-hook 'inf-ruby-mode-hook 'tacit7-inf-ruby-debugging-bindings)

(defun tacit7-reset-checkout-file ()
  "Do a git checkout on the current file."
  (interactive)
  (shell-command (concat "git checkout " (buffer-file-name (current-buffer))))
                                        ; revert buffer and dont ask y/n
  (revert-buffer t t)
  (message "File has been reset."))

(defun tacit7-staging-1kb-tramp ()
  "Get a tramp console for staging 1kb."
  (interactive)
  (find-file "/scp:admin@50.57.18.229:/var/apps/1000bulbs.com/current"))

(defun tacit7-transparency (num)
  "Set the transperancy of the window."
  (set-frame-parameter nil 'alpha `(,num ,num)))
(defun tacit7-transparent ()
  (interactive)
  (tacit7-transparency 90) )
(defun tacit7-mini-todo ()
  "Open an org file for a very breif to do list."
  (interactive)
  (find-file "~/uriel-repo/notes/mini-todo.org"))

(defun tacit7-rifle-notes ()
  (interactive)
  (helm-org-rifle-directories '("~/uriel-repo/notes") t))
;;;; utilities ends here
(defun lunaryorn/init-beacon ()
  (use-package beacon
    :init
    (progn
      (spacemacs|add-toggle beacon
        :status beacon-mode
        :on (beacon-mode)
        :off (beacon-mode -1)
        :documentation "Enable point highlighting after scrolling"
        :evil-leader "otb")

      (spacemacs/toggle-beacon-on))
    :config (spacemacs|hide-lighter beacon-mode)))

(defun load-file-p (file)
  "load the file if it exists"
  (if (file-exists-p file)
      (load-file file)
    (message (concat "The file "file" does not exsist."))))

(defun add-to-exec-path-p (file)
  "load the file if it exists"
  (if (file-exists-p file)
      (add-to-list 'exec-path  file)
    (message (concat "The file "file" does not exsist."))))

(defun check-dir-or-create (file)
  "Check if direcotry exists or create it."
  (if (file-exists-p file)
      ()
    (make-directory file)
    ))
(defun ranger-1kb ()
  (interactive)
  (ranger "~/repo/1000bulbs/1kb/"))

(defun ranger-strangler ()
  (interactive)
  (ranger "~/repo/1000bulbs/strangler/"))

(defun tacit7-prog-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun tacit7-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun tacit7-reddit-link ()
  (let* ((subreddit (org-entry-get nil "subreddit" t))
         (reddit-id (org-entry-get nil "reddit-id" t))
         (whole-link (concat "reddit.com/r/"subreddit"/"reddit-id)))
    (message whole-link)
    whole-link))


(defun tacit7-build-youtube-link ()
  (let* ((heading (nth 4 (org-heading-components)))
         (time-string (car (split-string heading " ")))
         (minutes (nth 0 (split-string time-string ":")))
         (seconds (nth 1 (split-string time-string ":")))
         (total   (+ (* 60 (string-to-number minutes)) (string-to-number seconds)))
         (total-string (int-to-string total))
         (youtube-url (org-entry-get nil "youtube" t))
         (whole-link (concat youtube-url"&t="total-string)))
    (message whole-link)
    whole-link))

(defun tacit7-go-to-reddit-link ()
  (interactive)
  (browse-url (tacit7-reddit-link))
  )

(defun tacit7-go-to-youtube-at-time ()
  (interactive)
  (browse-url (tacit7-build-youtube-link))
  )

(defun org-go-to-youtube-maybe ()
  (if (save-excursion
        (beginning-of-line 1)
        (looking-at "\*\* [0-9]:[0-9][0-9]"))
      (progn (call-interactively 'tacit7-go-to-youtube-at-time)
             t) ;; to signal that we took action
    nil)) ;; to signal that we did not
(add-hook 'org-ctrl-c-ctrl-c-hook 'org-go-to-youtube-maybe)

;; (defun org-go-to-reddit-maybe ()
;;   (let* ((subreddit (org-entry-get nil "subreddit" t))
;;          (reddit-id (org-entry-get nil "reddit-id" t))
;;          (whole-link (concat "reddit.com/r/"subreddit"/"reddit-id)))
;;   (if (save-excursion
;;         (beginning-of-line 1)
;;         (looking-at "\*\* [0-9]:[0-9][0-9]"))
;;       (progn (call-interactively 'tacit7-go-to-youtube-at-time)
;;              t) ;; to signal that we took action
;;     nil)) ;; to signal that we did not
;; (add-hook 'org-ctrl-c-ctrl-c-hook 'org-go-to-youtube-maybe)



(defun tacit7-bundle-install ()
  (interactive)
  (let* ((notification-start (mac-term-notify-string "STRANGLER" "Bundle Install"))
         (notification-end (mac-term-notify-string "Apache" "Restarted"))
         (cmd (concat  " cd ~/repo/1000bulbs && docker-compose exec strangler bundle install")))
    (message "Restarting Apache")
    (compile cmd)))

(defun tacit7-restart-docker ()
  (interactive)
  (Let* ((cmd (concat  " cd ~/repo/1000bulbs && docker-compose restart")))
        (message "Restarting docker")
        (compile cmd)))

;; (defun tacit7-routes ()
;;   (interactive)
;;   (let* ((cmd (concat  " cd ~/repo/1000bulbs && docker-compose exec strangler rake routes")))
;;     (message "Restarting docker")
;;     (compile cmd)))

(defun tacit7-routes ()
  (interactive)
  (let* ((cmd (concat  " cd ~/repo/strangler &&  rake routes")))
    (message "Restarting docker")
    (compile cmd)))



                                        ; Filter Functions

(defun ordinary-insertion-filter (proc string)
  "This is the example filter function from the emacs org."
  (when (buffer-live-p (process-buffer proc))
    (with-current-buffer (process-buffer proc)
      (let ((moving (= (point) (process-mark proc))))
        (save-excursion
          ;; Insert the text, advancing the process marker.
          (goto-char (process-mark proc))
          (insert string)
          (set-marker (process-mark proc) (point)))
        (if moving (goto-char (process-mark proc)))))))



(defun tacit7-pry-nil-out-input (proc string)
  "PRint out something sensible in console"



  )


(defun start-1kb-docker-env ()
  (interactive)
  (start-process-shell-command
   "StartingDocker"
   "*starting-docker*"
   "cd ~/repo/1000bulbs && docker-compose up -d &&  terminal-notifier -title \"Docker init \" -message \"docker started\" ||  terminal-notifier -title \"docker init \" -message \"docker not worky\"  "))

(defun restart-1kb-docker-env ()
  (interactive)
  (start-process-shell-command
   "StartingDocker"
   "*starting-docker*"
   "cd ~/repo/1000bulbs && docker-compose restart &&  terminal-notifier -title \"Docker init \" -message \"docker started\" ||  terminal-notifier -title \"docker init \" -message \"docker not worky\"  "))

;; (defun tacit7-get-current-commit ()
;;   (cat .git/refs/heads/master))


;; https://github.com/1000Bulbs/strangler/blob/269177c8d11e187243c428a8e64ad2100379a1a7/app/forms/product_images_form.rb#L2
;; (defun staging-rollout-activate ()
;;   (interactive ))

;;1kb

(defun ugm/find-1kb-module ()
  (interactive)
  (counsel-file-jump nil "~/repo/1kb/public_html/inc/modules"))
(defun ugm/find-1kb-module ()
  (interactive)
  (counsel-file-jump nil "~/repo/1kb/public_html/inc/modules"))

(defun ugm/find-1kb-class ()
  (interactive)
  (counsel-file-jump nil "~/repo/1kb/public_html/inc/classes"))

(defun ugm/find-1kb-views ()
  (interactive)
  (counsel-find-file "~/repo/1kb/public_html/inc/views"))
(defun ugm/search-strangler-views ()
  (interactive)
  (counsel-ag nil "~/repo/strangler/app/views/"))

(defun ugm/search-strangler-views ()
  (interactive)
  (counsel-ag nil "~/repo/1kb/public_html/inc/views"))
(defun ugm/find-1kb-js ()
  (interactive)
  (counsel-find-file "~/repo/1kb/public_html/js/"))

(defun ugm/find-1kb-test ()
  (interactive)
  (counsel-find-file "~/repo/1kb/tests"))


(defun evil-normalize-all-buffers ()
  "Force a drop to normal state."
  (unless (eq evil-state 'normal)
    (dolist (buffer (buffer-list))
      (set-buffer buffer)
      (unless (or (minibufferp)
                  (eq evil-state 'emacs))
        (evil-force-normal-state)))
    (message "Dropped back to normal state in all buffers")))

(defvar evil-normal-timer
  (run-with-idle-timer 10 t #'evil-normalize-all-buffers)
  "Drop back to normal state after idle for 30 seconds.")


(defun tacit7-local-file-path-to-docker (file-path)
  (replace-regexp-in-string "\/Users\/"(user-login-name)"\/repo/1000bulbs" "" file-path))


(defun tacit-7-show-current-file-in-atom ()
  (interactive)
  (shell-command (concat "atom " buffer-file-name)))

(defun tacit-7-show-current-file-in-mac-default-app ()
  (interactive)
  (shell-command (concat "open "buffer-file-name)))


(defun tacit7-run-1kb-spec ()
  (interactive)
  (compile "cd ~/repo/1000bulbs && docker-compose exec 1kb rake test:filter[SupportPhoneNumberTest]"))

(defun tacit7-run-all-1kb-spec ()
  (interactive)
  (compile "cd ~/repo/1000bulbs && docker-compose exec 1kb rake test"))

(defun tacit7-deploy-strangler-to_staging ()
  "Deploy strangler to staging. Make sure you have jenkins mode setup."
  (interactive)
  (jenkins-job-call-build "deploy-strangler-to-staging"))


(defun tacit7-translate-to-french ()
  (interactive)
  (move-to-column 45 t)
  (insert (replace-regexp-in-string "\n" "" (shell-command-to-string "trans -brief \"$(pbpaste)\""))))

(defun projectile-rails-find-legacy-model ()
  "Find a legacy model."
  (interactive)
  (projectile-rails-find-resource
   "model: "
   '(("app/models/legacy/" "/models/legacy\\(.+\\)\\.rb$"))
   "app/models/legacy_${filename}.rb"))



(defun add-save-hook-pry-send ()
  "Mark the current file to be updated in pry"
  (interactive)
  (add-hook 'after-save-hook 'tacit7-auto-save-send-to-pry))


(defun remove-save-hook-pry-send ()
  "Mark the current file to be updated in pry"
  (interactive)
  (remove-hook 'after-save-hook 'tacit7-reload-file-in-pry))
(defun exit-current-console ()
  (interactive)
  (if (equal (buffer-name) "*strangler-production-console*")
      (remove-irbrc-prod))
  (if (equal (buffer-name) "*strangler-staging-console*")
      (remove-irbrc-staging))
  (comint-send-string (get-buffer-process (buffer-name)) "exit\r")
  (sleep-for 0 500)
  (kill-buffer-and-window ))

(defun remove-irbrc-prod ()
  (shell-command "ssh strangler@162.242.180.182 'rm /home/strangler/.irbrc'"))

(defun remove-irbrc-staging ()
  (shell-command "ssh strangler@50.57.2.155 'rm /home/strangler/.irbrc'"))
(add-hook 'inf-ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x C-x") 'exit-current-console)))

(defun insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))


(defun remove-binding-pry ()
  (interactive)
  ;; idiom for string replacement in current buffer

  (let ((case-fold-search t)) ; or nil

    (goto-char (point-min))
    (while (search-forward "binding.pry" nil t)
      (replace-match ""))

;; repeat for other string pairs
    ))


; https://emacs.stackexchange.com/questions/9925/persistent-shell-command-history

(defun turn-on-comint-history (history-file)
  (setq comint-input-ring-file-name history-file)
  (comint-read-input-ring 'silent))

(add-hook 'inf-ruby-mode-hook
          (lambda ()
            (turn-on-comint-history "~/.pry_history")))

(add-hook 'kill-buffer-hook #'comint-write-input-ring)
(add-hook 'kill-emacs-hook
          (lambda ()
            (--each (buffer-list)
              (with-current-buffer it (comint-write-input-ring)))))

(defun tacit7-edit-private ()
  (interactive)
  (find-file "~/uriel-repo/private/1kb.el"))

(defun upload-current-file-to-staging (server)
     (interactive
      (list
       (completing-read "Choose one: " '("strangler@strangler-staging"))))

     (let* ((file-name (file-name-nondirectory (buffer-file-name)))
           (command (concat "upload-rb-script "(buffer-file-name)" "server)))

       (start-process-shell-command "EmacsUploadScript" "*staging-file-upload*" command)))

(defun load-remote-file-to-console (buff)
  (interactive
   (list
    (completing-read "Choose one: " '("*strangler-staging-console*"))))

  (let* ((file-name (file-name-nondirectory (buffer-file-name)))
         (command (concat "load 'tmp/" file-name"', false \r")))
    (comint-send-string (get-buffer-process buff) command)))

(defun upload-current-file-to-production ()
  (interactive)

  (let* ((file-name (file-name-nondirectory (buffer-file-name)))
         (command (concat "upload-rb-script "(buffer-file-name)" strangler@strangler-production")))

    (start-process-shell-command "EmacsUploadScript" "*staging-file-upload*" command)))


(defun ag-counsel-search-views ()
  (interactive)
  (counsel-ag nil "app/views/" nil nil))
(defun load-remote-file-to-production-console ()
  (interactive)
  (let* ((file-name (file-name-nondirectory (buffer-file-name)))
         (command (concat "load 'tmp/" file-name"', false \r")))
    (message command)
    (comint-send-string (get-buffer-process "*strangler-production-console*") command)))


(defun projectile-rails-find-legacy-model ()
  "Find a legacy model."
  (interactive)
  (projectile-rails-find-resource
   "model: "
   '(("app/models/legacy" "/models/legacy/\\(.+\\)\\.rb$"))
   "app/models/legacy/${filename}.rb"))

(defun kill-rspec-compilation ()
  (if (get-buffer-window "*rspec-compilation*")
      (delete-window (get-buffer-window "*rspec-compilation*")))

  (if (get-buffer "*rspec-compilation*")
      (kill-buffer "*rspec-compilation*")))
(advice-add 'rspec-verify :before 'kill-rspec-compilation)
(advice-add 'rspec-verify-all :before 'kill-rspec-compilation)




(defun tacit7-build-compass ()
  (interactive)
  (let* ((notification (mac-term-notify-string "Phing Minify" "Done minifying"))
         (cmd "cd ~/repo/strangler && docker-compose exec 1kb vendor/bin/phing compass" ))
    (compile cmd)))

(defun tacit7-buffer-is-css-p ()
  "tells you if current buffer is a css file"
  (if (or
       (string-match-p ".css" (buffer-file-name))
       (string-match-p ".sass" (buffer-file-name))
       (string-match-p ".scss" (buffer-file-name)))
      t))

(defun tacit7-auto-build-compass ()
  (if (and
       (tacit7-buffer-in-project-p "1kb")
       (tacit7-buffer-is-css-p))

      (tacit7-build-compass)))


(defun tacit7-buffer-in-project-p (project-str)
  "Tells you if buffer is in project :project-str"
  (if (and
       (projectile-project-p)
       (string-match-p project-str (buffer-file-name)))

      t))

(add-hook 'after-save-hook 'tacit7-auto-build-compass)


(defun tacit7-open-strangler-file-in-prod ()
    "Put the current file name on the clipboard."
    (interactive)
    (let* ((project-file-path (tacit7-strangler-file-path (buffer-file-name)))
          (remote-file-path (concat "/home/strangler/strangler/current" project-file-path)))

      (when remote-file-path
        (find-file (concat "/ssh:strangler-production:" remote-file-path)))))


; https://mads-hartmann.com/2016/05/12/emacs-tree-view.html

(defun tacit7-get-github-link-at-line ()
  (interactive)
                                        ; You have to remove the 1kb from the file path.
  (let* (
         (link (concat (tacit7-buffer-proj-file-name)"#L"(tacit7-line-number-at-post-str))))
    (if (file-exists-p (buffer-file-name))
        (when link
          (with-temp-buffer
            (insert link)
            (clipboard-kill-region (point-min) (point-max)))
          (browse-url link))

      (message "File does not exist"))))


(defun tacit7-buffer-proj-file-name ()
  (let* ((proj-path (expand-file-name(vc-root-dir)))
         (filename (replace-regexp-in-string proj-path "" buffer-file-name))
         (branch   (magit-get-current-branch)))

    (concat "https://github.com/1000Bulbs/"(tacit7-proj-name)"/blob/"branch"/"filename)))

(defun tacit7-proj-name ()
  (string-trim(shell-command-to-string "basename `git rev-parse --show-toplevel`")))

(defun tacit7-github-proj-link ()
  (concat "https://github.com/1000Bulbs/"(tacit7-proj-name)"/"))



(defun tacit7-go-to-github-from-to-do ()
 )

(defun tacit7-pull-branch-from-to-do ()
  (interactive)
  (let ((branch (org-entry-get nil "BRANCH")))
    (magit-run-git "checkout" branch)))

(defun tacit7-checkout-branch-from-to-do ()
  (interactive)
  (let ((branch (org-entry-get nil "BRANCH")))
    (message branch)
    (magit-run-git "checkout" branch)))

(defun tacit7-go-to-strangler-pr ()
  (interactive)
  (let ((PR (org-entry-get nil "PR")))
    (browse-url (concat "https://github.com/1000Bulbs/strangler/pull/"PR))))

(defun tacit7-create-branch-from-to-do ()
  (interactive)
  (let ((branch (org-entry-get nil "BRANCH")))
    (magit-fetch-from-upstream "master")
    (magit-branch-and-checkout  branch "upstream/master")))

(defun org-checkout-branch-from-property-maybe ()
  (if (save-excursion
        (beginning-of-line 1)
        (looking-at ":BRANCH:"))
      (progn (call-interactively 'tacit7-checkout-branch-from-to-do)
             t) ;; to signal that we took action
    nil)) ;; to signal that we did not
(add-hook 'org-ctrl-c-ctrl-c-hook 'org-checkout-branch-from-property-maybe)


(defun tacit7-counsel-M-x ()
  (interactive)
  (counsel-M-x "^tacit7 "))


(defun tacit7-go-to-PR-from-to-do ()
  (interactive)
  (let* ((project (org-entry-get nil "project"))
    (pr (org-entry-get nil "PR"))
    (org (org-entry-get nil "organization"))
    (url (concat "https://github.com/"org"/"project"/pull/"pr)))
    (message url)
    (browse-url url))
  )

(defun org-go-to-PR-from-to-do-maybe ()
  (if (save-excursion
        (beginning-of-line 1)
        (looking-at ":PR:"))
      (progn (call-interactively 'tacit7-go-to-PR-from-to-do)
             t) ;; to signal that we took action
    nil)) ;; to signal that we did not
(add-hook 'org-ctrl-c-ctrl-c-hook 'org-go-to-PR-from-to-do-maybe)

(defun tacit-7-reset-project-files ()
  (interactive)
  (magit-reset))


(defun tacit7-fetch-and-checkout-PR-from-paste-bin ()
  "This will look at your clipbaord and try and checkout the branch"
  (interactive)
  (let* ((pr-strings (split-string (shell-command-to-string "pbpaste") ":"))
         (remote (car pr-strings))
         (branch (car (cdr pr-strings)))
         (full-branch-name (replace-regexp-in-string ":" "/" (shell-command-to-string "pbpaste") nil nil 1)))
    (if (string-match-p "uriel1000bulbs" remote)
        (message  branch)
        (magit-checkout branch)
      (progn
        (magit-fetch remote nil)
        (magit-checkout full-branch-name)))))

(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))




(defun tacit7-line-number-at-point ()
  (line-number (int-to-string (1+ (count-lines 1 (point))))))

(defun bjm/align-whitespace (start end)
  "Align columns by whitespace"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)\\s-" 1 0 t))
(defun bjm/align-comma (start end)
  "Align columns by comman"
  (interactive "r")
  (align-regexp start end
                "\\(\\s-*\\)'" 1 1 t))




;;;  Makes tramp faster
;;https://sideshowcoder.com/2017/10/24/projectile-and-tramp/

(defadvice projectile-on (around exlude-tramp activate)
  "This should disable projectile when visiting a remote file"
  (unless  (--any? (and it (file-remote-p it))
                   (list
                    (buffer-file-name)
                    list-buffers-directory
                    default-directory
                    dired-directory))
    ad-do-it))

(setq projectile-mode-line "Projectile") ; makes projectile not lag by not calculating the modline title



(defun checkout-git-hub-branch ()
  (interactive)
  (let* ((branch pbpaste)
         (branch-cmd (replace-regexp-in-string ":" "/" branch )))
    (shell-command (concat "git fetch --all && git checkout " branch-cmd))))

(defun start-elixir-mode ()
  (interactive)
  (define-key elixir-mode-map (kbd "C-M-s-p") "|> "))



(defadvice projectile-project-root (around ignore-remote first activate)
  (unless (file-remote-p default-directory) ad-do-it))


(defun tacit7-go-to-view-9-and-start-git ()
  (interactive)
  (eyebrowse-switch-to-window-config-9)
  (magit-status))


(defun tacit7-go-to-pastebin-file ()
  (interactive)
  (find-file (pbpaste)))


(defun pbpaste ()
  (shell-command-to-string "pbpaste"))


(defun run-1kb-tests ()
  (interactive)
  (send-to-iterm "cd ~/repo/strangler/ && docker-compose exec 1kb rake test"))


(defun send-to-iterm (command)
  (shell-command (concat "send-command-to-iterm \"" command "\" \r")))

(defun tacit7-create-archive-file ()
  (interactive)
  (let* ((filename (concat (buffer-file-name) "-copy")))
    (shell-command (concat"cp "(buffer-file-name)" "filename))))

(defun tacit7-edit-resume ()
  "Edit uriels resume"
  (interactive )
  (find-file "~/uriel-repo/notes/resume.org")
  )

(setq tacit7-current-notes "~/repo/strangler/strangler-proj.txt")
(defun tacit7-edit-notes ()
  "Edit notes"
  (interactive )
  (find-file tacit7-current-notes))
(defun tacit7-net-tab ()
  "next tab"
  (eyebrowse-next-window-config ))

(defun tacit7-current-ticket-notes ()
  (interactive)
  (find-file-other-frame  "~/current-ticket"))

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))

(defun tacit7-find-model ()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/app/models"))
  (projectile-find-file-in-directory "~/repo/strangler/app/models"))

(defun tacit7-find-model-spec ()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/app/models"))
  (projectile-find-file-in-directory "~/repo/strangler/spec/models"))

(defun tacit7-find-spec ()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/app/models"))
  (projectile-find-file-in-directory "~/repo/strangler/spec/"))

(defun tacit7-find-legacy-model ()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/app/models"))
  (projectile-find-file-in-directory "~/repo/strangler/app/models/legacy"))

(defun tacit7-find-controller ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/controllers"))

(defun tacit7-find-legacy-controller ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/controllers/legacy"))

(defun tacit7-find-view ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/views"))

(defun tacit7-find-service ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/services"))
