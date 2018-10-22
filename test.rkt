#lang racket

(require rnrs/base-6)

(require "vector.rkt")
(require "polyline.rkt")
(require "pgram.rkt")

; tests for segment-intersect?
(assert (segment-intersect? (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))))
(assert (segment-intersect? (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))))
(assert (segment-intersect? (segment (vec 0 0) (vec 1 1)) (segment (vec 1 0) (vec 0 1))))
(assert (segment-intersect? (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 0 1))))
(assert (segment-intersect? (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))))

; tests for pgram-vec-intersect?
(define test-p1 (pgram (vec 0 0) (vec 2 0) (vec 0 2)))
(assert (pgram-vec-intersect? test-p1 (vec 1 1)))
(assert (pgram-vec-intersect? test-p1 (vec 2 2)))
(assert (pgram-vec-intersect? test-p1 (vec 1.5 1.5)))
(assert (pgram-vec-intersect? test-p1 (vec 0 0)))
(define test-p2 (pgram (vec 1 1) (vec 2 0) (vec 0 2)))
(assert (pgram-intersect? test-p1 test-p2))
(define test-p3 (pgram (vec 5 5) (vec 1 0) (vec 0 2)))
(assert (not (pgram-intersect? test-p1 test-p3)))
(define test-p4 (pgram (vec 1.5 0) (vec 0.5 0) (vec 0 4)))
; vertices don't intersect, but sides do
(assert (pgram-intersect? test-p2 test-p4))
