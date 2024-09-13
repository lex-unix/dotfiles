; extends

(assignment
  left: ((identifier) @_id (#match? @_id "sql"))
  right: (string (string_content) @injection.content 
             (#set! injection.language "sql")))
