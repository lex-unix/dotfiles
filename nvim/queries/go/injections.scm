; extends

(short_var_declaration 
  left: (expression_list (identifier) @_id (#match? @_id "(sql\|query)"))
  right: (expression_list 
           (raw_string_literal) @injection.content 
             (#set! injection.language "sql")
             (#offset! @injection.content 0 1 0 -1)))

((call_expression
  (selector_expression
    field: (field_identifier) @_field)
  (argument_list
    (interpreted_string_literal) @injection.content 
      (#set! injection.language "sql")
      (#offset! @injection.content 0 1 0 -1)))
  (#any-of? @_field "Exec" "GetContext" "ExecContext" "SelectContext" "Select"
				            "RebindNamed" "Rebind" "QueryRowxContext" "NamedExec" "MustExec" "Queryx"))
