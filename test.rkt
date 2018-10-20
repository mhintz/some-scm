#lang racket

(require rnrs/base-6)

(require "vector.rkt")
(require "polyline.rkt")
(require "pgram.rkt")

; tests for segment-intersect
(assert (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))))
(assert (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))))
(assert (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 1 0) (vec 0 1))))
(assert (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 0 1))))
(assert (segment-intersect (segment (vec 0 0) (vec 1 1)) (segment (vec 0.5 0.5) (vec 1.5 1.5))))

(assert ())
