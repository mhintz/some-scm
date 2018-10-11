#lang racket

;;;; 2d math functions ;;;;

(require "./utilities.rkt")

(define 2pi (* 2 pi))

(define (!= a b) (not (= a b)))

(define (in-range val a b)
  (and (<= a val) (<= val b)))

; 2d vector
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

; line segment definitions
(define (segment v1 v2)
  (list v1 v2))

(define (seg-start seg)
  (car seg))

(define (seg-end seg)
  (cadr seg))

; segment-to-vector
(define (segment->vec seg)
  (vec- (seg-end seg) (seg-start seg)))

; determine if two line segments intersect with each other 
; based on https://stackoverflow.com/a/565282 
(define (segment-intersect segA segB)
  (let* ([p (seg-start segA)]
        [q (seg-start segB)]
        [r (segment->vec segA)]
        [s (segment->vec segB)]
        [denom (vec-cross r s)]
        [uNumer (vec-cross (vec- q p) r)]
        [tNumer (vec-cross (vec- q p) s)])
  ; test the denominator, r <cross> s
  (if (= denom 0)
    (if (!= uNumer 0)
      ; parallel, not intersecting
      #f 
      ; parallel, collinear - determine if segments overlap
      (let* (
            ; t0 = (q − p) · r / (r · r)
            [t0 (/ (vec-dot (vec- q p) r) (vec-dot r r))]
            ; t1 = (q + s − p) · r / (r · r) = t0 + s · r / (r · r)
            [t1 (/ (+ t0 (vec-dot s r)) (vec-dot r r))]
           )
      ; determines overlap for parallel
      (or (in-range t0 0 1) (in-range t1 0 1))))
    (let ([u (/ uNumer denom)]
          [t (/ tNumer denom)])
    ; determines overlap for non-parallel
    (if (and (in-range t 0 1) (in-range u 0 1))
      ; not parallel, intersecting
      #t
      ; not parallel, not intersecting
      #f)))))

; TODO: test cases for the above
; (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))
; (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5)) 
; (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 1 0) (vec 0 1)))
; (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 0 1)))
; (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))

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
  vec-perp
  segment
  seg-start
  seg-end
  segment->vec
  segment-intersect)
