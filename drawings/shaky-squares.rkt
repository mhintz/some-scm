#lang racket

(define *drawing-name* "shaky-squares")

(require racket/draw)

(define *num-squares-x* 18)
(define *num-squares-y* 26)
(define *rotation* 2)
(define *delta* 2.7)
(define *box-size* 15)

; based on the example from http://wiki.call-cc.org/eggref/4/cairo#examples
(define (draw-drawing cx width height)
  (for ([y (in-range 0 *num-squares-y*)])
    (for ([x (in-range 0 *num-squares-x*)])
      (let ([tx (send cx get-transformation)])
        (send cx translate (+ 12 (* x *box-size*)) (+ 16 (* y *box-size*)))
        (send cx rotate (* (if (> 0 (random 2)) -1 1)
                           (/ pi 180)
                           (* *rotation* (random))))
        (send cx draw-rectangle 0 0 *box-size* *box-size*)
        (send cx set-transformation tx)))
  (set! *rotation* (+ *rotation* *delta*))))

(provide
  *drawing-name*
  draw-drawing)

