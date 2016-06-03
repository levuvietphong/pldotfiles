;;; packages.el --- pcao Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; keys
;; align comments: align-regexp #

(defvar pcao-packages
  '(
    ;; package pcaos go here
    ;; projectile
    password-store
    turnip
    helm
    ;; persp-mode
    yaml-mode
    quickrun
    ;; pbcopy
    gradle-mode
    edit-server
    org
    ;; scala-mode2
    sbt
    python
    sphinx-doc
    smart-mode-line
    stock-ticker
    jabber
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar pcao-excluded-packages '(
                                 )
  "List of packages to exclude.")

;; For each package, define a function pcao/init-<package-pcao>
;;
;; (defun pcao/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

;; spacemacs
(spacemacs/set-leader-keys "oh" 'howdoi-query)
(spacemacs/set-leader-keys "oa" 'helm-projectile-ag)
(spacemacs/set-leader-keys "os" 'pcao/edit-dot-spacemacs)
(spacemacs/set-leader-keys "op" 'pcao/edit-dot-packages)
(spacemacs/set-leader-keys "on" 'helm-deft)
(spacemacs/set-leader-keys "oq" 'q)
(spacemacs/set-leader-keys "oo" 'ido-find-file)
(spacemacs/set-leader-keys "oi" 'yas-insert-snippet)
(spacemacs/set-leader-keys-for-major-mode 'python-mode "is" 'yas-insert-snippet)
(spacemacs/set-leader-keys-for-major-mode 'org-mode "is" 'yas-insert-snippet)
;; (spacemacs/set-leader-keys-for-major-mode 'org-mode "eb" 'org-babel-execute-src-block)
(spacemacs/set-leader-keys "ob" 'org-babel-execute-src-block)
(define-key evil-visual-state-map "X" 'evil-delete-and-yank)


;; (spacemacs/set-leader-keys "oa" 'helm-projectile-ag) ;; SPC o a - grep content in a project
;; (spacemacs/set-leader-keys "oo" 'ido-find-file);; SPC o o 
;; (spacemacs/set-leader-keys "oi" 'yas-insert-snippet); SPC o i
;; other modes
;; (defun pcao/init-scala-mode2 ()
;;   (use-package scala-mode2
;;     :config
;;     (progn

;;       ;; (defun my/sbt-send-current-line ()
;;       ;;   "Insert text of current line in eshell and execute."
;;       ;;   (interactive)
;;       ;;   (sbt-send-region
;;       ;;    (save-excursion
;;       ;;      (beginning-of-line)
;;       ;;      (point))
;;       ;;    (save-excursion
;;       ;;      (end-of-line)
;;       ;;      (point))
;;       ;;    )
;;       ;;   (evil-next-visual-line)
;;       ;;   )
;;       ;; (defun my/sbt-send-region (start end)
;;       ;;   (interactive "r")
;;       ;;   (sbt-send-region start end)
;;       ;;   (evil-normal-state)
;;       ;;   )
;;       (evil-define-key 'normal scala-mode-map ",l" 'my/turnip-send-line)
;;       (evil-define-key 'normal scala-mode-map ",L" 'my/turnip-send-buffer)
;;       (evil-define-key 'visual scala-mode-map ",l" 'my/turnip-send-region)
;;       (evil-define-key 'normal scala-mode-map (kbd "<f5>") 'quickrun)
;;       )
;;     )
;;   )

;; (defun pcao/init-python ()
;;   (use-package python
;;     :config
;;     (progn
;;       (evil-define-key 'normal python-mode-map ",l" 'my/turnip-send-line)
;;       (evil-define-key 'normal python-mode-map ",L" 'python/turnip-send-buffer)
;;       (evil-define-key 'visual python-mode-map ",l" 'python/turnip-send-region)
;;       (setq python-shell-interpreter "ipython3")
;;       )
;;     :init
;;     (add-hook 'python-mode-hook (lambda ()
;;                                   ;; (require 'flymake-mode)
;;                                   ;; (flymake-mode nil)
;;                                   (require 'flycheck-mode)
;;                                   (flycheck-mode nil)
;;                                   (require 'anaconda-mode)
;;                                   (anaconda-mode nil)
;;                                   (message "python mode hook")
;;                                   ))
;;     (evil-define-key 'normal python-mode-map ",l" 'my/turnip-send-line)
;;     (evil-define-key 'normal python-mode-map ",L" 'python/turnip-send-buffer)
;;     (evil-define-key 'visual python-mode-map ",l" 'python/turnip-send-region)
;;     (setq python-shell-interpreter "ipython3")
;;     )
;;   )


(defun pcao/init-turnip()
  "Initialize my package"
  (use-package turnip
    :init
    :config
    (progn
      (setq turnip:last-pane "right")
      )
    )
  )

(defun pcao/init-sphinx-doc()
  "Initialize my package"
  (use-package sphinx-doc
    :init
    (add-hook 'python-mode-hook (lambda ()
                                  (require 'sphinx-doc)
                                  (sphinx-doc-mode t)))
    )
  )

(defun pcao/init-stock-ticker()
  "Initialize my package"
  (use-package stock-ticker
    :init
    ;; (stock-ticker-global-mode +1)
    :config
    (setq stock-ticker-update-interval 5)
    (setq stock-ticker-display-interval 2)
    (setq stock-ticker-symbols '("^gspc"))
    )
  )


;; (defun pcao/init-pbcopy()
;;   "Initialize my package"
;;   (use-package pbcopy
;;     :init
;;     (turn-on-pbcopy)
;;     )
;;   )

;; (defun pcao/init-persp-mode ()
;;   "Initialize my package"
;;   (use-package persp-mode
;;     :init
;;     (setq persp-auto-save-num-of-backups 0)
;;     (setq persp-auto-resume-time -1)
;;     (setq persp-auto-save-opt 0)
;;     (setq wg-morph-on nil) ;; switch off animation
;;     (evil-leader/set-key "os" 'persp-switch)
;;     :config
;;     (persp-mode 1)
;;     )
;;   )

(defun pcao/init-smart-mode-line ()
  (use-package smart-mode-line
    :init
    (message "sml---")
    (setq sml/no-confirm-load-theme t)
    (setq sml/theme 'respectful)
    (sml/setup) ;; => run after load
    )
)

;; (defun pcao/init-projectile ()
;;   (use-package projectile
;;     :config
;;     (add-to-list 'projectile-globally-ignored-files "*.png")
;;     ;; (message "sml---")
;;     ;; (setq sml/no-confirm-load-theme t)
;;     ;; (setq sml/theme 'respectful)
;;     ;; (sml/setup) ;; => run after load
;;     )
;;   )

;; (defun pcao/init-org()

;;   (use-package org
;;     :init
;;     (progn
;;       (setq org-confirm-babel-evaluate nil)
;;       (setq org-src-fontify-natively t)
;;       (setq org-startup-folded nil)
;;       ;; ident
;;       (setq org-src-tab-acts-natively t)
;;       ;; (setq org-src-preserve-indentation t)
;;       ;; (setq org-edit-src-content-indentation t)

;;       (org-babel-do-load-languages
;;        'org-babel-load-languages
;;        '(
;;          (awk . t)
;;          (emacs-lisp . t)
;;          (dot . t)
;;          (css . t)
;;          (gnuplot . t)
;;          (js . t)
;;          (latex . t)
;;          (makefile . t)
;;          (matlab . t)
;;          (octave . t)
;;          (ruby . t)
;;          (sh . t)
;;          (sqlite . t)
;;          (clojure . t)
;;          (python . t)
;;          (java . t)
;;          (scala . t)
;;          (sql . t)
;;          (C . t)
;;          (R . t)
;;          )
;;        )
;;       )
;;     )
;;   )


;;;;;;;;;;;
;; hooks ;;
;;;;;;;;;;;

(eval-after-load 'python
  '(progn
     (add-hook 'inferior-python-mode-hook '(lambda ()
                                             (define-key inferior-python-mode-map (kbd "<down>") 'comint-next-input)
                                             (define-key inferior-python-mode-map (kbd "<up>") 'comint-previous-input)
                                             ;; (define-key inferior-python-mode-map (kbd "C-j") 'windmove-down)
                                             ;; (define-key inferior-python-mode-map (kbd "C-h") 'windmove-left)
                                             ;; (define-key inferior-python-mode-map (kbd "C-k") 'windmove-up)
                                             ;; (define-key inferior-python-mode-map (kbd "C-l") 'windmove-right)
                                             ))
     )
  )

(eval-after-load 'helm
  '(progn
     (add-hook 'helm-mode-hook '(lambda ()
                                  (define-key helm-map (kbd "C-u") 'helm-previous-page)
                                  (define-key helm-map (kbd "C-d") 'helm-next-page)
                                  ))
     ;; (require 'helm-files)
     ;; (setq helm-idle-delay 0.1)
     ;; (setq helm-input-idle-delay 0.1)
     ;; (setq helm-locate-command "mdfind -name %.0s %s")
     ;; (loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$")
     ;;       do (add-to-list 'helm-boring-file-regexp-list ext))
     ;; )
  )
)


;;;;;;;;;;;;;;;;;;
;; key bindings ;;
;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f5>") 'run-current-file)
(global-set-key (kbd "<f6>") 'clean-current-project)
(global-set-key (kbd "<f7>") 'compile)
(global-set-key (kbd "<f8>") 'my-recompile)
(global-set-key (kbd "<f9>") 'projectile-test-project)

;; projectile
(setq projectile-test-cmd "make test")

;; quotes
;; (define-key evil-normal-state-map "e" 'q)

;; windows
;; (define-key evil-normal-state-map "q" 'delete-window)
;; (define-key evil-visual-state-map "q" 'delete-window)
;; (define-key evil-normal-state-map (kbd "C-\\") 'split-window-right)
;; (define-key evil-normal-state-map (kbd "C-\_") 'split-window-below)
;; (define-key evil-normal-state-map "-" 'delete-other-windows)

;; disable ESC-k kill-sentence
;; (define-key evil-normal-state-map [remap kill-sentence] 'keyboard-quit)

;; most frequent used keys
;; (define-key evil-normal-state-map ",i" 'yas-insert-snippet)
;; (define-key evil-normal-state-map ",n" 'helm-deft)
;; (define-key evil-normal-state-map "`" 'helm-occur)
;; (define-key evil-normal-state-map ",o" 'ido-find-file)
;; (define-key evil-normal-state-map ",a" 'helm-M-x)
;; (define-key evil-visual-state-map ",a" 'helm-M-x)
;; (define-key evil-normal-state-map ",w" 'save-buffer)
;; (define-key evil-normal-state-map ",," 'evil-buffer)
;; (define-key evil-visual-state-map ",cc" 'comment-dwim)
;; (define-key evil-visual-state-map ",cb" 'comment-box)
;; (define-key evil-normal-state-map ",l" 'eval-buffer)
;; (define-key evil-normal-state-map ",t" 'reload-theme)
;; (define-key evil-normal-state-map ",ee" 'pcao/edit-dot-packages) ;
;; (define-key evil-normal-state-map ",es" 'pcao/edit-dot-spacemacs)
;; (define-key evil-normal-state-map ",eo" 'pcao/edit-dot-emacs)
;; (define-key evil-normal-state-map ",f" 'helm-mini);
;; (define-key evil-normal-state-map ",F" 'helm-semantic-or-imenu);
;; (define-key evil-normal-state-map ",b" 'helm-mini);
;; (define-key evil-normal-state-map ",B" 'helm-projectile-find-file);
;; (define-key evil-normal-state-map ",c" 'whitespace-cleanup);
;; (define-key evil-normal-state-map "?" 'spacemacs/helm-project-smart-do-search)
;; (define-key evil-visual-state-map ",x" 'evil-delete-and-yank)


(define-key evil-normal-state-map (kbd "C-h") 'windmove-left);
(define-key evil-normal-state-map (kbd "C-j") 'windmove-down);
(define-key evil-normal-state-map (kbd "C-k") 'windmove-up);
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right);

(global-set-key (kbd "C-j") 'windmove-down)
(global-set-key (kbd "C-k") 'windmove-up)
(global-set-key (kbd "C-h") 'windmove-left)
(global-set-key (kbd "C-l") 'windmove-right)
(define-key evil-normal-state-map "q" 'delete-window)
(define-key evil-normal-state-map (kbd "C-\\") 'split-window-right)
(define-key evil-normal-state-map (kbd "C-\_") 'split-window-below)

;; evil exit insert mode using jk or jj
;; (evil-define-command pcao/evil-maybe-exit ()
;;   :repeat change
;;   (interactive)
;;   (let ((modified (buffer-modified-p))
;;         (entry-key ?j)
;;         (exit-key ?j))
;;     (insert entry-key)
;;     (let ((evt (read-event (format "Insert %c to exit insert state" exit-key) nil 0.5)))
;;       (cond
;;        ((null evt) (message ""))
;;        ((and (integerp evt) (char-equal evt exit-key))
;;         (delete-char -1)
;;         (set-buffer-modified-p modified)
;;         (push 'escape unread-command-events))
;;        (t (push evt unread-command-events))))))

;; (define-key evil-insert-state-map "j" 'pcao/evil-maybe-exit)

;; (set-face-background 'default "color-8")

(message "--pcao packages")
