(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-directory "~/uriel-repo/notes/")
(setq org-log-done 'time) ; timestamp for Todos when done
;; (setq org-plantuml-jar-path "~/uriel-repo/emacs/scripts/plantuml.jar")
;; (setq plantuml-jar-path "~/uriel-repo/emacs/scripts/plantuml.jar")
(setq org-plantuml-jar-path "~/Downloads/plantuml-1.2022.0.jar")
(setq plantuml-jar-path "~/Downloads/plantuml-1.2022.0.jar")
(setq plantuml-default-exec-mode 'jar)
(setq org-confirm-babel-evaluate nil)
(setq org-fontify-whole-heading-line t)
(setq org-startup-with-inline-images t)


(setq org-clock-persist 'history)           ;; So we can clock tasks
(org-clock-persistence-insinuate)
(setq org-clock-into-drawer t)              ;; Clock into drawer
(setq org-ellipsis " ▾")
(setq org-startup-indented t)
(setq org-src-fontify-natively t)           ;; makes code blocks look nicer
(setq org-hide-leading-stars t)
(setq org-export-with-sub-superscripts nil) ;; Set to the location of your Org files on your local system



(defun tacit7/insert-file-name ()
  (interactive)
  (let* (
         (project-file (projectile-completing-read "Find file: "
                                                   (projectile-current-project-files)))
         (full-path-file (expand-file-name project-file (projectile-project-root)))
         (file-name (nth 0
                         (last
                          (split-string full-path-file "/"))))
         (org-link (tacit7/org-link full-path-file file-name)))
    (insert org-link)))

(defun commit-at-point ()
  (interactive)
  (magit-show-commit (thing-at-point 'word)))




(defun tacit7/is-directory-p (path)
  (nth 0 (file-attributes path)))

(defun tacit7/ls-directories (path)
  (let* ((exclude-dot-dirs-regex "^\\([^.]\\|\\.[^.]\\|\\.\\..\\...\\)")
         (files-and-dirs (directory-files path :show-full-path exclude-dot-dirs-regex))
         (dirs ((-select 'tacit7/is-directory-p files-and-dirs))))
    dirs))

                                        ;http://ergoemacs.org/emacs/elisp_idioms_prompting_input.html
(defun tacit7-create-new-org-task (task priority effort)
  "Insert a task."
  (interactive
   (list
    (read-string "Task Name: ")
    (completing-read "Priority: " '("A" "B" "C"))
    (completing-read "Effort: " '("0" "0:10" "0:20" "0:30" "1:00" "2:00" "4:00" "6:00" "8:00"))))
  (insert
   "* TODO [#"priority"] " task "\n"
   ":LOGBOOK:\n"
   ":END:\n"
   ":PROPERTIES:\n"
   ":Effort: " effort "\n"
   ":END:"))

(defun tacit7-get-github-link ()
  (interactive)
  "Load http://github.com/user/repo/file#ANCHOR in a web browser and add it to
the kill ring."
  (let* ( (anchor (github-browse-file--anchor-lines))
          (url (replace-regexp-in-string  "uriel1000bulbs" "1000Bulbs"
                                          (concat "https://github.com/"
                                                  (github-browse-file--relative-url) "/"
                                                  (cond ((eq major-mode 'magit-status-mode) "tree")
                                                        ((member major-mode github-browse-file--magit-commit-link-modes) "commit")
                                                        (github-browse-file--view-blame "blame")
                                                        (t "blob")) "/"
                                                  (github-browse-file--current-rev) "/"
                                                  (github-browse-file--repo-relative-path)
                                                  (when anchor (concat "#" anchor))))))
    (with-temp-buffer
      (insert url)
      (clipboard-kill-region (point-min) (point-max)))))

(setq org-confirm-babel-evaluate nil)

(global-set-key "\C-x\C-d" 'insert-current-date-time)
(global-set-key "\C-x\C-t" 'insert-current-time)

(setq org-capture-templates
      '(("n"
         "Journal Entry"
         entry (file+datetree "~/uriel-repo/notes/1kb-journal.org")
         "* %<%I:%M CST> ")
        ("s"
         "Journal Entry - Subtask"
         entry (file+datetree "~/uriel-repo/notes/1kb-journal.org")
         "******* %<%I:%M CST> ")
        ("c"
         "Journal Entry in Current Ticket"
         entry
         (file+olp current-ticket "Tests")
         "* %<%I:%M CST> %?")))           ;


(add-to-list 'org-structure-template-alist
             '("srb" "#+BEGIN_SRC ruby :result output :session strangler-console\n?\n#+END_SRC"))

(add-to-list 'org-structure-template-alist
             '("rb" "#+BEGIN_SRC ruby \n?\n#+END_SRC"))

(add-to-list 'org-structure-template-alist
             '("srp" "#+BEGIN_SRC python :results output\n?\n#+END_SRC"))

;; ====================
;; insert date and time

(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-date-format "%a %b %d %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun tacit7-insert-current-date ()
  "insert the current date into current buffer.
Uses `current-date-format' for the formatting the date/time."
       (interactive)
       (insert (format-time-string current-date-format (current-time))))

(defun ugm/insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )

(defun ugm/insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )
(defalias 'tacit7-insert-timestamp 'ugm/insert-current-time)
(setq org-agenda-custom-commands
      '(("gm" "Calendar" agenda ""
         ((org-agenda-ndays -60)
          (org-agenda-start-on-weekday 0)))))


;; (defun ugm/org-insert-code-source (lang)
;; 	(interactive "sLanguage: ")
;; 	(insert "#+BEGIN_SRC ")
;; 	(insert lang)
;; 	(insert " \n")
;; 	(insert "#+END_SRC "))

;; (defun ugm/org-insert-uml (project file-name)
;; 	(interactive "sProject: \nsName: ")
;; 	(insert "#+BEGIN_SRC plantuml :file ./img/" project  "/" file-name)
;; 	(insert " \n")
;; (insert "#+END_SRC "))


(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)
(setq org-export-publishing-directory "~/repo/exports/")

;; Add advice to let me set a different directory for the exported
;; files. Usually I do this with a directory-local variable for a
;; project, like this:
;; ((org-mode . ((my/org-export-dir "export-dir"))))

(defun my/set-org-export-directory (orig-fun extension
                                             &optional subtreep pub-dir)
  "Advice function to set export directory for `org-export-output-file-name'.
Set `my/org-export-dir' to specify the desired export directory."
  (let ((pub-dir (or pub-dir
                     (and (boundp 'my/org-export-dir)
                          my/org-export-dir))))
    (apply orig-fun extension subtreep pub-dir)))

(advice-add 'org-export-output-file-name
            :around #'my/set-org-export-directory)
