#lang racket

(define (pt x y)
  '(x y))

(define (px p)
  (car p))

(define (py p)
  (car (cdr p)))

(define (segment-intersect segA segB)
  '())

(define (intersects polyA polyB)
  '())

(provide
  pt
  px
  py
  segment-intersect
  intersects)
