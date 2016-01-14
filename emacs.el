(require 'cl)
(require 'package)

(setq cfg-var:packages '(evil
			 flycheck
			 company
			 auctex
			 company-auctex
			 flycheck-ycmd
			 company-ycmd
			 xcscope))

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
     (output-pdf "Okular")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

; should alway be the last
(require 'evil)
(evil-mode 1)
(provide '.emacs)
;;; .emacs ends here
