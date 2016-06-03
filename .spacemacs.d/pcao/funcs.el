(defun pcao/edit-dot-spacemacs ()
  (interactive)
  (find-file "~/.spacemacs.d/init.el"))

(defun pcao/edit-dot-emacs ()
  (interactive)
  (find-file "~/.emacs.d.bak/init.el"))

(defun pcao/edit-dot-packages()
  (interactive)
  (find-file "~/.spacemacs.d/pcao/packages.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make/test current project ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun test-current-project()
  (interactive)
  (setq compile-command "make test")
  (recompile)
  )

(defun make-current-project()
  (interactive)
  (setq compile-command "make run")
  (recompile)
  )

(defun clean-current-project()
  (interactive)
  (setq compile-command "make clean")
  (recompile)
  )

(defun my-recompile ()
  "Run compile and resize the compile window closing the old one if necessary"
  (interactive)
  (progn
    (if (get-buffer "*compilation*") ; If old compile window exists
        (progn
          (delete-windows-on (get-buffer "*compilation*")) ; Delete the compilation windows
          (kill-buffer "*compilation*") ; and kill the buffers
          )
      )
    (call-interactively 'recompile)
    (enlarge-window 15)
    ;;     (setq cur (selected-window))
    ;; (setq w (get-buffer-window "*compilation*"))
    ;; (select-window w)
    ;; (setq h (window-height w))
    ;; (shrink-window (- h 10))
    ;; (select-window cur)
    )
  )

(defun my-compilation-hook ()
  "Make sure that the compile window is splitting vertically"
  (progn
    (if (not (get-buffer-window "*compilation*"))
        (progn
          (split-window-vertically)
          )
      )
    )
  )

;; (add-hook 'compilation-mode-hook 'my-compilation-hook)

(defun bury-compile-buffer-if-successful (buffer string)
  (interactive)
  (switch-to-buffer-other-window "*compilation*")
  "Bury a compilation buffer if succeeded without warnings "
  ;; (if (and
  ;;      (string-match "compilation" (buffer-name buffer))
  ;;      (string-match "finished" string)
  ;;      (not
  ;;       (with-current-buffer buffer
  ;;        (goto-char (point-max))
  ;;        (search-backward "-warning-" nil t)
  ;;   )))
  ;;     (run-with-timer 1 nil
  ;;                     (lambda (buf)
  ;;                       (bury-buffer buf)
  ;;                           (delete-window (get-buffer-window buf)))
  ;;                     buffer))
  )
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)
;; http://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))

  ;; mocha seems to output some non-standard control characters that
  ;; aren't recognized by ansi-color-apply-on-region, so we'll
  ;; manually convert these into the newlines they should be.
  (goto-char (point-min))
  (while (re-search-forward "\\[2K\\[0G" nil t)
    (progn
      (replace-match "
")))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(defun run-current-file ()
  "Execute or compile the current file.
For example, if the current buffer is the file x.pl,
then it'll call “perl x.pl” in a shell.
The file can be php, perl, python, ruby, javascript, bash, ocaml, vb, elisp.
File suffix is used to determine what program to run.
If the file is modified, ask if you want to save first. (This command always run the saved version.)
If the file is emacs lisp, run the byte compiled version if exist."
  (interactive)
  (save-buffer)
  (let (suffixMap fName fSuffix progName cmdStr)

    ;; a keyed list of file suffix to comand-line program path/name
    (setq suffixMap
          '(
            ("php" . "php")
            ("pl" . "perl")
            ("py" . "python3")
            ("rb" . "ruby")
            ("js" . "node")             ; node.js
            ;; ("java" . "$HOME/.local/scripts/run-java-file")             ; node.js
            ("java" . "jl")             ; node.js
            ("scala" . "$HOME/.local/scripts/run-scala-file")             ; node.js
            ("sh" . "bash")
            ("ml" . "ocaml")
            ("vbs" . "cscript")
            ("tex" . "pdflatex"); view last 5 lines of output
            ("md" . ""); markdown
            )
          )

    (setq fName (buffer-file-name))
    (setq fSuffix (file-name-extension fName))
    (setq progName (cdr (assoc fSuffix suffixMap)))
    (setq cmdStr (concat progName " \""   fName "\""))

    (when (buffer-modified-p)
      (progn
        (when (y-or-n-p "Buffer modified. Do you want to save first?")
          (save-buffer) ) ) )

    ;; output last 10 lines of tex
    (if (string-equal fSuffix "java") ; special case for emacs lisp
        (setq cmdStr (concat progName " \"" buffer-file-name "\""))
      )

    ;; output last 10 lines of tex
    (if (string-equal fSuffix "tex") ; special case for emacs lisp
        (setq cmdStr (concat progName " \""   fName "\"" " | tail -n 10"))
      )

    ;; preview markdown as pdf
    (if (string-equal fSuffix "md") ; special case for emacs lisp
        (setq cmdStr (concat progName "/usr/local/bin/pandoc -s \""   fName "\" -o \"" fName ".tex\" && pdflatex \"" fName ".tex\" | tail -n 10 && open \"" fName ".pdf\""))
      )

    (if (string-equal fSuffix "el") ; special case for emacs lisp
        (progn
          (load (file-name-sans-extension fName))
          )
      (if progName
          (progn
            (message "Running %s ..." buffer-file-name)
            (shell-command cmdStr "*compilation*" )
            )
        (message "No recognized program file suffix for this file.")
        )
      )
    ))


;;;;;;;;;;;;;;;;;;
;; ;; EVIL HACK ;;
;;;;;;;;;;;;;;;;;;
;; Do not copy deleted text to the yank handler/buffer
(evil-define-operator evil-delete (beg end type register yank-handler)
  "Delete text from BEG to END with TYPE.
Save in REGISTER or in the kill-ring with YANK-HANDLER."
  (interactive "<R><x><y>")
  (if (eq type 'block)
      (evil-apply-on-block #'delete-region beg end)
    (delete-region beg end))
  ;; place cursor on beginning of line
  (when (and (evil-called-interactively-p)
             (eq type 'line))
    (evil-first-non-blank)))

;; evil delete and yank
(evil-define-operator evil-delete-and-yank (beg end type register yank-handler)
  "Delete text from BEG to END with TYPE.
Save in REGISTER or in the kill-ring with YANK-HANDLER."
  (interactive "<R><x><y>")
  (unless register
    (let ((text (filter-buffer-substring beg end)))
      (unless (string-match-p "\n" text)
        ;; set the small delete register
        (evil-set-register ?- text))))
  (let ((evil-was-yanked-without-register nil))
    (evil-yank beg end type register yank-handler))
  (cond
   ((eq type 'block)
    (evil-apply-on-block #'delete-region beg end nil))
   ((and (eq type 'line)
         (= end (point-max))
         (or (= beg end)
             (/= (char-before end) ?\n))
         (/= beg (point-min))
         (=  (char-before beg) ?\n))
    (delete-region (1- beg) end))
   (t
    (delete-region beg end)))
  ;; place cursor on beginning of line
  (when (and (evil-called-interactively-p)
             (eq type 'line))
    (evil-first-non-blank)))


;; irc
(defun bitlbee()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "Bitlbee") ;; ERC already active?

      (erc-track-switch-buffer 1) ;; yes: switch to last active
    ;; (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC

    (erc-tls
     :server "localhost"
     :port "6666"
     ;; :password (concat "pmcao/bitlbee:" (password-store-get "thelonereaper")))
     ;; TODO: this is a security risk
     :password "pmcao/bitlbee:$@T!eF4kqr2q")
    )
)


(defun znc()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "#everytimeicash") ;; ERC already active?

      (erc-track-switch-buffer 1) ;; yes: switch to last active
    ;; (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC

    (erc-tls
     :server "localhost"
     :port "6666"
     ;; :password (concat "pmcao/bitlbee:" (password-store-get "thelonereaper")))
     ;; TODO: this is a security risk
     :password "mark/slack:$@T!eF4kqr2q")
    )
  )

(defun filter-server-buffers ()
  (delq nil
        (mapcar
         (lambda (x) (and (erc-server-buffer-p x) x))
         (buffer-list))))

(defun stop-irc ()
  "Disconnects from all irc servers"
  (interactive)
  (dolist (buffer (filter-server-buffers))
    (message "Server buffer: %s" (buffer-name buffer))
    (with-current-buffer buffer
      (erc-quit-server "Asta la vista"))))

;; (defun freenode()
;;   "Connect to ERC, or switch to last active buffer"
;;   (interactive)
;;   (if (get-buffer "localhost:6666") ;; ERC already active?

;;       (erc-track-switch-buffer 1) ;; yes: switch to last active
;;     ;; (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC

;;     (erc-tls
;;      :server "localhost"
;;      :port "6666"
;;      :nick "thelonereaper"
;;      :full-name "Phuong Cao"
;;      :password (concat "thelonereaper/freenode:" (password-store-get "thelonereaper")))
;;     ))

;; (defun reload-theme()
;;   (interactive)
;;   (eval-buffer)
;;   (load-theme 'solarized-dark t)
;;   (setq sml/no-confirm-load-theme t)
;;   (setq sml/theme 'pcao)
;;   (sml/setup)
;;   )


(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))

(defun my/turnip-send-line()
  "Send current line to the last tmux pane."
  (interactive)
  (turnip-send-region
   (save-excursion
     (beginning-of-line)
     (point)
     )
   (save-excursion
     (beginning-of-line 2)
     (point)
     )
   turnip:last-pane
   ;; "right"
   )
  (evil-next-visual-line)
  ;; (message "sent")
  )

(defun my/turnip-send-region(start end)
  (interactive "r")
  (turnip-send-region
   start
   end
   turnip:last-pane
   ;; "right"
   )
  (evil-next-visual-line)
  (evil-escape)
  )

(defun my/turnip-send-buffer()
  (interactive)
  (turnip-send-region
   (save-excursion
     (point-min)
     )
   (save-excursion
     (point-max)
     )
   turnip:last-pane
   ;; "right"
   )
  (evil-next-visual-line)
  )

(defun python/turnip-send-region()
  (interactive)
  (call-interactively 'evil-yank)
  ;; (turnip:send-text  turnip:last-pane)
  ;; (evil-next-visual-line)
  (turnip:send-text
   turnip:last-pane
   ;; "right"
   "%paste\n")
  (evil-next-visual-line)
  ;; (message "setn")
  )

(defun python/turnip-send-buffer()
  (interactive)
  (call-interactively 'spacemacs/copy-whole-buffer-to-clipboard)
  ;; (turnip:send-text  turnip:last-pane)
  ;; (evil-next-visual-line)
  (turnip:send-text
   turnip:last-pane
   ;; "right"
   "%paste\n")
  (evil-next-visual-line)
  ;; (message "setn")
  )

(defun q (x)
  "inline doc string"
  (interactive "sEnter ticker's name: ")
  (shell-command (format "q %s" x))
)

(defun tide/init-typescript-mode ()
  (interactive)
  (setq compilation-read-command nil)
  (let ((tsc "path/to/tsc")
        (tsconfig-path (tide/find-tsconfig.json)))
    (set (make-local-variable 'compile-command)
         (progn
           (format "%s --target es5 --project \"%s\""
                   tsc
                   tsconfig-path)))
    (message compile-command)))


(message "--pcao func")

