		 ;;; org-man.el - Support for links to manpages in Org
(require 'org)
(require 'projectile)
(require 's)
(org-add-link-type "project" 'org-man-open)
(add-hook 'org-store-link-functions 'org-man-store-link)

(defcustom org-project-command 'project
	"The Emacs command to change projects."
	:group 'org-link
	:type '(choice (const dired) (const ranger) (const helm-projectile-find-file)))

(defun org-project-open (path)
	"Visit the manpage on PATH.
		 PATH should be a topic that can be thrown at the man command."
	(funcall org-project-command path))

(defun org-man-store-link ()
	"Store a link to a manpage."
	(when (projectile-project-p))
	;; This is a man page, we do make this link
	(let* (dir (tacit7/project-dir-name))
		(link (concat "man:" dir))
		(description (format "project %s" dir)))
	(org-store-link-props
	 :type "project"
	 :link link
	 :description description))

(defun tacit7/project-dir-name ()
	(last (-reject 's-blank? (split-string (projectile-project-root) "/"))))

	(provide 'org-project-link)
;;;
