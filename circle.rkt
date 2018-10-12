#lang racket

(require "./vector.rkt")

;;;; circle ;;;;

(define (circle center rad)
  (list center rad))

(define (cx circ)
  (car (car circ)))

(define (cy circ)
  (cdr (car circ)))

(define (cr circ)
  (car (cdr circ)))

(define (circle-pos circ ang)
  (vec (+ (cx circ) (* (cr circ) (cos ang)))
       (+ (cy circ) (* (cr circ) (sin ang)))))

(provide
  circle
  cx
  cy
  cr
  circle-pos)
