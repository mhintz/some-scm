#lang racket

(require "util.rkt")
(require "vector.rkt")
(require "polyline.rkt")

;;;; parallelogram ;;;;

; a parallelogram is a pair of one apex point, plus a pair of vectors which define its sides
; some of these functions assume that side2 is oriented counterclockwise relative to side1
(define (pgram pt side1 side2)
  (cons pt (cons side1 side2)))

(define (pgram-eq? p1 p2)
  (and (vec-eq? (apex p1) (apex p2)) (vec-eq? (side-1 p1) (side-1 p2)) (vec-eq? (side-2 p1) (side-2 p2))))

(define (apex plg)
  (car plg))

(define (side-1 plg)
  (car (cdr plg)))

(define (side-2 plg)
  (cdr (cdr plg)))

; "center" diagonal, i.e. the diagonal from the apex point to the opposite point
(define (pgram-center-diagonal plg)
  (vec+ (side-1 plg) (side-2 plg)))

; "off" diagonal, i.e. the diagonal between the endpoints of the two side vectors
(define (pgram-off-diagonal plg)
  (vec- (side-1 plg) (side-2 plg)))

; vertices in clockwise order
(define (pgram-v1 plg)
  (apex plg))

(define (pgram-v2 plg)
  (vec+ (pgram-v1 plg) (side-1 plg)))

(define (pgram-v3 plg)
  (vec+ (vec+ (pgram-v1 plg) (side-1 plg)) (side-2 plg)))

(define (pgram-v4 plg)
  (vec+ (pgram-v1 plg) (side-2 plg)))

(define (pgram-vertices plg)
  (list (pgram-v1 plg) (pgram-v2 plg) (pgram-v3 plg) (pgram-v4 plg)))

; segments of the parallelogram
(define (pgram-segments plg)
  (let ([p1 (pgram-v1 plg)]
        [p2 (pgram-v2 plg)]
        [p3 (pgram-v3 plg)]
        [p4 (pgram-v4 plg)])
  (list (segment p1 p2) (segment p2 p3) (segment p3 p4) (segment p4 p1))))

; construct an axis-aligned parallelogram (ok, it's a rectangle) from a center point, a width, and a height
(define (pgram-from-center center width height)
  (pgram (vec-scalar- center (/ width 2) (/ height 2)) (vec 0 height) (vec width 0)))

; construct an axis-aligned parallelogram from a top left position, a width, and a height
(define (pgram-from-pos top-left width height)
  (pgram top-left (vec 0 height) (vec width 0)))

(provide (all-defined-out))
