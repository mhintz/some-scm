#lang racket

(require "util.rkt")

;;;; 2d vector ;;;;

(define (vec x y)
  (cons x y))

(define (vx v)
  (car v))

(define (vy v)
  (cdr v))

(define (vec? v)
  (and (pair? v) (number? (vx v)) (number? (vy v))))

(define (vec-eq? v1 v2)
  (and (= (vx v1) (vx v2)) (= (vy v1) (vy v2))))

; vector addition
(define (vec+ v1 v2)
  (vec (+ (vx v1) (vx v2)) (+ (vy v1) (vy v2))))

; vector subtraction
(define (vec- v1 v2)
  (vec (- (vx v1) (vx v2)) (- (vy v1) (vy v2))))

; piecewise vector scalar addition
(define (vec-scalar+ v x y)
  (vec (+ (vx v) x) (+ (vy v) y)))

; piecewise vector scalar subtraction
(define (vec-scalar- v x y)
  (vec (- (vx v) x) (- (vy v) y)))

; vector-scalar multiplication
(define (vec* v s)
  (vec (* (vx v) s) (* (vy v) s)))

; vector-scalar division
(define (vec/ v s)
  (vec (/ (vx v) s) (/ (vy v) s)))

; squared vector length
(define (vec-len-sq v)
  (+ (expt (vx v) 2) (expt (vy v) 2)))

; vector length
(define (vec-len v)
  (sqrt (vec-len-sq v)))

; normalize a vector
(define (vec-normalize v)
  (let ([len (vec-len v)])
    (vec/ v len)))

; distance between vecs
(define (vec-distance v1 v2)
  (vec-len (vec- v1 v2)))

; vector dot product
(define (vec-dot v1 v2)
  (+ (* (vx v1) (vx v2)) (* (vy v1) (* (vy v2)))))

; vector cross product (1d)
(define (vec-cross v1 v2)
  (- (* (vx v1) (vy v2)) (* (vy v1) (vx v2))))

; perpendicular vector
(define (vec-perp v)
  (vec (- (vy v)) (vx v)))

; rotate a vector by angle
; cosA x - sinA y, sinA x + cosA y
(define (vec-rotate v ang)
  (let ([x (vx v)]
        [y (vy v)]
        [cos-ang (cos ang)]
        [sin-ang (sin ang)])
    (vec (- (* cos-ang x) (* sin-ang y)) (+ (* sin-ang x) (* cos-ang y)))))

; signed area of the triangle produced by the two vectors
; positive when the triangle is counter-clockwise
(define (tri-signed-area v1 v2)
  (/ (vec-cross v1 v2) 2))

; random unit vector (the range on rand-in is to avoid the possibility of 0, 0)
(define (rand-unit-vec)
  (vec-normalize (vec (rand-in 0.1 1.0) (rand-in 0.1 1.0))))

; random vector of length len
(define rand-vec
  (case-lambda
    [(len) (vec* (rand-unit-vec) len)]
    [(xlen ylen) (let ([v (rand-unit-vec)]) (vec (* (vx v) xlen) (* (vy v) ylen)))]))

(define (rand-point maxX maxY)
  (vec (rand-in 0 maxX) (rand-in 0 maxY)))

; set the vector length to len
(define (vec-with-len v len)
  (vec* (vec-normalize v) len))

(provide (all-defined-out))
