#lang racket

(require "./utilities.rkt")

;;;; 2d vector ;;;;

(define (vec x y)
  (list x y))

(define (vx v)
  (car v))

(define (vy v)
  (cadr v))

(define (vec? v)
  (and (list? v) (all (map number? v))))

; vector addition
(define (vec+ v1 v2)
  (map + v1 v2))

; vector subtraction
(define (vec- v1 v2)
  (map - v1 v2))

; vector-scalar multiplication
(define (vec* v s)
  (map (lambda (x) (* x s)) v))

; vector-scalar division
(define (vec/ v s)
  (map (lambda (x) (/ x s)) v))

; vector length
(define (vec-len vec)
  (sqrt (apply + (map (lambda (v) (expt v 2)) vec))))

; normalize a vector
(define (vec-normalize vec)
  (let ([len (vec-len vec)])
    (vec/ vec len)))

; distance between vecs
(define (vec-distance v1 v2)
  (vec-len (vec- v1 v2)))

; vector dot product
(define (vec-dot v1 v2)
  (apply + (map * v1 v2)))

; vector cross product (1d)
(define (vec-cross v1 v2)
  (- (* (vx v1) (vy v2)) (* (vy v1) (vx v2))))

; perpendicular vector
(define (vec-perp v)
  (list (- 0 (vy v)) (vx v)))

(provide
  vec
  vx
  vy
  vec?
  vec+
  vec-
  vec*
  vec/
  vec-len
  vec-normalize
  vec-distance
  vec-dot
  vec-cross
  vec-perp)
