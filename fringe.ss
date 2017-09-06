(load "append.ss")

; 把树转化为平面的 list，神奇的发现处理的形式和 deep-reverse 很像
(define (fringe items)
    (cond ((null? items) items)
          ((pair? items)
              (append (fringe (car items))
                      (fringe (cdr items))))
          (else
              (append (list (car items))
                      (fringe (cdr items))))))
