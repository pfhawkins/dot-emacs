;; (require 'cask "~/.cask/cask.el")
;; (cask-initialize)
;; (require 'pallet)
(add-to-list 'load-path "~/.emacs.d/custom")
(load "00commond-setup.el")
;;(load "01ruby.el")

;;(load "03auto-complete.el")

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes, el-get-sources should only accept PLIST element
(setq
 el-get-sources
 '((:name buffer-move; have to add your own keys
            :after (progn
                        (global-set-key (kbd "<C-S-up>")     'buf-move-up)
                           (global-set-key (kbd "<C-S-down>")   'buf-move-down)
                              (global-set-key (kbd "<C-S-left>")   'buf-move-left)
                                 (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name smex; a better (ido like) M-x
            :after (progn
                        (setq smex-save-file "~/.emacs.d/.smex-items")
                           (global-set-key (kbd "M-x") 'smex)
                              (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   (:name magit; git meet emacs, and a binding
            :after (progn
                        (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change; move pointer back to last change
            :after (progn
                        ;; when using AZERTY keyboard, consider C-x C-_
                        (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get; el-get is self-hosting
   escreen            ; screen for emacs, C-\ C-h
   switch-window; takes over C-x o
   auto-complete; complete as you type with overlays
   zencoding-mode; http://www.emacswiki.org/emacs/ZenCoding
   color-theme                ; nice looking emacs
   color-theme-tango))                ; check out color-theme-solarized

;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
(when (el-get-executable-find "cvs")
  (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs

(when (el-get-executable-find "svn")
  (loop for p in '(psvn    ; M-x svn-status
                   yasnippet; powerful snippet mode
                      )
        do (add-to-list 'my:el-get-packages p)))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)
