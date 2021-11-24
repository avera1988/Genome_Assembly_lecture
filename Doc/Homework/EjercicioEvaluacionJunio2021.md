# Rerporte para evaluar el modulo de ensamble de genomas.

Utilizando las secuencias obtenidas por Illumina (```/home/avera/GenomeAssembly/Data/Report/Illumina```) y Nanopore-MiniON (```/home/avera/GenomeAssembly/Data/Report/Nanopore```), recuperar el genoma de la bacteria _Klebsiella pneumonie_ lo mas completa posible intentando obtener un cromosoma circular y plasmidos.

Para el reporte de evaluacion se pide lo siguiente:

1. En un documento de texto, entregar una tabla con las estadisticas basicas del numero de seucuencias obtenidas por Illumina y Nanopore antes y despues de filtrar todas aquellas secuencias que contienen adaptadores y con una calidad Q < 30 (utilizar trimmgalore). La tabla debera ser similar al siguiente ejemplo:

|Archivo|RawReads|ReadsAfterGalore|
|---|---|---|
|Archivo_R1|2706330|2394005|
|Archivo_R2|2706330|2394005|
|Archivo_NANOPORE|7250|NA|

3. Utilizar las secuencias de illumina y recuperar un draft genomico utilizando el software SPADES.
4. Utilizar las seciencidas de Nanopore y recuperar un draft genomco utilizando el pipeline Unicyler.
5. Hacer un ensamlbe hibrido utilizando ambas tecnologias de secuenciacion (unicycler).

6. En el mismo documento de texto entregar una tabla con las estadisticas basicas de cada ensamble (Illumina, Nanopore e hibrido), es decir: Numero de contigs, tamaño en bases del genoma, N50, N90 y completeness score (BUSCO). Ver ejemplo:

Genome|Traits|
|---|---|
Illumina length (nt)| 3644585|
Illumina #Contigs |148|
Illumina N50 |73987 n=15|
Illumina N90 |13398 n=57|
Illumina Coverage |59.49|
Illumina Completeness using the bacteria_BUSCO database|96.8|
Illumina Presence of circular contigs| yes|
Nanopore length (nt)| 3643883|
Nanopore #Contigs |79|
Nanopore N50 |110179 n=10|
Nanopre N90 |28300 n=36|
Nanopore Completeness using the bacteria_BUSCO database |97 %|
Presence of circular contigs| yes|
Hybrid length (nt)| 3643883|
Hybrid #Contigs |4|
Hybrid N50 |110179 n=10|
Hybrid N90 |28300 n=36|
Nanopore Completeness using the bacteria_BUSCO database |99 %|
Presence of circular contigs| yes|

7. Entregar en el reporte la imagen de la grafica de cada uno de los ensambles genomicos generada por Bandage. Ejemplo:

![imagen](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/hybrid.png)

9. Con base en estos resultados discutir cual es el mejor genoma, elaborar su respuesta indicando los valores/caracteristicas que llevaron a considerar ese ensmable genomico como el "mejor".
  
11. Entregar el genoma con el mejor ensamble en formato fasta. Este archivo debera contener el menor numero de contigs y de ser posible al menos uno de ellos debera ser circular.

**El documento de texto debera ser guardado utilizando su nombre completo en el nombre del archivo algo como: ReporteEnsambles_Arturo_Vera_PoncedeLeon.docx. Este documento de texto y el archivo fasta de su genoma debera ser enviado por correo electronico a
arturo.vera.ponce.de.leon@nmbu.no antes del *Viernes 12 de Diciembre 2021 23:59 hrs* indicando en el "subject" del correo: Reporte_Ensambles_2021_NombreDelAlumno para una mejor distribucion de los mensjaes.**

Todos los datos se encuentran en el servidor del Politecnico en el folder:

```console
/home/avera/GenomeAssembly/Data/Report
````
No duden en escribirme si existe alguna duda o problema.

### Buena suerte con sus reportes! 
