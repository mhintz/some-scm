#lang racket

;;;; math functions ;;;;

(define 2pi (* 2 pi))

(define (!= a b) (not (= a b)))

(define (is-between? val a b)
  (and (<= a val) (<= val b)))

(provide
  2pi
  !=
  is-between?)
