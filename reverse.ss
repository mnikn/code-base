(define (append list1 list2)
    (if (null? list1))
        list2
        (cons (car list1) (append (cdr list1) (cdr list2))))

(define (reverse items)
    (if (null? items)
        items
        (append
            (reverse (cdr items)
            (car items)))))

(define (deep-reverse items)
    (cond ((null? items) items)
          ((pair? (car items))
            (list (deep-reverse (cdr items))
                  (deep-reverse (car items))))
          (else (append (deep-reverse (cdr items))
                        (car items)))))
