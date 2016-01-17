;;; package --- Summary 
;;; commentary:
(require 'cl)
(require 'package)

;;; Code:
(setq cfg-var:packages '(evil
			 powerline
			 powerline-evil
             airline-themes
             evil-leader
             evil-search-highlight-persist
			 flycheck
			 company
			 auctex
			 company-auctex
			 flycheck-ycmd
			 company-ycmd
			 xcscope
			 helm
			 helm-projectile
             helm-cscope
			 smooth-scrolling
             fill-column-indicator
             ;;color-identifiers-mode
             ;;rainbow-delimiters
             idea-darkula-theme
             color-theme-approximate
			 ))

(defun cfg:install-packages ()
    (let ((pkgs (remove-if #'package-installed-p cfg-var:packages)))
       (when pkgs
            (message "%s" "Emacs refresh packages database...")
            (package-refresh-contents)
            (message "%s" " done.")
            (dolist (p cfg-var:packages)
                (package-install p)))))

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(cfg:install-packages)
(setq inhibit-startup-message t)
;;;
(setq-default tab-width 4 indent-tabs-mode nil)
;;; open file on last edit
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)
;;; disable scrollbar
(scroll-bar-mode -1)
;;; open maximized
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    ((engine-omega "dvi2tty")
     ((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-html "xdg-open")
     (engine-omega "dvi2tty")
     (output-pdf "Okular"))))
 '(custom-safe-themes
   (quote
    ("878e22a7fe00ca4faba87b4f16bc269b8d2be5409d1c513bb7eda025da7c1cf4" default)))
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
(load-theme 'idea-darkula t)
(color-theme-approximate-on)


;;
;;(package 'rainbow-delimiters)
;;(add-hook 'prog-mode-hook 'rainbow-delimiters)


;;;vim like indent
(define-key global-map (kbd "RET") 'newline-and-indent)
;;;fci
(add-hook 'text-mode-hook (lambda () (turn-on-auto-fill)
                            (fci-mode)
                            (set-fill-column 80)))
(add-hook 'markdown-mode-hook (lambda () (turn-on-auto-fill)
                            (fci-mode)
                            (set-fill-column 80)))
(add-hook 'python-mode-hook (lambda () 
                            (fci-mode)
                            (set-fill-column 100)))
(add-hook 'c-mode-hook (lambda () 
                            (fci-mode)
                            (set-fill-column 100)))


(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-ycmd)
(company-ycmd-setup)
(set-variable 'ycmd-server-command '("python" "/home/oliver/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd"))
(add-to-list 'company-backends 'company-ycm)
(add-to-list 'company-begin-commands 'c-electric-colon)
(add-to-list 'company-begin-commands 'c-electric-lt-gt)
(require 'ycmd-next-error)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(require 'flycheck-ycmd)
(flycheck-ycmd-setup)
(require 'xcscope)
(cscope-setup)

; decent gdb setup
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t
 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )


;;; Anpassungen für AUCTeX
(load "auctex.el" nil t t)
;maybe outdated as well integrated
;(load "preview-latex.el" nil t t)
(require 'tex-site)
;;; company-mode
(require 'company-auctex)
(company-auctex-init)

;;; Anpassungen für RefTeX
(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
(add-hook 'latex-mode-hook 'turn-on-reftex) 
(setq reftex-plug-into-AUCTeX t)
(setq reftex-external-file-finders
      '(("tex" . "kpsewhich -format=.tex %f")
        ("bib" . "kpsewhich -format=.bib %f")))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;hunspell
(require 'ispell)
(add-to-list 'ispell-local-dictionary-alist '("deutsch-hunspell"
                                              "[[:alpha:]]"
                                              "[^[:alpha:]]"
                                              "[']"
                                              t
                                              ("-d" "de_DE"); Dictionary file name
                                              nil
                                              iso-8859-1))

(add-to-list 'ispell-local-dictionary-alist '("english-hunspell"
                                              "[[:alpha:]]"
                                              "[^[:alpha:]]"
                                              "[']"
                                              t
                                              ("-d" "en_US")
                                              nil
                                              iso-8859-1))

(setq ispell-program-name "hunspell"          ; Use hunspell to correct mistakes
      ispell-dictionary   "deutsch-hunspell") ; Default dictionary to use


(require 'helm-config)
(require 'helm-misc)
(require 'helm-projectile)
(require 'helm-locate)
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h x") 'helm-register)


(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(setq helm-quick-update)
(setq helm-bookmark-show-location t ;
      helm-buffers-fuzzy-matching t ; helm-mini
      helm-recentf-fuzzy-match t    ; helm-mini
      helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t;
      helm-M-x-fuzzy-match t; 
      helm-semantic-fuzzy-match t;
      helm-apropos-fuzzy-match t;
      helm-lisp-fuzzy-completion t;
      )
(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
;; TODO: helm-semantic or imenu look for noise according to ycmd
(semantic-mode 1)

(helm-mode 1)



(global-set-key (kbd "M-x") 'helm-M-x)

(require 'eshell)
(require 'helm-eshell)

(define-key minibuffer-local-map (kbd "C-c C-l")  'helm-minibuffer-history) ; list actions using C-z
(define-key shell-mode-map (kbd "C-c C-l")  'helm-comint-input-ring) ; list actions using C-z
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map (kbd "C-c C-l")  'helm-eshell-history)))

(defun helm-my-buffers ()
  (interactive)
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm-other-buffer '(helm-c-source-buffers-list
                         helm-c-source-elscreen
                         helm-c-source-projectile-files-list
                         helm-c-source-ctags
                         helm-c-source-recentf
                         helm-c-source-locate)
                       "*helm-my-buffer*")))
(require 'helm-cscope)
;; Enable helm-cscope-mode
(add-hook 'c-mode-hook 'helm-cscope-mode)
(add-hook 'c++-mode-hook 'helm-cscope-mode)
;; Set key bindings
(eval-after-load "helm-cscope"
  '(progn
     (define-key helm-cscope-mode-map (kbd "M-t") 'helm-cscope-find-symbol)
     (define-key helm-cscope-mode-map (kbd "M-r") 'helm-cscope-find-global-definition)
     (define-key helm-cscope-mode-map (kbd "M-g M-c") 'helm-cscope-find-called-function)
     (define-key helm-cscope-mode-map (kbd "M-g M-p") 'helm-cscope-find-calling-this-funtcion)
     (define-key helm-cscope-mode-map (kbd "M-s") 'helm-cscope-select)))

;vim like scrolling
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)
; configure your powerline
(require 'powerline)
(require 'airline-themes)
(load-theme 'airline-sol)



;; have to fct here to quit on one ESC

;;start maximised to be determinated




; should alway be the last
(require 'evil)
(evil-mode 1)
;;browse visual-line
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;;screen up/down
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
						(interactive)
						(evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-k") (lambda ()
						(interactive)
						(evil-scroll-down nil)))
(setq evil-move-cursor-back nil)
;;own leader
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)
;;highligh persist
(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)
;; clean highlight leader(,) Space
(evil-leader/set-key "u" 'evil-search-highlight-persist-remove-all)


(provide '.emacs)
;;; .emacs ends here
