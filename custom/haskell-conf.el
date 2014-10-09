

;; Caba/Library/Haskell/$compiler/lib/binl
(setenv "PATH" (concat "~/Library/Haskell/bin/:" (getenv "PATH")))
(add-to-list 'exec-path "~/Library/Haskell/bin/")


(setenv "PATH" (concat "/Users/umaldonado/Library/Haskell/ghc-7.6.3/lib/ghc-mod-5.1.1.0/bin:" (getenv "PATH")))
(add-to-list 'exec-path "/Users/umaldonado/Library/Haskell/ghc-7.6.3/lib/ghc-mod-5.1.1.0/bin/")
;;; GHC Stuff
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook 'structured-haskell-mode)
