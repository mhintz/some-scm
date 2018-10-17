#lang racket

(require "./utilities.rkt")
(require "./math.rkt")
(require "./vector.rkt")

;;;; line segment ;;;;

(define (segment v1 v2)
  (list v1 v2))

(define (seg-start seg)
  (car seg))

(define (seg-end seg)
  (cadr seg))

(define (segment? seg)
  (and (= 2 (length seg)) (all (map vec? seg))))

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
      (or (is-between? t0 0 1) (is-between? t1 0 1))))
    (let ([u (/ uNumer denom)]
          [t (/ tNumer denom)])
    ; determines overlap for non-parallel
    (if (and (is-between? t 0 1) (is-between? u 0 1))
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
  segment
  seg-start
  seg-end
  segment->vec
  segment-intersect)

