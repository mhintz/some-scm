#lang racket

(require "./utilities.rkt")

;;;; 2d vector ;;;;

(define (vec x y)
  (cons x y))

(define (vx v)
  (car v))

(define (vy v)
  (cdr v))

(define (vec? v)
  (and (pair? v) (number? (vx v)) (number? (vy v))))

; vector addition
(define (vec+ v1 v2)
  (map-pairs + v1 v2))

; vector subtraction
(define (vec- v1 v2)
  (map-pairs - v1 v2))

; vector scalar addition
(define (vec-scalar+ v x y)
  (vec (+ (vx v) x) (+ (vy v) y)))

; vector scalar subtraction
(define (vec-scalar- v x y)
  (vec (- (vx v) x) (- (vy v) y)))

; vector-scalar multiplication
(define (vec* v s)
  (map-pair (lambda (x) (* x s)) v))

; vector-scalar division
(define (vec/ v s)
  (map-pair (lambda (x) (/ x s)) v))

; vector length
(define (vec-len v)
  (sqrt (+ (expt (vx v) 2) (expt (vy v) 2))))

; normalize a vector
(define (vec-normalize v)
  (let ([len (vec-len v)])
    (vec/ v len)))

; distance between vecs
(define (vec-distance v1 v2)
  (vec-len (vec- v1 v2)))

; vector dot product
(define (vec-dot v1 v2)
  (let ([mult (map-pairs * v1 v2)])
    (+ (car mult) (cdr mult))))

; vector cross product (1d)
(define (vec-cross v1 v2)
  (- (* (vx v1) (vy v2)) (* (vy v1) (vx v2))))

; perpendicular vector
(define (vec-perp v)
  (vec (- 0 (vy v)) (vx v)))

(provide
  vec
  vx
  vy
  vec?
  vec+
  vec-
  vec-scalar+
  vec-scalar-
  vec*
  vec/
  vec-len
  vec-normalize
  vec-distance
  vec-dot
  vec-cross
  vec-perp)
