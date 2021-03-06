(require 'enh-ruby-mode)
;(setq enh-ruby-program "/Users/umaldonado/.rbenv/shims/ruby")
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(setq enh-ruby-bounce-deep-indent t)
(setq enh-ruby-hanging-brace-indent-level 2)

(require 'cl) ; If you don't have it already

(defun* get-closest-gemfile-root (&optional (file "Gemfile"))
	"Determine the pathname of the first instance of FILE starting from the current directory towards root.
	This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
	of FILE in the current directory, suitable for creation"
	(let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
	  (loop
	    for d = default-directory then (expand-file-name ".." d)
	    if (file-exists-p (expand-file-name file d))
	    return d
	    if (equal d root)
	    return nil)))

(require 'compile)

(defun rspec-compile-file ()
  (interactive)
  (compile (format "cd %s;bundle exec rspec %s"
		   (get-closest-gemfile-root)
		   (file-relative-name (buffer-file-name) (get-closest-gemfile-root))
		   ) t))

(defun rspec-compile-on-line ()
  (interactive)
  (compile (format "cd %s;bundle exec rspec %s -l %s"
		   (get-closest-gemfile-root)
		   (file-relative-name (buffer-file-name) (get-closest-gemfile-root))
		   (line-number-at-pos)
		   ) t))

(add-hook 'enh-ruby-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-c l") 'rspec-compile-on-line)
	    (local-set-key (kbd "C-c k") 'rspec-compile-file)
	    ))


(add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-inf-ruby))

(add-hook 'enh-ruby-mode-hook
          (lambda () (modify-syntax-entry ?_ "_")))

(defadvice ruby-indent-line (around outdent-modifiers activate)
  (if (save-excursion
        (beginning-of-line)
        (looking-at "\s*\\(private\\|protected\\|public\\)\s*$"))
      (save-excursion
        (beginning-of-line)
        (just-one-space 0))
      ad-do-it))
(defun get-current-test-name ()
  (save-excursion
    (let ((pos)
          (test-name))
      (re-search-backward "test \"\\([^\"]+\\)\" do")
      (setq test-name (buffer-substring-no-properties (match-beginning 1) (match-end 1)))
      (concat "test_" (replace-regexp-in-string " " "_" test-name)))))


(defun run-test-at-point ()
  (interactive)
  (let ((root-dir (projectile-project-root)))
    (compile (format "ruby -Ilib:test -I%s/test %s -n %s" root-dir (expand-file-name (buffer-file-name)) (get-current-test-name)))))

(defun run-tests-in-file ()
  (interactive)
  (let ((root-dir (projectile-project-root)))
    (compile (format "ruby -Ilib:test -I%s/test %s" root-dir (expand-file-name (buffer-file-name))))))


(defun projectile-rails-find-api ()
  (interactive)
  (projectile-rails-find-resource
   "api: "
   '(("app/controllers/api/" "api/\\(.+\\)\\.rb$"))
   "app/controllers/api//${filename}.rb"))
;;; ruby-conf.el ends here
(defun projectile-rails-find-services ()
  (interactive)
  (projectile-rails-find-resource
   "service: "
   '(("app/services/" "/services/\\(.+\\)\\.rb$"))
   "app/services/${filename}.rb"))

(defun projectile-rails-find-serializers ()
  (interactive)
  (projectile-rails-find-resource
   "Serializer: "
   '(("app/serializers/" "/serializers/\\(.+\\)\\.rb$"))
   "app/serializers/${filename}.rb"))
