;;; pacakge --- Summary:
;;; Utility functions that help with streamlining testing in rails.
;;; Commentary:
;;; Code:
;;;
(defvar current-spec nil
  "Set this var to the current spec that you want to test.")

(defun set-current-spec ()
  "Set the current spec to run."
  (interactive)
  (setq current-spec (buffer-file-name))
  (call-interactively #'tacit7-watch-file))

(defun run-spec-in-terminal () "Sends the current spec to iterm."
(send-to-iterm (concat "bundle exec rspec " current-spec)))

(defvar tacit7-watched-files nil
  "List of files that are being watched for changes.  If any of these files changes, the specs are run.")

(defun tacit7-watch-file () "Push current file to the watched file list."
(interactive) (add-to-list 'tacit7-watched-files (buffer-file-name)))

(defun rspec-run-current-spec-if-current-buffer-is-watched ()
  "When a file is saved, this function is run to check if the current file is being watched."
  (if (-contains? tacit7-watched-files (buffer-file-name))
        (save-window-excursion
          ;; (run-spec-in-terminal))));; this is a function that uses a bash script to trun in iterm
          (rspec-run-current-spec))))

(defun rspec-notify-failure (buffer msg)
  "Notify rspec using osx notifications."
  (mac-term-notify "Rspec" msg))

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
