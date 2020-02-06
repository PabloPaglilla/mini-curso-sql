# Introducción a la sentencia SELECT

En SQL, la sentencia SELECT se usa siempre que se quieran consultar datos de las tablas. Las queries o consultas que se pueden realizar van desde queries sencillas (como consultar los nombres de todas las campañas de un cliente); hasta queries complejas que incluyen filtros, agrupaciones, agregados, un orden en particular para los resultados, etc (por ejemplo; obtener todas aquellas campañas de cierto cliente cuya cantidad de impresiones en la última semana sea mayor a 10.000, ordenadas por cantidad de impresiones descendentemente).

Un SELECT aplicado sobre una tabla nos devuelve otra tabla con los resultados.

## SELECT básico

La sintaxis básica de la sentencia SELECT es la siguiente:

``` sql
SELECT {columnas} FROM {tabla}
```

Una query de ese estilo trae las columnas solicitadas de todas las filas de la tabla en cuestión.


### Especificando columnas

Para especificar las columnas que se quieren en un SELECT, se escriben los nombres de cada una separados por comas.

**Ejemplos**

``` sql
-- Trae los nombres de todas las campañas
SELECT campaing_name FROM campaigns

-- Trae nombre, cantidad de impresiones y cantidad de clicks de todas las campañas
SELECT campaign_name, impressions, clicks FROM campaigns
```

A su vez, existen algunos 'atajos' para consultar numerosas columnas:

* Consultar todas las columnas de una tabla
    Para consultar todas las columnas de una tabla, se reemplaza la lista de columnas por un *
    ``` sql
    SELECT * FROM campaigns
    ```
* Consultar todas las columnas de una tabla, exceptuando algunas
    Se reemplaza la lista de columnas por `* EXCEPT ({columnas que excluir})`
    ``` sql
    SELECT * EXCEPT (creative_id, creative_name) FROM campaigns
    ```

### Alias de columnas

Por defecto, la columna resultado toma el mismo nombre que la columna de la tabla de origen. Una consulta como la siguiente:

``` sql
SELECT campaign_name FROM campaigns
```

Retorna un resultado como este:

| campaign_name |
|---------------|
| campaign_1    |
| campaign_2    |

Si se le quiere asignar un nombre en particular a una columna en el resultado del SELECT, puede usarse el operador `AS` al especificar la misma. Esto se hace de la siguiente forma:

``` sql
SELECT campaign_name AS nombre_de_la_campaña FROM campaigns
```

Una consulta como la de arriba, genera un resultado como este:

| nombre_de_la_campaña |
|----------------------|
| campaign_1           |
| campaign_2           |

Esto no parece muy util con los ejemplos vistos hasta ahora, pero su utilidad surge cuando generamos nuevas columnas que no se encuentran directamente en la tabla.

### Generando nuevas columnas

Cada columna especificada en un SELECT puede ser:

* El nombre de una columna de la tabla, lo cual trae el valor de la misma
* Una expresión que puede usar el valor de una, varias o incluso ninguna columa

Las expresiones se utilizan siempre que se quiera que la query genere una columna que no se encuentra directamente en la tabla. Un ejemplo podría ser obtener el nombre y el CTR de todas las campañas.

``` sql
SELECT campaign_name, (clicks / impressions) AS CTR FROM campaigns
```

Notar cómo ahora sí es util poder asignarle un nombre a la columna CTR. Si no lo especificamo; la base de datos suele generar un nombre como `col_2` o algo similar, lo cual no brinda nada de información sobre la columna.

Las expresiones puede ser:

* Valores únicos
    Podemos escribir algo de la forma `SELECT 1 AS numero_1 FROM campaigns`. En este caso, todas las filas contienen el número 1 en la columna.

* Cálculos matemáticos entre columnas
    Como el ejemplo anterior del cálculo del CTR.

* Llamadas a funciones
    Una función es una pieza de código que toma ciertos parámetros y retorna un resultado. Vamos a hablar de funciones más adelante, pero un ejemplo sencillo es la función `CONCAT`. Esta funcion toma varias piezas de texto y las une en un único texto. Si quisieramos obtener el nombre completo de los clientes de una empresa, podriamos hacer algo como esto:

    ``` sql
    SELECT CONCAT(nombre, apellido) FROM clientes
    ```

* Una combinación de las anteriores
    Pueden mezclarse llamadas a funciones, calculos y valores. El siguiente ejemplo calcula el CTR como un porcentaje (CTR * 100) y luego le aplica la función ROUND, la cual lo redondea al entero más cercano.

    ``` sql
    SELECT ROUND((clicks / impressions) * 100) CTR_en_porcentaje FROM campaigns
    ```
