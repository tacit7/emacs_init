
;;;;

(ac-config-default)
(defun ugm/enh-ruby-ac-sources ()
	(setq ac-sources
				(append '(ac-source-filename
									ac-source-yasnippet
									ac-source-variables
									ac-source-abbrev
									ac-source-dictionary
									ac-source-words-in-same-mode-buffers))))

(add-hook 'enh-ruby-mode-hook 'ugm/enh-ruby-ac-sources)
(add-to-list 'ac-sources 'ac-source-filename)
(setq ac-ignore-case nil)

(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'prog-mode)

;;;
