;;; tacitrails.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 John Doe
;;
;; Author: John Doe <https://github.com/umaldonado@1000bulbs.com>
;; Maintainer: John Doe <john@doe.com>
;; Created: April 20, 2021
;; Modified: April 20, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/umaldonado/rails
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:


(defun tacit7/project-to-strangler ()
  "Switch to stranger project."
  (interactive)
  (cd "~/repo/strangler/")
  ;; (rvm-activate-corresponding-ruby)
  ;(strangler-console)
  (find-file "~/repo/strangler/"))
;Rails finders
(defun tacit7-find-controller ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/controllers"))

(defun tacit7-find-decorator ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/decorators/"))

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

(defun tacit7-find-view ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/views"))

(defun tacit7-find-legacy-controller ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/controllers/legacy"))

(defun tacit7-find-legacy-model ()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/app/models"))
  (projectile-find-file-in-directory "~/repo/strangler/app/models/legacy"))

(defun tacit7-find-legacy-view ()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/app/models"))
  (projectile-find-file-in-directory "~/repo/strangler/app/views/legacy"))

(defun tacit7-find-legacy-javascript ()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/app/models"))
  (projectile-find-file-in-directory "~/repo/strangler/app/assets/javascripts"))

(defun tacit7-find-service ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/services"))

(defun tacit7-find-config ()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/config"))


;;; specs
(defun tacit7-find-controller-spec()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/spec/controllers"))

(defun tacit7-find-model-spec()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/spec/models"))
  (projectile-find-file-in-directory "~/repo/strangler/spec/models"))

(defun tacit7-find-view-spec()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/spec/views"))

(defun tacit7-find-assets-spec()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/app/views/assets"))

(defun tacit7-find-legacy-controller-spec()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/spec/controllers/legacy"))

(defun tacit7-find-legacy-model-spec()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/spec/models"))
  (projectile-find-file-in-directory "~/repo/strangler/spec/models/legacy"))

(defun tacit7-find-legacy-view-spec()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/spec/models"))
  (projectile-find-file-in-directory "~/repo/strangler/spec/views/legacy"))

(defun tacit7-find-legacy-javascript-spec()
  (interactive)
  ;(ido-find-file-in-dir "~/repo/strangler/spec/models"))
  (projectile-find-file-in-directory "~/repo/strangler/spec/assets/javascripts"))

(defun tacit7-find-service-spec()
  (interactive)
  (projectile-find-file-in-directory "~/repo/strangler/spec/services"))

;;; Hooks
;;;

(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-.") 'tacit7-binding-pry)
            (local-set-key (kbd "C-x C-x") 'exit-current-console)))



(provide 'tacitrails)
;;; rails.el ends here
