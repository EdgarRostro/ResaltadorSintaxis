#|  
Rafael Eduardo Rios Garcia 	A01028722
Edgar Ivan Rostro Morales 	A01029036
Ivan David Manzano Hormaza 	A01029111
|#

#lang racket

(provide main)

(define (main directory cores)
  (let*
  ([bloque (ceiling (/ (length (directory-list directory)) cores))]
  [filel (makelstfiles bloque directory)])
  (define futures (map make-future filel))
  (map touch futures))
)

(define (makelstfiles bloque directory)
  (let loop 
    ([fileslst empty] 
    [files (extractfiles directory)])
    (if (< (length files) bloque)
      (append fileslst (list files))
      (let-values ([(primerb resto) (split-at files bloque)])          
        (loop (append fileslst (list primerb)) resto)
      )
    )
  )
) 

(define (extractfiles directory)
  (filter (lambda (_file)
   (regexp-match? #px"\\.json$" _file)) (map (lambda (file_) (string-append directory "/" file_)) (map path->string (directory-list directory))))
)

(define (make-future lstfiles)
  (future 
    (lambda()
      (map sintax lstfiles)
    )
  )
)

(define (sintax in-file-path)
  (let loop ([file (file->string in-file-path)] [stringTotal (file->string "html.txt")])
    (if (zero? (string-length file))
      (writeFile stringTotal in-file-path)
      (let ([match
        (cond 
          [(regexp-match? #px"^[\\{\\}]" file)
          (list (car(regexp-match #px"^[\\{\\}]" file)) "Llave")]

          [(regexp-match? #px"^[\\[\\]]" file) 
          (list (car(regexp-match #px"^[\\[\\]]" file)) "Corchete")]

          [(regexp-match? #px"^\\," file) 
          (list (car(regexp-match #px"^\\," file)) "Coma")]

          [(regexp-match? #px"^\\:" file) 
          (list (car(regexp-match #px"^\\:" file)) "DosP")]

          [(regexp-match? #px"^[\\d\\.Ee+-]+" file) 
          (list (car(regexp-match #px"^[\\d\\.Ee+-]+" file)) "Numero")]

          [(regexp-match? #px"^false|^true|^null" file) 
          (list (car(regexp-match #px"^false|^true|^null" file)) "Bool")]

          [(regexp-match? #px"^(\".[^\"]+\")\\s*\\:" file) 
          (list (car(regexp-match #px"^(\".[^\"]+\")\\s*\\:" file)) "Text1")]
        
          [(regexp-match? #px"^\"[^\"]+\"|^\"[^\"]{0}\"" file) 
          (list (car(regexp-match #px"^\"[^\"]+\"|^\"[^\"]{0}\"" file)) "Text")]
          
          [(regexp-match? #px"^\\s+" file)
          (list (car(regexp-match #px"^\\s+" file)) "Espacio")]
          
        )])
      (loop (substring file (string-length (car match))) (createBody stringTotal (cadr match) (car match))))
    )
  )
)

(define (createBody stringTotal tipo token)
    (string-append stringTotal "<span class=\"" tipo "\">" token "</span>")
)

(define (writeFile stringFile in-file-path)
    (display-to-file
      (string-append stringFile "\n</pre>\n</body>\n</html>")
      (string-append (caddr (regexp-match #px"^(.+\\/)*(.+)\\.(.+)$" in-file-path)) ".html")
      #:exists 'truncate)
)
