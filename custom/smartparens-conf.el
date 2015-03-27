(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(enh-ruby-mode)
		       (sp-local-pair "|" "|"))
(sp-with-modes '(rhtml-mode)
	       (sp-local-pair "<" ">")
	       (sp-local-pair "<%" "%>"))


