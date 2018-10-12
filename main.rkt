#lang racket

(require racket/draw)
(require racket/math)

(require "./utilities.rkt")
(require "./math.rkt")
(require "./vector.rkt")
(require "./segment.rkt")
(require "./circle.rkt")
(require "./draw.rkt")

(require "./drawings/shaky-squares.rkt")

(define *filename* (string-append "out/" *drawing-name* ".svg"))
(define *width* 842)
(define *height* 1190)

(define cx (new svg-dc% [width *width*] [height *height*] [output *filename*] [exists 'replace]))
(define pen-main (new pen% [color (make-color 0 0 0)] [width 0.5] [style 'solid]))
(define brush-main (make-brush #:style 'transparent))

(define (setup)
  (send cx start-doc "")
  (send cx start-page)
  (send cx scale (/ 72 25.4) (/ 72 25.4))
  (send cx set-pen pen-main)
  (send cx set-brush brush-main))

(define (teardown)
  (send cx end-page)
  (send cx end-doc))

(module+ main
  (setup)
  (draw-drawing cx *width* *height*)
  (teardown))
