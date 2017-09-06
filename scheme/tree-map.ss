; 能够处理树的 map
(define (tree-map prog tree)
    (map (lambda (subtree)
            (if (pair? subtree))
                (tree-map prog subtree)
                (prog subtree))
        tree))

(define (square-tree tree)
    (tree-map (lambda (x) (* x x)) tree))
