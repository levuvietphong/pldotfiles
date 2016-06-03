;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; Visual settings ;; ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-hl-line-mode)
(global-linum-mode)
(setq linum-format "%d ")
(setq column-number-mode t)

;; theme
;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background nil)
;; Don't change the font for some headings and titles
(setq solarized-use-variable-pitch nil)
;; make the modeline high contrast
(setq solarized-high-contrast-mode-line nil)
;; Use less bolding
(setq solarized-use-less-bold t)
;; Use less colors for indicators such as git:gutter, flycheck and similar
(setq solarized-emphasize-indicators nil)
(setq x-underline-at-descent-line nil)

;; key binding


(spacemacs/set-leader-keys "oc" 'comment-box)
(spacemacs/set-leader-keys "oa" 'helm-projectile-ag)
(spacemacs/set-leader-keys "os" 'ple/edit-dot-spacemacs)
(spacemacs/set-leader-keys "op" 'ple/edit-dot-packages)
(spacemacs/set-leader-keys "oo" 'ido-find-file)

;; smart mode line
(message "ple configs")

(set-face-foreground 'font-lock-function-name-face "pink")

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


