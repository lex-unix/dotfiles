; extends

((inline) @_inline @injection.content 
  (#set! injection.language "tsx") 
  (#match? @_inline "^\(import\|export\)")) 
