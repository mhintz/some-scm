#lang racket

(require racket/draw)

(require "./math.rkt")
(require "./vector.rkt")
(require "./polyline.rkt")
(require "./circle.rkt")
(require "./pgram.rkt")

; units assumed to be in millimeters
(define seg-base-length 0.1)
(define point-radius 0.5)

; draws a single segment
(define (draw-segment ctx seg)
  (let ([p1 (seg-start seg)]
        [p2 (seg-end seg)])
  (send ctx draw-line (vx p1) (vy p1) (vx p2) (vy p2))))

; draws a polyline
(define (draw-polyline ctx poly)
  (send ctx draw-lines poly))

; draws a circle
(define (draw-circle ctx circ)
  (let* ([circle-segments (round (/ (* 2pi (cr circ)) seg-base-length))]
         [pt (lambda (idx)
               (circle-pos circ (* 2pi (/ idx circle-segments))))]
         [poly (map pt (range circle-segments))])
    (draw-polyline ctx poly)))

; draws a parallelogram
(define (draw-pgram ctx plg)
  (let* ([verts (pgram-vertices plg)])
    (draw-polyline ctx (polyline-push verts (car plg)))))

; draws a vector as a point as a little circle
(define (draw-point ctx v)
  (let ([circ (circle v point-radius)])
    (draw-circle ctx circ)))

(provide
  draw-segment
  draw-polyline
  draw-circle
  draw-pgram
  draw-point)
