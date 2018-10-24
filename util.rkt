#lang racket

;;;; math functions ;;;;

(define 2pi (* 2 pi))

(define (!= a b) (not (= a b)))

(define (is-between? val a b)
  (and (<= a val) (<= val b)))

(define (rand-in a b)
  (+ a (* (random) (- b a))))

;;;; Various functional utilities ;;;;

(define (println . args)
  (map display args)
  (newline))

(provide (all-defined-out))
