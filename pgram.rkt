#lang racket

(require "math.rkt")
(require "vector.rkt")
(require "polyline.rkt")
(require "utilities.rkt")

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

; test if a point lies inside the parallelogram
(define (pgram-vec-intersect? plg v)
  (let* ([p (vec- v (apex plg))]
        [a (side-1 plg)]
        [b (side-2 plg)]
        [aXp (vec-cross a p)]
        [bXp (vec-cross b p)]
        [aXb (vec-cross a b)]
        [h (/ aXp aXb)]
        [l (/ bXp (- aXb))])
    (and (is-between? h 0 1) (is-between? l 0 1))))

; test if two parallelograms intersect, using up 8 point-parallelogram intersection tests and 16 segment-segment tests between their edges
(define (pgram-intersect? p1 p2)
  (let ([p1-verts (pgram-vertices p1)]
        [p2-verts (pgram-vertices p2)]
        [map-against-other (lambda (seg other-segs)
                             (ormap (lambda (other-seg) (segment-intersect? other-seg seg)) other-segs))])
    (or (ormap (lambda (p) (pgram-vec-intersect? p1 p)) p2-verts)
        (ormap (lambda (p) (pgram-vec-intersect? p2 p)) p1-verts)
        (let ([p1-segs (pgram-segments p1)]
              [p2-segs (pgram-segments p2)])
              (ormap (lambda (seg1) (map-against-other seg1 p2-segs)) p1-segs)))))

(provide
  pgram
  pgram-eq?
  apex
  side-1
  side-2
  pgram-center-diagonal
  pgram-off-diagonal
  pgram-v1
  pgram-v2
  pgram-v3
  pgram-v4
  pgram-vertices
  pgram-from-center
  pgram-from-pos
  pgram-vec-intersect?
  pgram-intersect?)
