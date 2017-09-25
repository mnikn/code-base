#lang racket

; constructor and selector
(define (make-tree x left right) (list x left right))
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

; operator
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        (else
         (element-of-set? x (right-branch set)))))

(define (add-element x set)
  (cond ((null? set) (make-tree x `() `()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree
          (entry set)
          (add-element x (left-branch set))
          (right-branch set)))
        (else
         (make-tree
          (entry set)
          (left-branch set)
          (add-element x (right-branch set))))))

(define (tree->list tree)
  (if (null? tree)
      `()
      (append (tree->list (left-branch tree))
              (cons (entry tree)
                    (tree->list (right-branch tree))))))

(define (length seq)
  (if (null? seq)
      0
      (+ 1 (length (cdr seq)))))

(define (list->tree seq)
  (car (partial-tree seq (length seq))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))
              
              
            
      
