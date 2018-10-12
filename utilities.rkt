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

(define (println arg)
  (display arg)
  (newline))

(provide
  >partial
  partial<
  all
  println)
