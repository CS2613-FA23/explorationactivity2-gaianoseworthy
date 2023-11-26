#lang racket/base

;First let's import the gui-easy packages
(require racket/gui/easy
         racket/gui/easy/operator)

;Now define a counter as a panel with a minus button, text, and a a plus button
(define (counter @c action)
  (hpanel
   (button "-" (@c . λ<~ . sub1))
   (text (@c . ~> . number->string))
   (button "+" (@c . λ<~ . add1))))

;Now define two counters using the method above
(define @c1 (@ 0))
(define @c2 (@ 0))

;Now define a window with a title, some basic text, two counters with text
;between the counters, and some text at the end
(render
 (window #:title "Basic Racket Example"
  (vpanel
   (text "Hello, World! \nWelcome to a basic GUI example using counters!")
   (hpanel
    (counter @c1 (lambda (proc) (@c1 . <~ . proc)))
    (text "With some text in the middle!")
    (counter @c2 (lambda (proc) (@c2 . <~ . proc))))
   (text "And some text at the end!"))))
