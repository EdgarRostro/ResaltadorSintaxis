#|  
{}  {|}     ok
[]  \\[|]   ok
, : \\: \\, ok
"string": "string2"  ^\\"[\\w,\\s-]+\\" ok 
8127    \\d+ ok  
false, true, null  false true null
|#

#lang racket

(provide main)

(define (main head in-file-path)
  " Receives the names of the files to read and write "
  (display-lines-to-file
    (file->lines head)
    (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
    #:exists 'truncate)

  (let loop ([file (file->string in-file-path)]) 
    (cond 
      [(regexp-match? #px"[\\{\\}]" file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"[{}]" file)) "</div>\n")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"[{}]"
        file)))))]

      [(regexp-match? #px"[\\[\\]]" file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"[\\[\\]]" file)) "</div>\n")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"[\\[\\]]" file)))))]

      [(regexp-match? #px"\\," file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"\\," file)) "</div>\n")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"\\," file)))))]

      [(regexp-match? #px"\\:" file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"\\:" file)) "</div>\n")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"\\:" file)))))]

      [(regexp-match? #px"\\d+" file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"\\d+" file)) "</div>\n")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"\\d+" file)))))]

      [(regexp-match? #px"false|true|null" file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"false|true|null" file)) "</div>\n")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"false|true|null" file)))))]

      [(regexp-match? #px"(\"[\\w,\\s-]+\")\\s*\\:" file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"(\"[\\w,\\s-]+\")\\s*\\:" file)) "</div>\n")
          (string-append (cdr (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"(\"[\\w,\\s-]+\")\\s*\\:" file)))))]
      
      [(regexp-match? #px"\"[\\w,\\s-]+\"" file) 
        (display-to-file 
          (string-append "\t<div class=\"texto\">" (car (regexp-match #px"\"[\\w,\\s-]+\"" file)) "</div>\n")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"\"[\\w,\\s-]+\"" file)))))]

        [(regexp-match? #px"\\s+" file) 
        (display-to-file 
          (string-append "\n\t<div class=\"texto\">" (car (regexp-match #px"\\s+" file)) "</div>")
          (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
          #:exists 'append)
        (loop (substring file (- 1 (caar (regexp-match-positions #px"\\s+" file)))))]
        
        [(zero? (string-length file)) 
          (display-to-file 
            "</body>\n</html>"
            (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")
            #:exists 'append)]
        )))

