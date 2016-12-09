;; Copyright 2016, by Steffen Fiedler

;; Author: Steffen Fiedler, mail near steffenfiedler com
;; Created: 27 Nov 2016

;; This file is not part of GNU Emacs.

;; create the list for font-lock.
(setq doxlight-font-lock-keywords
      `(;; Match single commands without parameters or meta `@page`
        (,"\\([@\\\\]\\(endhtmlonly\\|htmlonly\\|ingroup\\|internal\\|mainpage\\|name\\|note\\|page\\|paragraph\\|todo\\)\\)[[:space:]]" . font-lock-keyword-face)
        ;; Match document-referencing commands followed by file name `@example foo.c`
        (,"\\([@\\\\]\\(example\\|snippet\\)\\)[[:space:]]+\\([A-Za-z0-9_-\.]+\\)*"
         (1 font-lock-keyword-face)
         (3 font-lock-constant-face))
        ;; Match commands followed by a label `@section label_token`
        (,(concat "\\([@\\\\]\\(addtogroup\\|image\\|section\\|subsection\\)\\)"
                  ;; One or more whitespaces
                  "[[:space:]]+"
                  ;; Match label token
                  "\\([A-Z-a-z0-9_-]+\\)")
         (1 font-lock-keyword-face)
         (3 font-lock-function-name-face))
        ;; Match commands followed by label and string in quotation marks `@ref label_token "caption string"`
        (,(concat "\\([@\\\\]\\(\\defgroup\\|ref\\|subpage\\)\\)"
                  ;; One or more whitespaces
                  "[[:space:]]+"
                  ;; Match label token
                  "\\([A-Z-a-z0-9_-]+\\)"
                  ;; One or more whitespaces
                  "[[:space:]]+"
                  ;; Optional caption `"bold terms"`
                  "\\(\"\\(\\(?:[^\"\\]+\\|\\\\\\(?:.\\|\\)\\)*\\)\"\\)*")
         (1 font-lock-keyword-face)
         (3 font-lock-function-name-face)
         (4 font-lock-string-face nil t))))

(define-derived-mode doxlight-mode text-mode "doxlight"
  "Major mode for editing doxygen files."
  (setq font-lock-defaults '(doxlight-font-lock-keywords)))

;; Autoload
(add-to-list 'auto-mode-alist '("\\.dox\\'" . doxlight-mode))

(provide 'doxlight-mode)
