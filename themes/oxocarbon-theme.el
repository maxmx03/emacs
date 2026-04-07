(autothemer-deftheme oxocarbon "Carbonfox Port para Emacs"

  ;; 1. PALETA DE CORES (Mapeada do seu Carbonfox)
  ((((class color) (min-colors #xFFFFFF))
    ((class color) (min-colors #xFF)))

   (oxocarbon-bg      "#161616") ;; base00 (base_30)
   (oxocarbon-fg      "#f2f4f8") ;; base05 (base_30)
   
   ;; Tons de Cinza/Painéis
   (oxocarbon-base00  "#161616") 
   (oxocarbon-base01  "#262626") ;; base01 (base_16)
   (oxocarbon-base02  "#393939") ;; base02 (base_16)
   (oxocarbon-base03  "#525252") ;; base03 (base_16) - Comments
   (oxocarbon-base04  "#d0d0d0") ;; base04 (base_16) - Variables
   (oxocarbon-base05  "#f2f4f8")
   
   ;; Cores Carbonfox
   (oxocarbon-cyan    "#3ddbd9") ;; base0B (base_30)
   (oxocarbon-blue    "#78a9ff") ;; base09 (base_16) - Integers/Booleans
   (oxocarbon-magenta "#ff7eb6") ;; base0C (base_16)
   (oxocarbon-green   "#42be65") ;; base0D (base_16) - Functions
   (oxocarbon-violet  "#be95ff") ;; base0E (base_16) - Keywords
   (oxocarbon-red     "#ee5396") ;; base0A (base_16) - Classes
   (oxocarbon-sky     "#33b1ff") ;; base0B (base_16) - Strings
   (oxocarbon-orange  "#F8BD96") ;; base0C (base_30)
   (oxocarbon-yellow  "#FAE3B0") ;; base0C (base_30)

   (oxocarbon-yellow-shade "#38352d")
  )

  ;; 2. MAPEAMENTO DE FACES (Onde a mágica acontece)
  (
   (default (:foreground oxocarbon-fg :background oxocarbon-bg))
   (region  (:background oxocarbon-base02))
   (cursor  (:background oxocarbon-cyan))
   (highlight (:background oxocarbon-yellow-shade :foreground oxocarbon-yellow))

   ;; Sintaxe Programação (Standard)
   (font-lock-comment-face       (:foreground oxocarbon-base03 :italic t))
   (font-lock-keyword-face       (:foreground oxocarbon-violet :bold t))
   (font-lock-string-face        (:foreground oxocarbon-sky))
   (font-lock-function-name-face (:foreground oxocarbon-green))
   (font-lock-function-call-face (:foreground oxocarbon-green))
   (font-lock-variable-name-face (:foreground oxocarbon-base04))
   (font-lock-type-face           (:foreground oxocarbon-red))
   (font-lock-constant-face       (:foreground oxocarbon-blue))
   (font-lock-builtin-face        (:foreground oxocarbon-magenta))
   (font-lock-preprocessor-face   (:foreground oxocarbon-violet))
   (font-lock-property-name-face (:foreground oxocarbon-cyan))
   (font-lock-property-use-face (:foreground oxocarbon-cyan))

   ;; --- TREE-SITTER FACES (Para o add ficar colorido!) ---
   (treesit-font-lock-function-name-face (:foreground oxocarbon-green))
   (treesit-font-lock-function-call-face (:foreground oxocarbon-green))
   (treesit-font-lock-method-name-face   (:foreground oxocarbon-green))
   (treesit-font-lock-method-call-face   (:foreground oxocarbon-green))
   (treesit-font-lock-type-face          (:foreground oxocarbon-blue))
   (treesit-font-lock-variable-name-face (:foreground oxocarbon-base04))
   (treesit-font-lock-keyword-face       (:foreground oxocarbon-violet :bold t))
   (treesit-font-lock-string-face        (:foreground oxocarbon-sky))
   (treesit-font-lock-operator-face      (:foreground oxocarbon-fg))
   
   ;; UI
   (line-number                  (:foreground oxocarbon-base03 :background oxocarbon-bg))
   (line-number-current-line      (:foreground oxocarbon-fg :background oxocarbon-base01 :bold t))
   (mode-line                    (:background oxocarbon-base01 :foreground oxocarbon-fg :box nil))
   (mode-line-inactive           (:background oxocarbon-bg :foreground oxocarbon-base03 :box nil))
   
   ;; Org Mode
   (org-level-1 (:foreground oxocarbon-magenta :bold t :height 1.2))
   (org-level-2 (:foreground oxocarbon-blue :bold t :height 1.1))
   (org-level-3 (:foreground oxocarbon-cyan :bold t))
   (org-todo (:foreground oxocarbon-orange))
   (org-modern-todo (:foreground oxocarbon-orange))
   (org-modern-done (:foreground oxocarbon-green))
   
   ;; Flycheck/Eglot Errors
   (error   (:foreground oxocarbon-red :bold t))
   (warning (:foreground oxocarbon-orange))

   ;; dirvish
   (dirvish-hl-line (:background oxocarbon-yellow-shade :foreground oxocarbon-yellow))
   
   ;; nerd-icons
   (nerd-icons-red (:foreground oxocarbon-red))
   (nerd-icons-blue (:foreground oxocarbon-blue))
   (nerd-icons-cyan (:foreground oxocarbon-cyan))
   (nerd-icons-pink (:foreground oxocarbon-magenta))
   (nerd-icons-green (:foreground oxocarbon-green))
   (nerd-icons-purple (:foreground oxocarbon-violet))
   (nerd-icons-orange (:foreground oxocarbon-orange))
   (nerd-icons-yellow (:foreground oxocarbon-yellow))
  )
)

(provide-theme 'oxocarbon)
