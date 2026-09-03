
;;; Make the mode line a little more useful.
(make-variable-buffer-local 'nv-percent)
(setq-default nv-percent "")
(setq-default mode-line-format
	      '(" %* %[%b [%p]%] " global-mode-string "(" mode-name
	        minor-mode-alist "%n" mode-line-process nv-percent ") F: %f"))
(setq display-time-day-and-date t)


;;; When in Text mode, want to be in Auto-Fill mode.
;;;
;; (load "outline")

(defun my-auto-fill-mode nil 
   (auto-fill-mode 1)  
   (setq outline-regexp "\\\\\\(sub\\)*section"))
(setq text-mode-hook 'my-auto-fill-mode)
(setq mail-mode-hook 'my-auto-fill-mode)
(setq TeX-mode-hook  'my-auto-fill-mode)


;;; If auto-mode-alist can't determine what mode the latest file
;;; needs, the default should be text-mode...
;;; Uncomment this is you want the default to be text mode 
;;; instead of fundamental.

(setq default-major-mode 'text-mode)


;;; Display time and load averages on the mode line.  (Used with the setting
;;; of the mode line above.)
(load "time" t t)
(display-time)



;;;   Tex stuff


(defun del-whole-word()
  (interactive)
  (if (not (looking-at "[a-zA-Z]"))
      (kill-word 1)
    (forward-word 1)
    (forward-word -1)
    (kill-word 1)))
(define-key esc-map "d" 'del-whole-word)

(fset 't
   "}øisearch-backward-regexp
\\s-{\\tt }")
(define-key esc-map "T" 't)

(fset 'dollarize
   "$øisearch-backward-regexp
\\s-\\|
$$")

(fset 'emphasize
   "}øisearch-backward-regexp
\\s-\\|
{\\em }")

(fset 'boldize
   "}øisearch-backward-regexp
\\s-\\|
{\\bf }")

(define-key esc-map "m" 'dollarize)
(define-key esc-map "e" 'emphasize)
(define-key esc-map "B" 'boldize)
(define-key esc-map "i" "\\item {\\bf } ")
(fset 'verbize
   "?øisearch-backward-regexp
\\s-\\verb??")

(fset 'ver "\\parbox{1in}{\\begin{verbatim}

\\end{verbatim}}")

; (define-key esc-map "p" 'ver)

(define-key esc-map "V" 'verbize)

(fset 'del-line "")
(define-key esc-map "D" 'del-line)



(setq auto-save-interval 1000)

(defvar dl-count 0)

(defun reset-count(arg)
  (interactive "p")
  (setq dl-count (- arg 1)))

(defun use-count()
  (interactive)
  (setq dl-count (+ 1 dl-count))
  (insert (format "%s" dl-count)))

(setq TeX-directory "."    ; use the local directory
      TeX-zap-file "#zap") ; and call the temp file #zap.tex

(setq auto-mode-alist (cons '("\\.txt$" . text-mode) auto-mode-alist))


(global-set-key "" 'goto-line)




(define-key esc-map "%" 'query-replace-regexp)


(defun disabled-command-hook () (beep) ())

(defun yes-or-no-p(A) (y-or-n-p A))


;;;(global-set-key "s" 'tags-search)

(defun my-exit-from-emacs ()
  (interactive)
  (if (yes-or-no-p "Do you want to exit ")
      (save-buffers-kill-emacs)))

(global-set-key "\C-x\C-c" 'my-exit-from-emacs)

(display-time)

(defun scroll-up-one-line()
  (interactive)
  (scroll-up 2)
)
(defun scroll-down-one-line()
  (interactive)
  (scroll-up -2)
)

(global-set-key "o" 'scroll-up-one-line)
(global-set-key "p" 'scroll-down-one-line)


(defun comment-statement()
    (interactive)
    (beginning-of-line)
    (if (looking-at " *[0-9]+ *")
	(let* ((a (buffer-substring (point) (+ (point) 6))))
	  (insert a)
	  (insert "continue\n")))
    (set-mark (point))
    (next-line 1)
    (while (looking-at "     [^ ]") (next-line 1))
    (fortran-comment-region (region-beginning) (region-end) ())
    1)

(defun comment-io()
  (interactive)
  (setq fortran-comment-region "c -noio-")
  (setq tags-loop-form
	(list 'and (list 're-search-forward "^[^c].*\\(format\\)\\|\\(write\\)(" () 1)
	      (list 'comment-statement)))
  (tags-loop-continue t)
  (while 1 (tags-loop-continue))
)



(load "/home/public/latexbuttons/command-process.el")
(load "/home/public/latexbuttons/buttons.el")



;;;;;isu olc answers suggests the following to make ispell ignore
;;;;;tex stuff inside the emacs buffer when M-x ispell-buffer
;;;;;
(setq TeX-mode-hook
      '(lambda ()
         (make-local-variable 'ispell-filter-hook)
         (make-local-variable 'ispell-filter-hook-args)
         (setq ispell-filter-hook "detex")
         (setq ispell-filter-hook-args '("-w"))))




;stuff for the David Smith Smode

     (setq load-path (cons (expand-file-name "/home/stat/elisp") load-path))
     (setq truncate-partial-width-windows nil)
     (setq S-pre-run-hook '((lambda () (setq S-directory default-directory))))
     (autoload 'S "S" "Run an inferior S process" t)
     (autoload 's-mode "S" "Mode for editing S source" t)



;;;the following line overrides the emacs default and allows
;;;lines to wrap after splitting the emacs window vertically

(setq truncate-partial-width-windows nil)

;stuff for the David Smith Smode

     (setq load-path (cons (expand-file-name "/home/stat/elisp") load-path))
     (autoload 'S "S" "Run an inferior S process" t)
     (autoload 's-mode "S" "Mode for editing S source" t)
;;;     (setq inferior-S-program "currentS")
;;;the following line should cause S-mode to start in the 
;;;   directory where emacs started
 (setq S-pre-run-hook '((lambda () (setq S-directory default-directory))))
