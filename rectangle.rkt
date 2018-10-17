#lang racket

(require "./vector.rkt")

;;;; rectangle ;;;;

; rectangle is a pair of min point and max point (top left and bottom right)
(define (rectangle minpt maxpt)
  (cons minpt maxpt))

(define (rmin rect)
  (car rect))

(define (rmax rect)
  (cdr rect))

; construct a rectangle from a center point, a width, and a height
(define (rectangle-from-center center width height)
  (let* ([half-width (/ width 2)]
         [half-height (/ height 2)]
         [minpt (vec-scalar- center half-width half-height)]
         [maxpt (vec-scalar+ center half-width half-height)])
     (rectangle minpt maxpt)))

; construct a rectangle from a top left position, a width, and a height
(define (rectangle-from-pos top-left width height)
  (rectangle top-left (vec-scalar+ top-left width height)))

(define (rw rect)
  (- (vx (rmax rect) (rmin rect))))

(define (rh rect)
  (- (vy (rmax rect) (rmin rect))))

#| (define (rectangle-rectangle-intersect? r1 r2) |#
#|   ) |#

(provide
  rectangle
  rmin
  rmax
  rectangle-from-center
  rectangle-from-pos
  rw
  rh)
  #| rectangle-rectangle-intersect?) |#
