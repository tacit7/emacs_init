
;;;;
(defvar ugm/default-ac-sources
			'(ac-source-features
				ac-source-functions
				ac-source-yasnippet
				ac-source-variables
				ac-source-symbols
				ac-source-filename
				ac-source-abbrev
				ac-source-dictionary
				ac-source-words-in-same-mode-buffers))
(setq-default ac-sources 'ugm/default-ac-sources)
(defu)
(setq	ac-sources'(ac-source-features
				ac-source-functions
				ac-source-yasnippet
				ac-source-variables
				ac-source-symbols
				ac-source-filename
				ac-source-abbrev
				ac-source-dictionary
				ac-source-words-in-same-mode-buffers))
(ac-config-default)

(defun ugm/enh-ruby-ac-sources ()
	(setq ac-sources
				(append '(ac-source-filename
									ac-source-yasnippet
									;; ac-source-variables ;; only for lisp
									;; ac-robe-setup
									ac-source-abbrev
									ac-source-dictionary
									ac-source-words-in-same-mode-buffers))))
(defun ugm/lisp-set-ac-sources ()
	(setq ac-sources ugm/default-ac-sources))

(add-hook  'emacs-lisp-mode-hook 'ugm/lisp-set-ac-sources)
(add-hook 'enh-ruby-mode-hook 'ugm/enh-ruby-ac-sources)
(add-to-list 'ac-sources 'ac-source-filename)
(setq ac-ignore-case nil)

(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'prog-mode)

;;;
