

(setq ibuffer-saved-filter-groups
			'(("work"
				 ("emacs-config" (or (filename . ".emacs.d")
														 (filename . "emacs-config")))
				 ("Org" (or (mode . org-mode)
										(filename . "OrgMode")))
				 ("code" (filename . "code"))
				 ("Magit" (name . "\*magit"))
				 ("ERC" (mode . erc-mode))
				 ("Help" (or (name . "\*Help\*")
										 (name . "\*Apropos\*")
										 (name . "\*info\*"))))))
