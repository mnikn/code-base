#lang racket
(require "data-process.ss")

(define (permutations seq)
  (define (remove x seq)
    (filter (lambda (e) (not (= e x))) seq))
  (if (null? seq)
      (list `())
      (flatmap (lambda (element)
                  (map (lambda (permutation)
                         (cons element permutation))
                       (permutations (remove element seq))))
                seq)))