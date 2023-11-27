#lang racket/base

(require racket/format
         racket/gui/easy
         racket/gui/easy/operator
         racket/math)

(define/obs @elapsed 0)
(define/obs @duration 10)
(define/obs @run 0)
(define/obs @adder 0.1)

(define runThread
(thread
 (λ ()
   (let loop ()
     (cond
      [(positive? (obs-peek @run))
     (@elapsed . <~ . (λ (e)
                        (define d (obs-peek @duration))
                        (define next-e (+ e (obs-peek @adder)))
                        (if (< next-e d) next-e d)))])
     (sleep 0.1)
     (loop)))))

(define (~seconds s)
  (~a (~r #:precision '(= 2) s) "s"))

(render
 (window
  #:title "Timer"
  (hpanel
   (text "Elapsed time:")
   (progress #:range (@duration . ~> . (λ (d) (* d 10))) (@elapsed . ~> . (λ (e) (exact-round (* e 10)))))
   (text (@elapsed . ~> . ~seconds)))
  (hpanel
   (spacer)
   (text "Duration:")
   ( button "+5s" (λ () (@duration . := . ( + (obs-peek @duration) 5))))
   ( button "+15s" (λ () (@duration . := . ( + (obs-peek @duration) 15))))
   ( button "+30s" (λ () (@duration . := . ( + (obs-peek @duration) 30))))
   ( button "Reset" (λ () (@duration . := . 10)))
   (spacer))
  (hpanel
   (spacer)
   (text "Current Max Duration:")
   (text (@duration . ~> . ~seconds))
   (spacer))
  (hpanel
   (spacer)
   (button "Start" (lambda () (@run . := . 1)))
   (button "Stop" (lambda () (@run . := . 0)))
   (button "Restart" (λ () (@elapsed . := . 0)))
   (spacer))))
