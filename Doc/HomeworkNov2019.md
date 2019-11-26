# Ejercicio de evaluación

**Para este ejercicio se utilizarán los reads depositados aquí: [Illumina_raw_reads](https://osu.box.com/s/izwqfpe0ayqd5fxc27acra4nkxwzz3je)**

1.	Descargar y descomprimir los reads del link.
2.	Correr fastQC y generar los archivos .html con la calidad de los reads crudos.
3.	Hacer limpieza de adaptadores y remover secuencias con calidad q<=30 y generar archivos fastQC con estos datos filtrados.
4.	Ensamblar las lecturas filtradas por calidad utilizando IDBA_UD y SPADES utilizando al menos 2 diferentes iteraciones de Kmero
5.	Generar las tablas de estadísticas generales para los contings y scaffolds de ambos ensambladores, reportando el Numero de contigs, el tamaño de Genoma, N50, N90 y N100.
6.	Remover todos aquellos contigs menores a 1000 nt y generar de Nuevo las tablas de estadísticas.
7.	Usando algún contig menor a 10 mil bases realizar un blast para identificar oragnismos relacionados taxonómicamente
8.	Calcular la cobertura promedio para cada ensamble.
9.	A partir de estas estadísticas decidir cual es el “mejor” ensamble y calcular su completeness utilizando BUSCO y usando la información del Blast seleccionar la base de datos de orthologous que mejor se adecue al genoma.
10.	Usando alguno de los ensambles de SPADES, visualizar con Bandage la gráfica de ensambles (archivo assembly_graph.fastg). Con esta información contestar:
  a.	 Existe algún replicón circular (i.e plásmido, virus) en el Ensamble? Si es asi tomar captura de pantlla y reportarlo.
  b.	¿Si existe alguno de estos elementos podrían inferir si se trata de algún plásmido (idea usar blast)? Si es asi informarlo en el reporte
11.	Generar un reporte general mostrando las tablas de las estadísticas para cada ensamble (contigs, scaffolds), y a partir de estas explicar cuál fue la métrica que llevo a decidir por el mejor ensamble. 
12.	Reportar en una tabla las características generales de su ensamble genómico.
13.	Enviar por correo electrónico en una carpeta comprimida con su nombre como nombre del archivo (i.e veraponcedeleonArturo.zip):

  -a.	Los archivos .html generados por fastQC
  
  -b.	Un reporte final en formato Word donde se presenten las estadisticas de todos los ensambles señalando el “mejor”. La toma de captura de Bandage mostrando si o no existe evidencia de replicones circulares tipo plásmidos. La tabla final con las características finales de su ensamble genómico (Ver ejemplo).
  
  -c.	Los contigs/scaffolds (formato fasta) de este “mejor ensamble”


## La fecha límite para el envió de trabajos será el próximo Martes 03 de Diciembre 2019 a las 23:59 hrs.

Ejemplo:
![Alt Text](https://github.com/avera1988/Genome_Assembly_lecture/blob/master/images/Table.png)
