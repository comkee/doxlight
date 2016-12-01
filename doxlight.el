;; Copyright 2016, by Steffen Fiedler

;; Author: Steffen Fiedler, mail near steffenfiedler com
;; Created: 27 Nov 2016

;; This file is not part of GNU Emacs.

;; doxlight function keywords
(setq doxlight-keywords-token '("code" "endcode" "endhtmlonly" "example" "htmlonly" "image" "include" "link" "mainpage" "name" "note" "page" "paragraph" "ref" "section" "snippet" "subpage" "subsection" "todo"))

;; Prepend doxlight tokens with @ to match
;; complete declaration, not only the name.
(setq doxlight-keywords-token-prepend (mapcar (lambda (k)
                                         (concat "@" k))
                                       doxlight-keywords-token))

;; generate regex string for each category of keywords
(setq doxlight-keywords-regexp (regexp-opt doxlight-keywords-token-prepend t))

;; generate regex string to match label behind doxygen tokens (e.g. ref)
;; >>> FIXME, @ref not highlighted
;; (?<=@ref\s)\w+
(setq doxlight-label-regexp "@ref[[:space:]]+\\([A-Z-a-z0-9_-]+\\)")

;; create the list for font-lock.
;; each category of keyword is given a particular face
(setq doxlight-font-lock-keywords
      `((,doxlight-keywords-regexp . font-lock-function-name-face)
        (,doxlight-label-regexp . font-lock-constant-face)))

(define-derived-mode doxlight-mode text-mode "doxlight"
  "Major mode for editing doxlight files."
  (setq font-lock-defaults '(doxlight-font-lock-keywords)))

;; Autoload
(add-to-list 'auto-mode-alist '("\\.dox\\'" . doxlight-mode))

;; Clear memory
(setq doxlight-keywords-token nil)
(setq doxlight-keywords-token-prepend nil)
(setq doxlight-keywords-regexp nil)
(setq doxlight-label-regexp nil)

(provide 'doxlight-mode)
