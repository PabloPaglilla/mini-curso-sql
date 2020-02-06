# Order by

De a poco vamos a ir extendiendo las capacidades del la query SELECT agregando nuevas funcionalidades. Una de estas funcionalidades es la de poder ordenar la tabla resultado por una o varias columnas. 

En caso de no especificar un orden, el mismo no está garantizado. Es decir, podriamos ejecutar la misma consulta dos veces y obtener las filas resultado en ordenes distíntos.

## Cómo ordenar resultados?

Vamos a extender la sintaxis del SELECT, agregando la cláusula opcional `ORDER BY`.

``` sql
SELECT {columnas} FROM {tabla} [ORDER BY {columnas} [ASC | DESC]]
```

**Nota:** cuando especifiquemos una sintaxis como arriba, algo entre corchetes es opcional.

Dentro de la cláusula `ORDER BY` podemos especificar una o varias columnas o expresiones por las cuales se van a ordenar los resultados.

### Ordenando por una única columna

Supongamos que queremos obtener todas las campañas junto con su cantidad de impresiones, ordenando por dicha cantidad. La consulta para obtener ese resultado sería:

``` sql
SELECT campaign_name, impressions FROM campaigns ORDER BY impressions
```

Y una posible respuesta sería la siguiente:

| campaign_name | impressions |
|---------------|-------------|
| campaign_1    | 7000        |
| campaign_2    | 11000       |

Las columnas, además de poder ser referenciadas por nombre, pueden ser referenciadas por el orden en que aparecen en los resultados. Por ejemplo, podriamos sustituir el query anterior por este:

``` sql
SELECT campaign_name, impressions FROM campaigns ORDER BY 2
```

Notar que `impressions` es la segunda en nuestras columnas de resultados, por lo que escribir `ORDER BY 2` ordena por dicha columna.

### Ordenando por varias columnas

En la cláusula `ORDER BY`, podemos especificar múltiples columnas separadas por comas. Supongamos una consulta como la siguiente:

``` sql
SELECT campaign_name, impressions, clicks FROM campaigns ORDER BY impressions, clicks
```

Esta query ordena los resultado principalmente por impresiones. Ahora bien; en el caso de que dos o más campañas empaten en impresiones, las ordenará entre sí por clicks.

Resultado de ejemplo:

| campaign_name | impressions | clicks |
|---------------|-------------|--------|
| campaign_2    | 7000        | 150    |
| campaign_1    | 11000       | 200    |
| campaign_3    | 11000       | 220    |

### Ordenando con una expresión

Supongamos ahora que queremos listar nombre, impresiones y clicks de todas las campañas, ordenando por CTR. Podemos ordenar por expresiones en el `ORDER BY`, por lo que podemos hacer algo como esto:

``` sql
SELECT campaign_name, impressions, clicks FROM campaigns ORDER BY (clicks / impressions)
```

Y si también quisieramos tener el CTR como una columna en los resultados?

``` sql
SELECT campaign_name, impressions, clicks, (clicks / impression) AS CTR FROM campaigns ORDER BY CTR
```

### Ordenando de forma descendente

Notar como, en la sintaxis que mostramos al principio del documento, opcionalmente podiamos agregar al order by las palabras `ASC` o `DESC`. Estas permiten especificar si queremos ordenar de forma ascendente o descendente respectivamente. Por defecto, se ordena de forma ascendente.

Ordenando de forma ascendente:

``` sql
SELECT campaign_name, impressions FROM campaigns ORDER BY impressions

-- O bien, diciendo explicitamente que queremos ordenas ascendentemente

SELECT campaign_name, impressions FROM campaigns ORDER BY impressions ASC
```

Ordenando de forma descendente:

``` sql
SELECT campaign_name, impressions FROM campaigns ORDER BY impressions DESC
```

#### Podemos mezclar orden ascendente y descendente para distíntas columnas?

Sí, podemos. Retomemos el ejemplo de ordenar las campañas tanto por clicks como impresiones:

``` sql
SELECT campaign_name, impressions, clicks FROM campaigns ORDER BY impressions, clicks
```

Supongamos que, por alguna razón que seguro tiene mucho sentido; queremos ordenar descendentemente por impresiones pero desempatar ascendentemente por clicks. Teniendo en cuenta que por defecto se ordena de forma ascendente, podemos hacerlo de las siguientes dos formas:

``` sql
SELECT campaign_name, impressions, clicks FROM campaigns ORDER BY impressions DESC, clicks

-- o

SELECT campaign_name, impressions, clicks FROM campaigns ORDER BY impressions DESC, clicks ASC
```

En este otro caso, obtendriamos este resultado:

| campaign_name | impressions | clicks |
|---------------|-------------|--------|
| campaign_1    | 11000       | 200    |
| campaign_3    | 11000       | 220    |
| campaign_2    | 7000        | 150    |

## Limitando la cantidad de resultados

Supongamos ahora que queremos limitar la cantidad de filas que devuelve un SELECT que realizamos. Podemos hacerlo con la clausula opcional `LIMIT`.

Extendemos más la sintaxis del SELECT:

``` sql
SELECT {columnas} FROM {tabla} [LIMIT N]
```

Si también incluimos el ORDER BY opcional en la sintaxis

``` sql
SELECT {columnas} FROM {tabla} [ORDER BY {columnas} [ASC | DESC]] [LIMIT N]
```

**Nota:** tener en cuenta el orden de las cláusulas en la sintaxis. Como se puede ver arriba, `ORDER BY` va antes que `LIMIT` y siempre tiene que ser así.

### Usando LIMIT

Para usar `LIMIT`; agregamos al final de la consulta la palabra, seguida del número máximo de filas que queremos que retorne el SELECT. Si especificamos que queremos un máximo de 10 filas, la consulta traerá solo las primeras 10 filas de la tabla resultado.

Supongamos que quiero traer el nombre de las campañas del cliente, pero con un máximo de 10. Puede hacerlo de la siguiente forma:

``` sql
SELECT campaign_name FROM campaigns LIMIT 10
```

### Usando LIMIT con ORDER BY

Usar `LIMIT` solo muchas veces no tiene mucho sentido más que permitir visualizar una pequeña parte de los resultados. Ahora bien, `LIMIT` es mucho más util cuando se lo combina con `ORDER BY`.

Supongamos que queremos traer las 5 campañas con más impresiones. Podriamos ordenar las campañas descendentemente por impresiones y limitar la cantidad de resultados a 5.

``` sql
SELECT campaign_name FROM campaigns ORDER BY impressions DESC LIMIT 10
```