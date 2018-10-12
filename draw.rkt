#lang racket

(require "./math.rkt")
(require "./vector.rkt")
(require "./segment.rkt")
(require "./circle.rkt")

(define seg-base-length 0.1)

(define (draw-line cx seg)
  (let ([p1 (seg-start seg)]
        [p2 (seg-end seg)])
  (send cx draw-line (vx p1) (vy p1) (vx p2) (vy p2))))

(define (draw-circle cx circ)
  (let* ([circle-segments (round (/ (* 2 pi (cr circ)) seg-base-length))]
        [pt (lambda (idx)
              (circle-pos circ (* 2 pi (/ idx circle-segments))))])
    (for ([idx (in-range 1 circle-segments)])
      (draw-line cx (segment (pt (- idx 1)) (pt idx))))))
