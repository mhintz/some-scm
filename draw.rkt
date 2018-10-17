#lang racket

(require racket/draw)

(require "./math.rkt")
(require "./vector.rkt")
(require "./polyline.rkt")
(require "./circle.rkt")
(require "./rectangle.rkt")

(define seg-base-length 0.1)

(define (draw-segment ctx seg)
  (let ([p1 (seg-start seg)]
        [p2 (seg-end seg)])
  (send ctx draw-line (vx p1) (vy p1) (vx p2) (vy p2))))

(define (draw-polyline ctx poly)
  (send ctx draw-lines poly))

(define (draw-circle ctx circ)
  (let* ([circle-segments (round (/ (* 2pi (cr circ)) seg-base-length))]
         [pt (lambda (idx)
               (circle-pos circ (* 2pi (/ idx circle-segments))))]
         [poly (map pt (range circle-segments))])
    (draw-polyline ctx poly)))

(define (draw-rectangle ctx rect)
  (let* ([minpt (rmin rect)]
         [maxpt (rmax rect)]
         [poly (polyline minpt (vec (vx minpt) (vy maxpt)) maxpt (vec (vx maxpt) (vy minpt)) minpt)])
    (draw-polyline ctx poly)))

(provide
  draw-segment
  draw-polyline
  draw-circle)
