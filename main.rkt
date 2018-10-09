#lang racket

(require racket/draw)
(require racket/math)
(require "./math.rkt")

(define *filename* "out.svg")
(define *rotation* 2)
(define *delta* 2.7)
(define *width* 18)
(define *height* 26)
(define *box-size* 15)

(define (println arg)
  (display arg)
  (newline))

(define cx (new svg-dc% [width 842] [height 1190] [output *filename*] [exists 'replace]))
(define pen-main (new pen% [color (make-color 0 0 0)] [width 0.5] [style 'solid]))
(define brush-main (make-brush #:style 'transparent))

(define (setup)
  (send cx start-doc "")
  (send cx start-page)
  (send cx scale (/ 72 25.4) (/ 72 25.4))
  (send cx set-pen pen-main)
  (send cx set-brush brush-main))

(define (draw-main)
  (for ([y (in-range 0 *height*)])
    (for ([x (in-range 0 *width*)])
      (let ([tx (send cx get-transformation)])
        (send cx translate (+ 12 (* x *box-size*)) (+ 16 (* y *box-size*)))
        (send cx rotate (* (if (> 0 (random 2)) -1 1)
                           (/ pi 180)
                           (* *rotation* (random))))
        (send cx draw-rectangle 0 0 *box-size* *box-size*)
        (send cx set-transformation tx)))
  (set! *rotation* (+ *rotation* *delta*))))

(define (teardown)
  (send cx end-page)
  (send cx end-doc))

(setup)
(draw-main)
(teardown)
#| (define (main args) |#
#|   (setup) |#
#|   (draw-main) |#
#|   (teardown)) |#

