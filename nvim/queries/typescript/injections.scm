; extends

(lexical_declaration (
  variable_declarator 
    name: (identifier) @_id (#eq? @_id "sql")
    value: (template_string) @injection.content 
      (#set! injection.language "sql")
      (#offset! @injection.content 0 1 0 -1)))

(assignment_expression
  left: (identifier) @_id (#eq? @_id "sql")
  right: (template_string) @injection.content
    (#set! injection.language "sql")
    (#offset! @injection.content 0 1 0 -1))

