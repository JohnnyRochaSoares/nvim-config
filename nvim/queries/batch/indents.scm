;; Parenthesized blocks:
;; (
;;     command
;; )

(parenthesized
  "(" @indent.begin
  ")" @indent.end)

;; IF / FOR / ELSE structures.
(if_stmt) @indent.begin
(else_clause) @indent.begin
(for_stmt) @indent.begin
