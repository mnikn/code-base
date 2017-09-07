#lang racket

(define (subset s)
  (if (null? s)
      (list s)
      (let ((rest (subset (cdr s))))
        (append rest (map (lambda (item)
                            (cons (car s) item))
                          rest)))))