#lang racket

(require racket/draw)

(require "./math.rkt")
(require "./vector.rkt")
(require "./polyline.rkt")
(require "./circle.rkt")

(define seg-base-length 0.1)

(define (draw-segment cx seg)
  (let ([p1 (seg-start seg)]
        [p2 (seg-end seg)])
  (send cx draw-line (vx p1) (vy p1) (vx p2) (vy p2))))

(define (draw-polyline cx poly)
  (send cx draw-lines poly))

(define (draw-circle cx circ)
  (let* ([circle-segments (round (/ (* 2pi (cr circ)) seg-base-length))]
         [pt (lambda (idx)
               (circle-pos circ (* 2pi (/ idx circle-segments))))]
         [poly (map pt (range circle-segments))])
    (draw-polyline cx poly)))

(provide
  draw-segment
  draw-polyline
  draw-circle)
