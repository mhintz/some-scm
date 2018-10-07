(use
  cairo
  miscmacros
  random-bsd
  srfi-1
  srfi-4
  srfi-13
  lolevel
)

(load "math.scm")

(define *rotation* 2)
(define *delta* 5.8)
(define *width* 18)
(define *height* 26)
(define *box-size* 15)

(define s (cairo-svg-surface-create "test.svg" 842 1190))
(define c (cairo-create s))

(define (setup)
  (cairo-scale c (/ 72 25.4) (/ 72 25.4)))

(define (draw-main)
  (dotimes (y *height*)
    (dotimes (x *width*)
      (cairo-save c)
      (cairo-set-line-width c 0.3)
      (cairo-translate c (+ 12 (* x *box-size*)) (+ 16 (* y *box-size*)))
      (cairo-rotate c (* (if (> 1 (random-integer 2)) -1 1)
                         (/ cairo-pi 180)
                         (* *rotation* (random-real))))
      (cairo-rectangle c 0 0 *box-size* *box-size*)
      (cairo-set-source-rgba c 0 0 0 1)
      (cairo-stroke c)
      (cairo-restore c)
    )
    (set! *rotation* (+ *rotation* *delta*))
  ))

(define (teardown)
  (cairo-surface-show-page s)
  (cairo-destroy c)
  (cairo-surface-finish s)
  (cairo-surface-destroy s))

(define (main args)
  (setup)
  (draw-main)
  (teardown)
)

