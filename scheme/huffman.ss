#lang racket

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? leaf)
  (eq? (car leaf) 'leaf))
(define (symbol-leaf leaf)
  (cadr leaf))
(define (weight-leaf leaf)
  (caddr leaf))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left)
                (symbols right))
        (+ (weight left)
           (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

;generate

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else
         (cons (car set)
               (adjoin-set x (cdr set))))))

  (define (make-leaf-set pairs)
    (if (null? pairs)
        `()
        (let ((pair (car pairs)))
          (adjoin-set
           (make-leaf (car pair)
                      (cadr pair))
           (make-leaf-set (cdr pairs))))))

  (define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

  (define (successive-merge leaves)
    (cond ((= (length leaves) 0)
           `())
          ((= (length leaves) 1)
           (car leaves))
          (else
           (let ((sub-tree (make-code-tree (car leaves) (cadr leaves)))
                 (remains-leaves (cddr leaves)))
             (successive-merge (adjoin-set sub-tree remains-leaves))))))

  (define (decode bits tree)
    (define (do-decode bits current-branch)
      (if (null? bits)
          `()
          (let ((next-branch (choose-branch (car bits) current-branch)))
            (if (leaf? next-branch)
                (cons (symbol-leaf next-branch)
                      (do-decode (cdr bits) tree))
                (do-decode (cdr bits) next-branch)))))
    (do-decode bits tree))
  (define (choose-branch bit branch)
    (cond ((= 0 bit) (left-branch branch))
          ((= 1 bit) (right-branch branch))
          (else (error "Fuck off,I can't understand this bit means"))))


  (define (encode message tree)
    (if (null? message)
        `()
        (append (encode-symbol (car message) tree)
                (encode (cdr message) tree))))
  (define (encode-symbol symbol tree)
    (if (leaf? tree)
        `()
        (let ((left-tree (left-branch tree))
              (right-tree (right-branch tree)))
          (cond ((symbol-in-branch? symbol left-tree)
                 (cons 0 (encode-symbol symbol left-tree)))
                ((symbol-in-branch? symbol right-tree)
                 (cons 1 (encode-symbol symbol right-tree)))))))
  (define (symbol-in-branch? symbol tree)
    (define (has-symbol? symbol-set)
      (if (null? symbol-set)
          #f
          (or (eq? symbol (car symbol-set))
              (has-symbol? (cdr symbol-set)))))
    (has-symbol? (symbols tree)))

  (define sample-tree
    (make-code-tree (make-leaf 'A 4)
                    (make-code-tree
                     (make-leaf 'B 2)
                     (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))
  (define samle-message '(A B C D))
                    
  