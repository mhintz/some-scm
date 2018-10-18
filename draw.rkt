#lang racket

(require racket/draw)

(require "./math.rkt")
(require "./vector.rkt")
(require "./polyline.rkt")
(require "./circle.rkt")
(require "./pgram.rkt")

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

(define (draw-pgram ctx plg)
  (let* ([verts (pgram-vertices plg)])
    (draw-polyline ctx (polyline-add plg (car plg)))))

(provide
  draw-segment
  draw-polyline
  draw-circle)
