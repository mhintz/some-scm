#lang racket

(require "vector.rkt")

;;;; parallelogram ;;;;

; a parallelogram is a pair of one apex point, plus a pair of vectors which define its sides
; some of these functions assume that side2 is oriented counterclockwise relative to side1
(define (pgram pt side1 side2)
  (cons pt (cons side1 side2)))

(define (side-1 plg)
  (car (cdr plg)))

(define (side-2 plg)
  (cdr (cdr plg)))

; vertices in clockwise order
(define (pgram-v1 plg)
  (car plg))

(define (pgram-v2 plg)
  (vec+ (pgram-v1 plg) (side-1 plg)))

(define (pgram-v3 plg)
  (vec+ (vec+ (pgram-v1 plg) (side-1 plg)) (side-2 plg)))

(define (pgram-v4 plg)
  (vec+ (pgram-v1 plg) (side-2 plg)))

(define (pgram-vertices plg)
  (list (pgram-v1 plg) (pgram-v2 plg) (pgram-v3 plg) (pgram-v4 plg)))

; construct an axis-aligned parallelogram (ok, it's a rectangle) from a center point, a width, and a height
(define (pgram-from-center center width height)
  (pgram (vec-scalar- center (/ width 2) (/ height 2)) (vec 0 height) (vec width 0)))

; construct an axis-aligned parallelogram from a top left position, a width, and a height
(define (pgram-from-pos top-left width height)
  (pgram top-left (vec 0 height) (vec width 0)))

(provide
  pgram
  side-1
  side-2
  pgram-v1
  pgram-v2
  pgram-v3
  pgram-v4
  pgram-vertices
  pgram-from-center
  pgram-from-pos)
