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
      [(regexp-match? #px"^[{}]" file)
        (display-to-file 
          (string-append "\t<div class=\"Parentesis\">" (car (regexp-match #px"^[{}]" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^[{}]"
        file)))) output-file)]

      [(regexp-match? #px"^[\\[\\]]" file) 
        (display-to-file 
          (string-append "\t<div class=\"Corchetes\">" (car (regexp-match #px"^[\\[\\]]" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^[\\[\\]]" file)))) output-file)]

      [(regexp-match? #px"^\\," file) 
        (display-to-file 
          (string-append "\t<div class=\"Coma\">" (car (regexp-match #px"^\\," file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\," file)))) output-file )]

      [(regexp-match? #px"^\\:" file) 
        (display-to-file 
          (string-append "\t<div class=\"DosP\">" (car (regexp-match #px"^\\:" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\:" file)))) output-file )]

      [(regexp-match? #px"^[\\d\\.Ee+-]+\\d" file) 
        (display-to-file 
          (string-append "\t<div class=\"Numero\">" (car (regexp-match #px"^[\\d\\.Ee+-]+\\d" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^[\\d\\.Ee+-]+\\d" file)))) output-file )]

      [(regexp-match? #px"^false|^true|^null" file) 
        (display-to-file 
          (string-append "\t<div class=\"Bool\">" (car (regexp-match #px"^false|true|null" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^false|true|null" file)))) output-file )]

      [(regexp-match? #px"^(\"[\\w,.:()+;*/\\s-]+\")\\s*\\:" file) 
        (display-to-file 
          (string-append "\t<div class=\"Text1\">" (cadr (regexp-match #px"^(\"[\\w,.:()+;*/\\s-]+\")\\s*\\:" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (cadr (regexp-match #px"^(\"[\\w,.:()+;*/\\s-]+\")\\s*\\:()" file)))) output-file )]
      
      [(regexp-match? #px"^\"[\\w,.:()+;*/\\s-]+\"" file) 
        (display-to-file 
          (string-append "\t<div class=\"Text\">" (car (regexp-match #px"^\"[\\w,.:()+;*/\\s-]+\"" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\"[\\w,.:()+;*/\\s-]+\"" file)))) output-file )]

        [(regexp-match? #px"^\\s+" file) 
        (display-to-file 
          (string-append "\t<div class=\"Espacio\">" (car (regexp-match #px"^\\s+" file)) "</div>\n")
          output-file
          #:exists 'append)
        (loop (substring file (string-length (car (regexp-match #px"^\\s+" file)))) output-file )]
        
        [(zero? (string-length file)) 
          (display-to-file 
            "</body>\n</html>"
            output-file
            #:exists 'append)]
        )))

