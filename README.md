# RESALTADOR DE SINTAXIS
 ### Rafael Eduardo Rios Garcia A01028722
 ### Edgar Ivan Rostro Morales A01029036
 ### Ivan David Manzano Hormaza A01029111
 
 # Actividad Integradora 3.4: Reporte
  
 ***
   
 > - Reflexiona sobre la solución planteada, los algoritmos >implementados y sobre el tiempo de ejecución de estos.
 >>La solución que planteamos fue realizar un loop en Racket que leyera el archivo que se le diera teniendo en cuenta unas condiciones establecidas dentro de la misma función. A pesar de  ello, pudimos mejorar el algoritmo al tener una expresión regular  definida por fuera de las condiciones para así disminuir la  cantidad de código y probablemente el tiempo de ejecución del  mismo. El tiempo de ejecucion del sistema es intermedio ya que aunque no es instantaneo dura menos de 3 segundos en todas las pruebas hechas.
  
 > - Calcula la complejidad de tu algoritmo basada en el número de iteraciones y contrástala con el tiempo obtenido en el punto 7.
 >>La complejidad del algoritmo es de O(n^2) ya que el código itera por cada elemento separado mas de una vez. Sin  embargo, el código no es tan eficiente como podría ser, ya que  cada vez que encontramos un elemento abrimos el archivo, copiamos el texto, y cerramos el archivo.
 >>el tiempo de ejecucion es de ‘0 segundos’ para un archivo con ‘0  tokens’. El tiempo que tarda el programa en generar los archivos parece crecer de manera linear en relacion con el tamaño del archivo, por lo que se puede deducir que aunque el codigo no es el mas eficiente su complejidad no es tan avanzada.
