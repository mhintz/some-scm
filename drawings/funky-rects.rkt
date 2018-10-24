#lang racket

(require "../util.rkt")
(require "../vector.rkt")
(require "../polyline.rkt")
(require "../circle.rkt")
(require "../pgram.rkt")
(require "../intersection.rkt")
(require "../draw.rkt")

(define *drawing-name* "funky-rects")

; random pgram at x y with side lengths s1 and s2
(define (rand-pgram x y s1 s2)
  (let* ([side1 (rand-vec s1)]
         [side2 (vec-rotate side1 (rand-in (* pi 0.3) (- pi (* pi 0.3))))])
    (pgram (vec x y) side1 (vec-with-len side2 s2))))

(define (gen-points cnt width height)
  (let ([coll empty])
    (for ([idx (in-range cnt)])
      (let ([pt (rand-point width height)])
        (set! coll (cons pt coll))
        #| (when (pgram-vec-intersect? plg pt)) |#
        ))
    coll))

(define (gen-pgrams cnt width height)
  (let recur ([n cnt] [lst empty])
    (cond
      [(= n 0) lst]
      [else (let ([plg (rand-pgram (rand-in 0 width) (rand-in 0 height) (rand-in 5 10) (rand-in 5 10))])
        (if (not (ormap (lambda (p) (and (not (pgram-eq? plg p)) (pgram-intersect? plg p))) lst))
          (recur (- n 1) (cons plg lst))
          (recur (- n 1) lst)))])))

#| (define (draw-drawing ctx width height) |#
#|   (let* ([plgs (map (lambda (idx) (rand-pgram (rand-in 0 width) (rand-in 0 height) (rand-in 5 10) (rand-in 5 10))) (range 500))] |#
#|          [points (gen-points 1000 width height)]) |#
#|     (for-each (lambda (plg) (draw-pgram ctx plg)) plgs) |#
#|     (for-each (lambda (pt) (draw-point ctx pt)) points))) |#

(define (draw-drawing ctx width height)
  (let ([plgs (gen-pgrams 1000 width height)])
    (for-each (lambda (p) (draw-pgram ctx p)) plgs)))

(provide
  *drawing-name*
  draw-drawing)
