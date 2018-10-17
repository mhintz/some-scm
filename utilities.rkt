#lang racket

;;;; Various functional utilities ;;;;

(define (>partial f . pargs)
  ;;; Partially apply the args pargs on the left of the argument list of f.
  (lambda args
    (apply f (append pargs args))))

(define (partial< f . pargs)
  ;;; Partially apply the args pargs on the right of the argument list of f.
  (lambda args
    (apply f (append args pargs))))

(define (all lst)
  ;;; Returns true if all elements in list are true
  (foldl (lambda (it ac) (and ac it))
     (car lst)
     (cdr lst)))

(define (map-pair fn p1)
  (cons (fn (car p1)) (fn (cdr p1))))

(define (map-pairs fn p1 p2)
  (cons (fn (car p1) (car p2)) (fn (cdr p1) (cdr p2))))

(define (println . args)
  (map display args)
  (newline))

(provide
  >partial
  partial<
  all
  map-pair
  map-pairs
  println)
