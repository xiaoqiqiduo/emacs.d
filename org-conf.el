;;; org.el --- org package load and config

;;; Commentary:
;; No Comments!

;;; Code:
(use-package htmlize
  ;; used for fontify code in exporting of org
  :defer t
  )


(defun setup-latex()
    ;; latex templates
  (require 'ox-latex)
  ;; (setq org-export-latex-listings t)
  (add-to-list 'org-latex-classes
               '("acmart"
                 "\\documentclass[sigconf]{acmart}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; pdf code listing options
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; this will add color to pdf output from latex
  ;; needs to install Pygments
  (require 'ox-latex)
  (add-to-list 'org-latex-packages-alist '("" "listings"))
  (add-to-list 'org-latex-packages-alist '("" "color"))
  ;; (add-to-list 'org-latex-packages-alist '("newfloat" "minted"))
  ;; (setq org-latex-listings 'minted)
  (setq org-latex-listings 'listings)
  )



(defun setup-ob()
    ;; my srcml converter
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((awk . t)
     (emacs-lisp . t)
     (python . t)
     (ruby . t)
     ;; (shell . t)
  ;;    ;; other babel languages
     (plantuml . t)
  ;;    ;; this should be capital C, the same as in #+begin_src C
     (C . t)
     (dot . t)
     ;; (R . t)
     (sqlite . t)
     (lisp . t)
     (latex . t)
     )
   )

  ;; CAUTION The following lines will permit the execution of R code without a confirmation.
  ;; (defun my-org-confirm-babel-evaluate (lang body)
  ;;   (not (string= lang "R")))  ; don't ask for R
  ;; (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
)


(use-package org
  :init
  (setq org-plain-list-ordered-item-terminator '?.) ; remove using ?) causing a listing
  ;; :defer t
  :bind
  (
   ;; ("C-c n" . org-capture)
   ;; ("C-c o" . org-open-at-point)
   ("C-c o" . org-open-at-point-global)
   ("C-c t" . org-todo)
   ;; ("C-c a" . org-agenda)
   )
  :config
  (setup-ob)
  (setup-latex)

  (setq org-file-apps
        (quote
         ((auto-mode . emacs)
          ("\\.mm\\'" . default)
          ;; have to use this to open in browser
          ;; otherwise will open in emacs
          ("\\.x?html?\\'" . "/usr/bin/chromium %s")
          ("\\.pdf\\'" . default))))

  (when (string= system-type "darwin")
    (setq org-file-apps
          (quote
           ((auto-mode . emacs)
            ("\\.mm\\'" . default)
            ;; have to use this to open in browser
            ;; otherwise will open in emacs
            ("\\.x?html?\\'" . "open %s")
            ("\\.pdf\\'" . "open %s")))))
  
  ;; (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (setq org-log-done 'time)
  (setq org-startup-folded nil)
  (setq org-yank-folded-subtrees nil)
  ;; the forbidden, by default, is ,'", but I want all of them actually. By the way why these are forbidden?
  (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\r\n")
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (setq org-export-backends (append '(man) org-export-backends))
  (define-key org-mode-map (kbd "C-j") (lambda()
                                         (interactive)
                                         (join-line -1)))

  ;; better bullets for lists
  ;; must have and only have one or more space at the beginning
  ;; the - will be turned into a utf8 Unicode bullet!
  ;; damn beautiful
  (font-lock-add-keywords 'org-mode
                          '(("^ +\\([-*]\\) "
                             (0 (prog1 ()
                                  (compose-region
                                   (match-beginning 1)
                                   (match-end 1) "•"))))))
  ;; hide the // for slant
  ;; insert \ on them is the common trick to edit the hidden part
  ;; (setq org-hide-emphasis-markers t)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)" "CANCELED(c)")))
  (setq org-todo-keyword-faces
        '(("TODO" . org-todo) ("CANCELED" . org-warning) ("STARTED" . (:foreground "white" :background "red"))))

  
  (use-package org-plus-contrib)
  ;; highlight
  (setq org-src-fontify-natively t))

(provide 'org-conf)
;;; org-conf.el ends here
