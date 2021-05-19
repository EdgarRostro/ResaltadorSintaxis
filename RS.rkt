#lang racket

(provide main)

(define (main head in-file-path)
  " Receives the names of the files to read and write "
  (display-lines-to-file
    (file->lines head)
    (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
    #:exists 'truncate)
  )

; (define (main in-file-path)
;   " Receives the names of the files to read and write "
;   (display-to-file
;     "<!DOCTYPE html>
; <html lang='en'>
; <head>
;   <meta charset='UTF-8'>
;   <meta http-equiv='X-UA-Compatible' content='IE=edge'>
;   <meta name='viewport' content='width=device-width, initial-scale=1.0'>
;   <title>Document</title>
; </head>
; <body>"
;     (string-append (split-file-extension in-file-path) ".html")
;     #:exists 'truncate))
