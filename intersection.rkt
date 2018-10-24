#lang racket

(require "util.rkt")
(require "vector.rkt")
(require "polyline.rkt")
(require "circle.rkt")
(require "pgram.rkt")

; determine if two line segments intersect with each other
; based on https://stackoverflow.com/a/565282
(define (segment-intersect? segA segB)
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
      (or (is-between? t0 0 1) (is-between? t1 0 1))))
    (let ([u (/ uNumer denom)]
          [t (/ tNumer denom)])
    ; determines overlap for non-parallel
    (if (and (is-between? t 0 1) (is-between? u 0 1))
      ; not parallel, intersecting
      #t
      ; not parallel, not intersecting
      #f)))))

; test if two circles intersect
(define (circle-circle-intersect? c1 c2)
  (<= (vec-distance (cc c1) (cc c2)) (+ (cr c1) (cr c2))))

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


(provide (all-defined-out))
