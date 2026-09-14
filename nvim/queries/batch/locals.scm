;; Batch/CMD lexical scopes.
;;
;; Parenthesized blocks and control-flow statements introduce useful
;; structural scopes for Tree-sitter consumers.

(parenthesized) @local.scope
(if_stmt) @local.scope
(for_stmt) @local.scope
(else_clause) @local.scope

;; Environment-variable assignments.
(variable_assignment
  (variable_name) @local.definition)

;; Environment-variable references.
(variable_reference) @local.reference

;; FOR variables behave like local parameters.
(for_variable) @local.definition
