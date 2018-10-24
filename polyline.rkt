#lang racket

(require "util.rkt")
(require "vector.rkt")

;;;; line segment ;;;;

(define (segment v1 v2)
  (list v1 v2))

(define (seg-start seg)
  (car seg))

(define (seg-end seg)
  (cadr seg))

(define (segment? seg)
  (and (= 2 (length seg)) (andmap identity (map vec? seg))))

; segment-to-vector
(define (segment->vec seg)
  (vec- (seg-end seg) (seg-start seg)))

;;;; polyline ;;;;

; a polyline is just a list of vectors
(define (polyline . args)
  args)

(define (polyline-push poly vert)
  (append poly (list vert)))

(provide (all-defined-out))
