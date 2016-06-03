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

;; helm
(setq locate-command "mdfind")
(setq helm-locate-fuzzy-match nil)
(setq helm-c-locate-command
      (case system-type
        ('gnu/linux "locate -i -r %s")
        ('berkeley-unix "locate -i %s")
        ('windows-nt "es %s")
        ;; ('darwin "mdfind -name %s")
        ('darwin "mdfind -name %s %s")
        (t "locate %s"))
)



;; (set-face-background 'default "#1c1c1c")
;; (set-face-foreground 'default "#8a8a8a")
;; (set-face-background 'region "#8a8a8a")
;; (set-face-foreground 'region "#1c1c1c")
;; ;; (set-face-background 'hl-line "#362626")
;; (set-face-foreground 'linum "#565656") ;; note: global-linum-mode must be enabled
;; (set-face-background 'linum "#262626") ;; note: global-linum-mode must be enabled
;; (set-face-foreground 'font-lock-comment-face "#585858")
;; (set-face-foreground 'font-lock-comment-delimiter-face "#585858")
;; (set-face-attribute 'mode-line-inactive nil
;;                     :background "#8a8a8a"
;;                     :foreground "#262626"
;;                     :box nil)

;; (set-face-attribute 'mode-line nil
;;                     :background "gray"
;;                     :foreground "#262626"
;;                     :box nil)

;; colorful code http://amitp.blogspot.com/2014/04/emacs-rainbow-identifiers.html
(setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face
      rainbow-identifiers-cie-l*a*b*-lightness 64
      rainbow-identifiers-cie-l*a*b*-saturation 64
      rainbow-identifiers-cie-l*a*b*-color-count 8)

;; hide sticky function at the beginning of the file
;; https://www.gnu.org/software/emacs/manual/html_node/semantic/Sticky-Func-Mode.html

;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; editor behaviors ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(setq save-place-file "~/.cache/saveplace")
(setq-default save-place t)

;; compilation auto hide
;; (setq compilation-scroll-output 'first-error)
(setq compilation-scroll-output t)

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))


;; erc
(defun notify-via-message (title body)
  "Notify TITLE, BODY with a simple message."
  (message "%s: %s" title body))

(setq notify-method 'notify-via-message)
(setq erc-auto-reconnect nil)
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK" "MODE"))
(setq erc-rename-buffers t)
;; The following are commented out by default, but users of other
;; non-Emacs IRC clients might find them useful.
;; Kill buffers for channels after /part
(setq erc-kill-buffer-on-part t)
;; Kill buffers for private queries after quitting the server
(setq erc-kill-queries-on-quit t)
;; Kill buffers for server messages after quitting the server
(setq erc-kill-server-buffer-on-quit t)
(setq erc-interpret-mirc-color t)
(setq erc-echo-timestamps t)
(setq erc-join-buffer 'bury)
(setq erc-prompt-for-password nil)
(setq erc-prompt-for-nickserv-password nil)
(setq erc-minibuffer-notice nil)
(setq erc-reuse-buffers nil)
(setq erc-prompt-for-password nil)
(setq erc-reuse-buffers nil)
(setq erc-part-reason 'erc-part-reason-various)
(setq erc-quit-reason 'erc-quit-reason-various)

;; (setq erc-hide-timestamps t)
;; open query buffers in the current window
(setq erc-query-display 'buffer)

(remove-hook 'erc-text-matched-hook 'erc-global-notify)

(add-hook 'erc-mode-hook
          '(lambda ()
             (evil-force-normal-state)
             (auto-fill-mode 0)
             )
          )

(setq erc-autojoin-channels-alist
      '(("bitlbee" "#etic" "#chit_chat")))

;;(add-to-list 'projectile-globally-ignored-files ".ensime*")

;; https://github.com/xiaohanyu/oh-my-emacs/blob/master/core/ome-org.org
(setq org-src-preserve-indentation t)
(setq org-src-tab-acts-natively t)
(setq org-src-fontify-natively t)
;; (setq org-src-window-setup (quote current-window))
(setq org-edit-src-auto-save-idle-delay 5)
(setq org-edit-src-content-indentation t)


(add-hook 'org-src-mode-hook
          (lambda ()
            (make-local-variable 'evil-ex-commands)
            (setq evil-ex-commands (copy-list evil-ex-commands))
            (evil-ex-define-cmd "w[rite]" 'org-edit-src-save)
            (evil-ex-define-cmd "q[quit]" 'org-edit-src-exit)
            (evil-define-key 'normal org-src-mode-map "q" 'org-edit-src-exit)
            ))


(add-hook 'org-mode-hook
          (lambda ()
            (evil-define-key 'normal org-mode-map "e" 'org-edit-src-code)
            ))

;; smart mode line
(message "pcao configs")
