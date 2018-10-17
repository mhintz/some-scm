#lang racket

(require "./vector.rkt")

;;;; circle ;;;;

(define (circle center rad)
  (list center rad))

(define (cc circ)
  (car circ))

(define (cx circ)
  (vx (car circ)))

(define (cy circ)
  (vy (car circ)))

(define (cr circ)
  (car (cdr circ)))

(define (circle-expand circ dr)
  (circle (cc circ) (+ (cr circ) dr)))

(define (circle-eq? c1 c2)
  (and (= (cx c1) (cx c2)) (= (cy c1) (cy c2)) (= (cr c1) (cr c2))))

(define (circle-pos circ ang)
  (vec (+ (cx circ) (* (cr circ) (cos ang)))
       (+ (cy circ) (* (cr circ) (sin ang)))))

(define (circle-intersect? c1 c2)
  (<= (vec-distance (cc c1) (cc c2)) (+ (cr c1) (cr c2))))

(provide
  circle
  cx
  cy
  cr
  circle-expand
  circle-eq?
  circle-pos
  circle-intersect?)
