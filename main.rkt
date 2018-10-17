#lang racket

(require racket/draw)
(require racket/math)

(require "./utilities.rkt")
(require "./math.rkt")
(require "./vector.rkt")
(require "./polyline.rkt")
(require "./circle.rkt")
(require "./draw.rkt")

; (require "./drawings/shaky-squares.rkt")
(require "./drawings/funky-circles.rkt")

(define *filename* (string-append "out/" *drawing-name* ".svg"))

; A3 settings -  width / height in points
(define *width-pt* 842)
(define *height-pt* 1190)
; US Ledger settings (11" x 17") - width / height in points
; (define *width-pt* 792)
; (define *height-pt* 1224)

; scale factor between points and millimeters
(define *scale-x* (/ 72 25.4))
(define *scale-y* (/ 72 25.4))
; width / height in millimeters
(define *width-mm* (/ *width-pt* *scale-x*))
(define *height-mm* (/ *height-pt* *scale-y*))

(define cx (new svg-dc% [width *width-pt*] [height *height-pt*] [output *filename*] [exists 'replace]))
(define pen-main (new pen% [color (make-color 0 0 0)] [width 0.5] [style 'solid]))
(define brush-main (make-brush #:style 'transparent))

(define (setup)
  (send cx start-doc "starting doc")
  (send cx start-page)
  (send cx scale *scale-x* *scale-y*) ; this scales everything into millimeters
  (send cx set-smoothing 'smoothed)
  (send cx set-pen pen-main)
  (send cx set-brush brush-main))

(define (teardown)
  (send cx end-page)
  (send cx end-doc))

(module+ main
  (setup)
  (draw-drawing cx *width-mm* *height-mm*)
  (teardown))
