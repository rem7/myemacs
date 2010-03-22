(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")


;; disable bell function
(setq ring-bell-function 'ignore)

(require 'paredit)
(require 'highlight-parentheses)
(paredit-mode)
(highlight-parentheses-mode)



;; Clojure Mode
(add-to-list 'load-path "~/.emacs.d/clojure-mode")
(require 'clojure-mode)

;; Swank-clojure
(add-to-list 'load-path "~/.emacs.d/swank-clojure")

(setq swank-clojure-extra-classpaths '("~/.emacs.d/swank-clojure/src/swank"
				       "~/Dropbox/Books/Clojure/programming-clojure/lib/clojure-contrib.jar"))

(require 'swank-clojure-autoload)


;; Slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

(add-to-list 'load-path "~/.emacs.d/slime")
(require 'slime)
(slime-setup)



;;;; VISUAL SETTINGS ;;;;;;;

(setq mac-allow-anti-aliasing t)

; rainbown parenthesis
(setq hl-paren-colors
      '( "cyan1" "orange1" "yellow1" "greenyellow" "green1"
        "springgreen1" "slateblue1" "magenta1" "purple"))


;; disable toolbar
(tool-bar-mode -1)

;; disable splash screenX
(custom-set-variables '(inhibit-startup-screen t))

;; current buffer name in title bar
(setq frame-title-format "%b")

(custom-set-faces
'(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" 
			 :inverse-video nil :box nil :strike-through nil 
			 :overline nil :underline nil :slant normal :weight normal 
			 :height 128 :width normal :foundry "unknown" :antialias none
			 :family "Monaco")))))

(defun color-theme-dark-bliss ()
  ""
  (interactive)
  (color-theme-install
   '(color-theme-dark-bliss
     ((foreground-color . "#eeeeee")
      (background-color . "#001122")
      (background-mode . dark)
      (cursor-color . "#ccffcc"))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (default ((t (nil))))

     (font-lock-builtin-face ((t (:foreground "#f0f0aa"))))
     (font-lock-comment-face ((t (:bold t :foreground "#aaccaa"))))
     (font-lock-delimiter-face ((t (:foreground "#aaccaa"))))
     (font-lock-constant-face ((t (:bold t :foreground "#ffaa88"))))
     (font-lock-doc-string-face ((t (:foreground "#eeccaa"))))
     (font-lock-doc-face ((t (:foreground "#eeccaa"))))
     (font-lock-reference-face ((t (:foreground "#aa99cc"))))
     (font-lock-function-name-face ((t (:foreground "#ffbb66"))))
     (font-lock-keyword-face ((t (:foreground "#ccffaa"))))
     (font-lock-preprocessor-face ((t (:foreground "#aaffee"))))
     (font-lock-string-face ((t (:foreground "#bbbbff")))))))


;; transparency? 
(defun transparency-set-initial-value ()
  "Set initial value of alpha parameter for the current frame"
  (interactive)
  (if (equal (frame-parameter nil 'alpha) nil)
      (set-frame-parameter nil 'alpha 100)))

(defun transparency-set-value (numb)
  "Set level of transparency for the current frame"
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value for transparency is 100!")
    (if (< numb 0)
	(message "Error! The minimum value for transparency is 0!")
      (set-frame-parameter nil 'alpha numb))))

(defun transparency-increase ()
  "Increase level of transparency for the current frame"
  (interactive)
  (transparency-set-initial-value)
   (if (> (frame-parameter nil 'alpha) 0)
       (set-frame-parameter nil 'alpha (+ (frame-parameter nil 'alpha) -2))
     (message "This is a minimum value of transparency!")))

(defun transparency-decrease ()
  "Decrease level of transparency for the current frame"
  (interactive)
  (transparency-set-initial-value)
  (if (< (frame-parameter nil 'alpha) 100)
      (set-frame-parameter nil 'alpha (+ (frame-parameter nil 'alpha) +2))
    (message "This is a minimum value of transparency!")))

;; sample keybinding for transparency manipulation
(global-set-key (kbd "C-?") 'transparency-set-value)
;; the two below let for smooth transparency control
(global-set-key (kbd "C->") 'transparency-increase)
(global-set-key (kbd "C-<") 'transparency-decrease)

(setq transparency-level 90)
(set-frame-parameter nil 'alpha transparency-level)
(add-hook 'after-make-frame-functions (lambda (selected-frame) (set-frame-parameter selected-frame 'alpha transparency-level)))

(require 'color-theme)
(load-file "~/.emacs.d/ir_black.el")
(eval-after-load "color-theme" '(progn (color-theme-dark-bliss) ) )
(require 'linum)
(linum-mode)

