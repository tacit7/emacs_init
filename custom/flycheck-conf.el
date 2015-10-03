(define-fringe-bitmap 'my-flycheck-fringe-indicator
	(vector #b00000000
					#b00000000
					#b00000000
					#b00000000
					#b00000000
					#b00001000
					#b00001100
					#b00001110
					#b11111111
					#b11111111
					#b11111111
					#b00001110
					#b00001100
					#b00001000
					#b00000000
					#b00000000
					#b01111111))
(flycheck-define-error-level 'error
	:overlay-category 'flycheck-error-overlay
	:fringe-bitmap 'my-flycheck-fringe-indicator
	:fringe-face 'flycheck-fringe-error)

(flycheck-define-error-level 'warning
	:overlay-category 'flycheck-warning-overlay
	:fringe-bitmap 'my-flycheck-fringe-indicator
	:fringe-face 'flycheck-fringe-warning)

(flycheck-define-error-level 'info
	:overlay-category 'flycheck-info-overlay
	:fringe-bitmap 'my-flycheck-fringe-indicator
	:fringe-face 'flycheck-fringe-info)


(setq flycheck-rubocop-lint-only t) ;; Make rubocop quiet down
