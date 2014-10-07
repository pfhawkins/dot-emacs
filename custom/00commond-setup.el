(setq system-uses-terminfo nil)

(prefer-coding-system 'utf-8)

(setq-default truncate-lines nil)
(setq-default indent-tabs-mode nil)

(defalias 'yes-or-no-p 'y-or-n-p) 

(setq search-highlight t)

(setq x-select-enable-clipboard t)

(setq backup-inhibited t)

(setq auto-save-default nil)

(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq tramp-default-method "ssh")
