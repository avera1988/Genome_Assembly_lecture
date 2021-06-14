# Rerporte para evaluar el modulo de ensamble de genomas.

Utilizando las secuencias obtenidas por Illumina () y Nanopore-MiniON (), recuperar el genoma de la bacteria _Klebsiella pneumonie_ lo mas completa posible intntando obtener un cromosoma circular y plasmidos.

Para el reporte de evaluacion se pide lo siguiente:

1. En un documento de texto, entregar una tabla con las estadisticas basicas del numero de seucuencias obtenidas tanto por Illumina tanto por Nanopore antes y despues del filtrar todas aquellas secuencias que contienen adaptadores y con una calidad Q < 30 (utilizar trimmgalore). La tabla debera ser similar al siguiente ejemplo:

|Archivo|RawReads|ReadsAfterGalore|
|---|---|---|
|Archivo_R1|2706330|2394005|
|Archivo_R2|2706330|2394005|
|Archivo_NANOPRE|7250|NA|

3. Utilizar las secuencias de illumina y recuperar un draft genomico utilizando el software SPADES.
4. Utilizar las seciencidas de Nanopore y recuperar un draft genomco utilizando Unicyler.
5. Hacer un ensamlbe hibrido utilizando ambas tecnologias de secuenciacion (unicycler).

6. En el mismo documento de texto entregar una tabla con las estadisticas basicas de cada ensamble (Illumina, Nanopore e hibrido), es decir Numero de contigs, tamaño en bases del genoma, N50, N90 y completeness score (BUSCO)

Genome|Illumina|
|---|---|
length (nt)| 3644585|
#Contigs |148|
N50 |73987 n=15|
N90 |13398 n=57|
Coverage |59.49|
Completeness using the bacteria_BUSCO database|96.8|
Presence of circular contigs| yes|
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

. Entregar el genoma en formato fasta de la bacteria. Este archivo debera contener el menor numero de contigs y de ser posible al menos uno de ellos debera ser circular.
