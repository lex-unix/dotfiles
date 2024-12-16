; extends

(lexical_declaration (
  variable_declarator
    name: (identifier) @_id (#match? @_id "(sql\|query)")
    value: (template_string
     (string_fragment) @injection.content
        (#set! injection.language "sql")
)))


(assignment_expression
  left: (identifier) @_id (#match? @_id "(sql\|query)")
  right: (template_string
    (string_fragment) @injection.content
      (#set! injection.language "sql")
))
