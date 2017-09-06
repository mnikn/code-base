(define (append list1 list2)
    (if (null? list1))
        list2
        (cons (car list1) (append (cdr list1) (cdr list2))))

; 简单的对列表进行反转，不断的让剩余的 list 连接当前的元素
(define (reverse items)
    (if (null? items)
        items
        (append
            (reverse (cdr items)
            (car items)))))

; 更深度的 reverse，能对树进行反转
; 形式上和 reverse 一样，不过需要多加对 (car items) 的判断

(define (deep-reverse items)
    (cond ((null? items) items)
          ((pair? (car items))
            (list (deep-reverse (cdr items))
                  (deep-reverse (car items))))
          (else (append (deep-reverse (cdr items))
                        (car items)))))
