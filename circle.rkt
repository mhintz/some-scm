#lang racket

(require "./vector.rkt")

;;;; circle ;;;;

; circle is a pair of a center vector and a radius
(define (circle center rad)
  (cons center rad))

; get the circle center
(define (cc circ)
  (car circ))

(define (cx circ)
  (vx (cc circ)))

(define (cy circ)
  (vy (cc circ)))

(define (cr circ)
  (cdr circ))

; expand a circle's radius by the scalar dr
(define (circle-expand circ dr)
  (circle (cc circ) (+ (cr circ) dr)))

; circle equivalence test
(define (circle-eq? c1 c2)
  (and (= (cx c1) (cx c2)) (= (cy c1) (cy c2)) (= (cr c1) (cr c2))))

; get a position on the circle by angle around it
(define (circle-pos circ ang)
  (vec (+ (cx circ) (* (cr circ) (cos ang)))
       (+ (cy circ) (* (cr circ) (sin ang)))))

(provide (all-defined-out))
