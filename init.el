;; initial screen
(setq inhibit-splash-screen t)
(switch-to-buffer "**")
(when window-system (set-frame-position (selected-frame) 50 50))
(when window-system (set-frame-size (selected-frame) 150 30))


;; global screen settings
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq column-number-mode t)
(global-linum-mode t)
(show-paren-mode t)


;; Use `command` as `meta` in macOS.
(setq mac-command-modifier 'meta)


;; windows switch
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)


;; update package-archive lists
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("ELPA"  . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)


;; install 'use-package' if necessary
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; enable use-package
(eval-when-compile (require 'use-package))
;; (require 'diminish)                ;; if you use :diminish
;; (require 'bind-key)                ;; if you use any :bind varian


;; cyberpunk
(use-package cyberpunk-theme
  :ensure t
  :init
  (load-theme 'cyberpunk t)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package rjsx-mode
  :ensure t)


;; helm (REVIEW)
(use-package helm
  :ensure t
  :diminish helm-mode
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list))
  :init
  (setq helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-display-header-line nil)
  :config
  (helm-mode 1)
  (helm-autoresize-mode 1))


;; projectile
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (define-key projectile-mode-map (kbd "s-,") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-enable-caching t
        projectile-completion-system 'helm
        projectile-switch-project-action 'helm-projectile)
  (projectile-global-mode))


(use-package helm-projectile
  :ensure t
  :commands (helm-projectile)
  :config (helm-projectile-on))

;; all-the-icons (for neotree)
(use-package all-the-icons
  :if window-system
  :ensure t
  :config
  (when (not (member "all-the-icons" (font-family-list)))
    (all-the-icons-install-fonts t)))


;; neotree
(use-package neotree
  :ensure t
  :bind ("<f8>" . 'neotree-toggle)
  :init
  ;; slow rendering
  (setq inhibit-compacting-font-caches t)
  ;; set icons theme
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  ;; Every time when the neotree window is opened, let it find current file and jump to node
  (setq neo-smart-open t)
  ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically
  (setq projectile-switch-project-action 'neotree-projectile-action)
  ;; show hidden files
  (setq-default neo-show-hidden-files t))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rjsx-mode neotree helm-projectile projectile helm cyberpunk-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
