#lang racket

(require racket/draw)

(require "../util.rkt")
(require "../vector.rkt")
(require "../polyline.rkt")
(require "../circle.rkt")
(require "../draw.rkt")
(require "../intersection.rkt")

(define *drawing-name* "funky-circles")

(define (gen-circles init-count width height)
  (let recur ([count init-count] [lst empty])
    (let* ([mid-x (* width 0.5)]
          [mid-y (* height 0.5)]
          [min-x 20]
          [min-y 20]
          [max-x (- width 20)]
          [max-y (- height 20)]
          [x (rand-in min-x max-x)]
          [y (rand-in min-y max-y)]
          [circ (circle (vec x y) 4)])
      (cond
        [(= count 0) lst]
        [else (if
          (not (ormap
                 (lambda (other)
                   (and
                     (not (circle-eq? circ other))
                     (circle-circle-intersect? (circle-expand circ 2) other))) lst))
            (recur (- count 1) (cons circ lst))
            (recur (- count 1) lst))]))))

(define (draw-drawing ctx width height)
    (for-each (lambda (c) (draw-circle ctx c)) (gen-circles 30000 width height)))

(provide
  *drawing-name*
  draw-drawing)
