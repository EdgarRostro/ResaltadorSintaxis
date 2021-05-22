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

  (let loop ([file (file->string in-file-path)] [output-file (string-append (car (regexp-match #px"^[\\w,\\s-]+" in-file-path)) ".html")]) 
    (cond 
      [(regexp-match? #px"^\\{" file)
        (display-to-file 
          (string-append "\t<div>\n\t<span class=\"Parentesis\">" (car (regexp-match #px"^\\{" file)) "</span><br>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\{"
        file)))) output-file)]

      [(regexp-match? #px"^\\}" file)
        (display-to-file 
          (string-append "\t<br><span class=\"Parentesis\">" (car (regexp-match #px"^\\}" file)) "</span>\n\t</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\}"
        file)))) output-file)]

      [(regexp-match? #px"^\\[" file) 
        (display-to-file 
          (string-append "\t<div>\n\t<span class=\"Corchetes\">" (car (regexp-match #px"^\\[" file)) "</span><br>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\[" file)))) output-file)]

      [(regexp-match? #px"^\\]" file)
        (display-to-file 
          (string-append "\t<br><span class=\"Corchetes\">" (car (regexp-match #px"^\\]" file)) "</span>\n\t</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\]"
        file)))) output-file)]

      [(regexp-match? #px"^\\," file) 
        (display-to-file 
          (string-append "\t<span class=\"Coma\">" (car (regexp-match #px"^\\," file)) "</span><br>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\," file)))) output-file )]

      [(regexp-match? #px"^\\:" file) 
        (display-to-file 
          (string-append "\t<span class=\"DosP\">" (car (regexp-match #px"^\\:" file)) "</span>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\:" file)))) output-file )]

      [(regexp-match? #px"^[\\d\\.Ee+-]+\\d" file) 
        (display-to-file 
          (string-append "\t<span class=\"Numero\">" (car (regexp-match #px"^[\\d\\.Ee+-]+\\d" file)) "</span>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^[\\d\\.Ee+-]+\\d" file)))) output-file )]

      [(regexp-match? #px"^false|^true|^null" file) 
        (display-to-file 
          (string-append "\t<span class=\"Bool\">" (car (regexp-match #px"^false|true|null" file)) "</span>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^false|true|null" file)))) output-file )]

      [(regexp-match? #px"^(\".[^\"]+\")\\s*\\:" file) 
        (display-to-file 
          (string-append "\t<span class=\"Text1\">" (cadr (regexp-match #px"^(\".[^\"]+\")\\s*\\:" file)) "</span>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (cadr (regexp-match #px"^(\".[^\"]+\")\\s*\\:" file)))) output-file )]
      
      [(regexp-match? #px"^\".[^\"]+\"" file) 
        (display-to-file 
          (string-append "\t<span class=\"Text\">" (car (regexp-match #px"^\".[^\"]+\"" file)) "</span>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\".[^\"]+\"" file)))) output-file )]

        [(regexp-match? #px"^\\s+" file) 
        ; (display-to-file 
        ;   (string-append "\t<span class=\"Espacio\">" (car (regexp-match #px"^\\s+" file)) "</span>\n")
        ;   output-file
        ;   #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\s+" file)))) output-file )]
        
        [(zero? (string-length file)) 
          (display-to-file 
            "</body>\n</html>"
            output-file
            #:exists 'append)]
        )))

; [(regexp-match? #px"^(\"[\\w,.:()+;*/\\s-]+\")\\s*\\:" file) 
;         (display-to-file 
;           (string-append "\t<span class=\"Text1\">" (cadr (regexp-match #px"^(\"[\\w,.:()+;*/\\s-]+\")\\s*\\:" file)) "</span>\n")
;           output-file
;           #:exists 'append)
;         (loop (substring file (string-length (cadr (regexp-match #px"^(\"[\\w,.:()+;*/\\s-]+\")\\s*\\:()" file)))) output-file )]
      
;       [(regexp-match? #px"^\"[\\w,.:()+;*/\\s-]+\"" file) 
;         (display-to-file 
;           (string-append "\t<span class=\"Text\">" (car (regexp-match #px"^\"[\\w,.:()+;*/\\s-]+\"" file)) "</span>\n")
;           output-file
;           #:exists 'append)
;         (loop (substring file (string-length (car (regexp-match #px"^\"[\\w,.:()+;*/\\s-]+\"" file)))) output-file )]

; [(regexp-match? #px"^\\s+" file) 
;         (display-to-file 
;           (string-append "\t<span class=\"Espacio\">" (car (regexp-match #px"^\\s+" file)) "</span>\n")
;           output-file
;           #:exists 'append)
;         (loop (substring file (string-length (car (regexp-match #px"^\\s+" file)))) output-file )]