(require 'projectile-rails)
(projectile-rails-mode)

 (projectile-global-mode)
 (setq projectile-enable-caching t)
 ;; Press Command-p for fuzzy find in project
 (global-set-key (kbd "s-p") 'helm-projectile)
 ;; Press Command-b for fuzzy switch buffer
 (global-set-key (kbd "s-b") 'projectile-switch-to-buffer)
(setq projectile-completion-system 'helm)
(setq helm-projectile-sources-list '(helm-source-projectile-projects
                                     helm-source-projectile-files-list))


(defun ugm/project-geoforce ()
  (interactive)
  (cd "~/repo/geoforce/")
  (projectile-switch-project-by-name "~/repo/geoforce/"))

(defun ugm/notes ()
  (interactive)
  (cd "~/repo/org-mode/")
  (projectile-switch-project-by-name "~/repo/org-mode/"))

(defun ugm/project-twilio-notes ()
  (interactive)
  (cd "~/repo/org-mode/projects/")
  (projectile-switch-project-by-name "~/repo/org-mode/projects")
	(find-file "~/repo/org-mode/projects/twilio.org"))

(defun ugm/project-fleet ()
  (interactive)
  (cd "~/repo/fleet/")
  (projectile-switch-project-by-name "~/repo/fleet/"))

(defun ugm/project-notifier-service ()
  (interactive)
  (cd "~/repo/notifier-service/")
  (projectile-switch-project-by-name "~/repo/notifier-service/"))
;;;
