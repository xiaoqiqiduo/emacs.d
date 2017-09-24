(package-initialize)

(add-to-list 'load-path "~/.emacs.d/packages/")
(load "~/.emacs.d/packages.el")
(load "~/.emacs.d/org-conf.el")




(setq require-final-newline nil)
(defvar compilation-scroll-output)
(setq compilation-scroll-output 'first-error)

(global-hl-line-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)

(scroll-bar-mode -1)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-x O")
		(lambda ()
                  (interactive)
		  (other-window -1)))

(global-unset-key (kbd "C-z"))

(global-set-key (kbd "C-^")
		(lambda ()
                  (interactive)
		  (join-line -1)))


(global-set-key (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "C-x 3")
		(lambda ()
                  (interactive)
		  (split-window-right)
		  (other-window 1)))

(setq mac-command-modifier 'meta)
(save-place-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(setq show-trailing-whitespace t)
(global-linum-mode 1)
(column-number-mode t)
(size-indication-mode t)

(setq ring-bell-function 'ignore)
(setq save-place-file (concat user-emacs-directory "places"))
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(fset 'yes-or-no-p 'y-or-n-p)

(ido-mode t)

(setq ido-enable-flex-matching t)
(defun ido-define-keys()
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(global-set-key (kbd "C-x C-b") 'ibuffer)



(winner-mode)

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed."
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))
(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

(defun toggle-comment-on-line ()
  "Comment or uncomment current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(global-set-key (kbd "C-M-;") 'toggle-comment-on-line)


(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))


(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added-sign "++")
 '(git-gutter:deleted-sign "--")
 '(git-gutter:modified-sign "  ")
 '(package-selected-packages
   (quote
    (org-plus-contrib org htmlize git-gutter yasnippet persp-projectile perspective projectile exec-path-from-shell ace-jump-mode ag magit dired-k smartparens smart-mode-line guide-key volatile-highlights nyan-mode helm paredit shell-switcher use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
