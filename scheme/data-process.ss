#lang racket

; high order
(define (accumulate prog init seq)
  (if (null? seq)
       init
       (prog (car seq)
             (accumulate prog init (cdr seq)))))

(define (map prog seq)
  (accumulate
   (lambda (x y)
     (cons (prog x) y))
   `()
   seq))

(define (append seq1 seq2)
  (accumulate
   cons
   seq2
   seq1))

(define (filter pred seq)
  (cond ((null? seq) seq)
        ((pred (car seq)) (cons (car seq) (filter pred (cdr seq))))
        (else (filter pred (cdr seq)))))

(define (enumerate-interval low high)
  (if (> low high)
      `()
      (cons low (enumerate-interval (+ low 1) high))))

; 把树转化为列表
(define (enumerate-tree tree)
  (cond ((null? tree) tree)
        ((pair? tree)
         (append (enumerate-tree (car tree))
                 (enumerate-tree (cdr tree))))
        (else (list tree))))

(define (square x) (* x x))
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define (sum-odd-squares tree)
  (accmulate
   +
   0
   (map square (filter odd? (enumerate-tree tree)))))

(define (evens-fib n)
  (accmulate
   cons
   `()
   (filter even? (map fib (enumerate-interval 0 n)))))