 (projectile-global-mode)
 (setq projectile-enable-caching t)
 ;; Press Command-p for fuzzy find in project
 (global-set-key (kbd "s-p") 'helm-projectile)
 ;; Press Command-b for fuzzy switch buffer
 (global-set-key (kbd "s-b") 'projectile-switch-to-buffer)
(setq projectile-completion-system 'helm)
(setq helm-projectile-sources-list '(helm-source-projectile-projects
                                     helm-source-projectile-files-list))
