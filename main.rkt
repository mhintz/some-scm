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
; (require "./drawings/funky-circles.rkt")
(require "drawings/funky-rects.rkt")

(define *filename* (string-append "out/" *drawing-name* ".svg"))

; A3 settings -  width / height in points (297 x 420 mm)
(define *width-pt* 842)
(define *height-pt* 1190)
; US Ledger settings (11" x 17") - width / height in points (279.4 x 431.8 mm)
; (define *width-pt* 792)
; (define *height-pt* 1224)

; scale factor between points and millimeters
(define *scale-x* (/ 72 25.4))
(define *scale-y* (/ 72 25.4))
; width / height in millimeters
(define *width-mm* (/ *width-pt* *scale-x*))
(define *height-mm* (/ *height-pt* *scale-y*))

(define ctx (new svg-dc% [width *width-pt*] [height *height-pt*] [output *filename*] [exists 'replace]))
(define pen-main (new pen% [color (make-color 0 0 0)] [width 0.5] [style 'solid]))
(define brush-main (make-brush #:style 'transparent))

(define (setup)
  (send ctx start-doc "starting doc")
  (send ctx start-page)
  (send ctx scale *scale-x* *scale-y*) ; this scales everything into millimeters
  (send ctx set-smoothing 'smoothed)
  (send ctx set-pen pen-main)
  (send ctx set-brush brush-main))

(define (teardown)
  (send ctx end-page)
  (send ctx end-doc))

(module+ main
  (setup)
  (draw-drawing ctx *width-mm* *height-mm*)
  (teardown))
