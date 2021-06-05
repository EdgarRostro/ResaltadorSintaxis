# RESALTADOR DE SINTAXIS
 ### Rafael Eduardo Rios Garcia A01028722
 ### Edgar Ivan Rostro Morales A01029036
 ### Ivan David Manzano Hormaza A01029111
 
 # Actividad Integradora 5.3: Resaltador de Sintaxis Paralelo 
  
 ***

 | Programacion Recurrente | Programacion Paralela | Speedup(Sp=t1/t2) |
 |:---:|:---:|:---:|
 | 31.2 segundos | 33.4 segundos(12 cores) | S12=(31.2s/33.4s)=0.93 |
 | 32.7 segundos | 34 segundos(10 cores) | S10=(32.7s/34s)=0.96 |
 | 32.7 segundos | 34.1 segundos(8 cores) | S8=(32.7s/34.1s)=0.95 |
 | 32.1 segundos | 35.6 segundos(6 cores) | S6=(32.1s/35.6s)=0.9 |
 | 31.9 segundos | 36.6 segundos(4 cores) | S4=(31.9s/36.6s)=0.87 |

 ### Análisis Resultados
 >> En casos como estos donde queremos analizar varios archivos de gran tamaño, es bastante útil la programación funcional, ya que permite analizar al mismo tiempo estos archivos. Sin embargo, debido a un problema por parte de Racket, no se pudo apreciar un funcionamiento correcto por parte de la implementación paralela. A pesar de estas dificultades analizamos los resultados obtenidos al correr estos códigos, por el lado de la implementación convencional tenemos tiempos entre los 31-33 segundos, mientras que con la implementación paralela empezamos con un valor cercano a los 33 segundos cuando seleccionamos 12 cores para trabajar, los segundos aumentan mientras bajamos los cores, llegando hasta valores cercanos a los 37 segundos con 4 cores, creemos que esto se debe a que aunque no se usen paralelamente los cores, se crean los “futures”(función de racket para definir de qué manera usar los cores definidos), haciendo más complejo y tardado el sistema.
  
 ### Complejidad Algorítmica 
 >> La complejidad algorítmica es bastante diferente de la que se tendría en un lenguaje orientado a objetos ya que al ser funcional, la recursión no solo es necesaria sino obligatoria. La complejidad algorítmica en Big O notation es O(n3)principalmente por la manera en la cual se hace la búsqueda de los tokens y se catalogan. Esto es algo que se podría mejorar junto con el ocupamiento de varios cores para mejor trabajo en paralelo en un futuro.

 ### Implicaciones Éticas
 >> En casos como estos donde queremos analizar varios archivos de gran tamaño, es bastante útil la programación funcional, ya que permite analizar al mismo tiempo estos archivos. Sin embargo, debido a un problema por parte de Racket, no se pudo apreciar un funcionamiento correcto por parte de la implementación paralela. A pesar de estas dificultades analizamos los resultados obtenidos al correr estos códigos, por el lado de la implementación convencional tenemos tiempos entre los 31-33 segundos, mientras que con la implementación paralela empezamos con un valor cercano a los 33 segundos cuando seleccionamos 12 cores para trabajar, los segundos aumentan mientras bajamos los cores, llegando hasta valores cercanos a los 37 segundos con 4 cores, creemos que esto se debe a que aunque no se usen paralelamente los cores, se crean los “futures”(función de racket para definir de qué manera usar los cores definidos), haciendo más complejo y tardado el sistema.
