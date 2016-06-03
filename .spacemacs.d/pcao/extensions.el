;;; extensions.el --- pcao Layer extensions File for Spacemacs
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

(defvar pcao-pre-extensions
  '(
    ;; pre extension pcaos go here
    )
  "List of all extensions to load before the packages.")

(defvar pcao-post-extensions
  '(
    ;; post extension pcaos go here
    helm-deft
    ;; helm-mdfind
    ;; smart-mode-line-pcao-theme
    )
  "List of all extensions to load after the packages.")

;; For each extension, define a function pcao/init-<extension-pcao>
;;
;; (defun pcao/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

(defun pcao/init-helm-deft ()
 (use-package helm-deft
   )
 )

;;(defun pcao/init-helm-mdfind ()
;;  (use-package helm-mdfind
;;    )
;;  )

;; (defun pcao/init-smart-mode-line-pcao-theme ()
;;   (use-package smart-mode-line-pcao-theme
;;     )
;;   )

(message "pcao extensions")
