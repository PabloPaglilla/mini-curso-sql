# Where

Es muy común en consultas SQL el necesitar filtrar filas. Por ejemplo, supongamos que quisieramos consultar las impresiones de una campaña en particular de la que conocemos el nombre. O que quisieramos los nombres de todas las campañas que tengan más de 10000 impresiones. Podemos hacer esto con la cláusula `WHERE`.

La nueva sintaxis del SELECT agregando esta cláusula es:

``` sql
SELECT {columnas} FROM {tabla} [WHERE {condición}]
```

Si también incluimos las demás cláusulas que vimos hasta ahora:

``` sql
SELECT {columnas} FROM {tabla} 
    [WHERE {condición}]
    [ORDER BY {columnas} [ASC | DESC]]
    [LIMIT N]
```

## Filtrando filas

Como podemos ver arriba, para poder filtrar filas debemos agregar la cláusula `WHERE` con una condición luego del `FROM`. Dicha consulta solo considerará filas para las cuales la condición resulte verdadera.

Podriamos consultar los dos ejemplos propuestos arriba de la siguiente manera:

``` sql
-- Obtener las impresiones de una campaña en particular
-- La condición es que campaign_name sea igual a "campaign_1"
SELECT impressions FROM campaigns WHERE campaign_name = 'campaign_1'

-- Obtener los nombres de las campañas con más de 10000 impresiones
-- La condición es que impressions sea mayor a 10000
SELECT campaign_name FROM campaigns WHERE impressions > 10000
```

## Escribiendo condiciones

Existen varios operadores que podemos usar para escribir condiciones. En los dos ejemplos de arriba usamos el operador de igualdad (=) para quedarnos solo con la fila de la campaña "campaign_1" y el operador mayor (>) para quedarnos solo con las filas de la campañas con más de 10000 impresiones.

Ahora vamos a ver algunos de los operadores disponibles.

### Operadores de comparación

Los operadores de comparación son:

| Operador           | Ejemplo                       | Transcripción del ejemplo                                   |
|--------------------|-------------------------------|-------------------------------------------------------------|
| Igualdad (=)       | campaign_name = 'campaign_1'  | Considera solo filas donde campaign_name es "campaign_1"    |
| Desigualdad (!)    | campaign_name != 'campaign_2' | Considera solo filas donde campaign_name NO es "campaign_1" |
| Mayor (>)          | impressions > 10000           | Considera solo filas con impresiones mayores a 10000        |
| Mayor o igual (>=) | impressions >= 10000          | Considera solo filas con al menos 10000 impresiones         |
| Menor (<)          | clicks < 100                  | Considera solo filas con menos de 100 clicks                |
| Menor o igual (<=) | clicks <= 100                 | Considera solo filas con hasta 100 clicks                   |

### Operador IN

El operador IN permite verificar si una columna se encuentra en una lista de valores.

Por ejemplo; supongamos que queremos obtener las impresiones de 3 campañas llamadas (sin mucha originalidad) "campaign_1", "campaign_2" y "campaign_3". Podriamos filtrar la tabla de campañas verificando que `campaign_name` tenga alguno de esos 3 valores. Podemos hacer eso de esta forma:

``` sql
SELECT campaign_name, impressions FROM campaigns WHERE campaign_name IN ('campaign_1', 'campaign_2', 'campaign_3')
```

Resultado:

| campaign_name | impressions |
|---------------|-------------|
| campaign_1    | 7000        |
| campaign_2    | 11000       |
| campaign_3    | 11000       |

Si existiera una campaña con el nombre "campaign_4" o "mi_campaña_piola", no figuraría en los resultados.

### Operador LIKE

El operador `LIKE` permite verificar si un columna que tiene texto coincide con una expresión regular. [No! Fuera! Impulso de ingeniero!](https://www.youtube.com/watch?v=RLmxIWYxl44).

Alguno que lea esto se va a estar preguntando qué carajo es una expresión regular. Basicamente es una forma de representar patrones que puede seguir cierto texto, por ejemplo:

* Empezar con "digitas-"
* Terminar con ".csv"
* Contener la palabra "performance"
* Y muchos patrones más complicados

Esos primeros 3 ejemplos son los usados y solo vamos a ver esos 3 por el momento.

1. Ejemplo 1: ver si `campaign_name` empieza con "digitas"

    ``` sql
    SELECT * FROM campaigns WHERE campaign_name LIKE 'digitas%' -- Notar el % al final
    ```

2. Ejemplo 2: ver si `campaign_name` termina con "cajita-feliz"

    ``` sql
    SELECT * FROM campaigns WHERE campaign_name LIKE '%cajita-feliz' -- Notar el % al principio
    ```

3. Ejemplo 3: ver si `campaign_name` contiene la palabra "enero"

    ``` sql
    SELECT * FROM campaigns WHERE campaign_name LIKE '%enero%' -- Notar los dos %
    ```

### Operador BETWEEN

El operador BETWEEN permite verificar que un valor se encuentre entre dos otros valores. Funciona cualquier tipo de dato que permita comparar por mayor o menor; como números, texto (ordena alfabeticamente), fechas, etc.

Ejemplo, traer todas las campañas cuya cantidad de clicks este entre 200 y 400:

``` sql
SELECT * FROM campaigns WHERE clicks BETWEEN 200 AND 400
```

Ejemplo, traer todas las campañas que hayan comenzado en enero del 2020:


``` sql
SELECT * FROM campaigns WHERE start_date BETWEEN '2020-01-01' AND '2020-01-31'
```

### Operador IS y valores nulos

Es común que en las bases de datos puedan faltar valores. Cuando falta el valor de una celda de una tabla, la celda contiene un valor especial. Ese valor es el `NULL`.

Ahora bien; cuando queramos verificar si una columna contiene `NULL`, tenemos que usar el operador `IS` de la siguiente forma:

``` sql
-- Traer todas las campañas cuyo start_date es desconocido
SELECT * FROM campaigns WHERE start_date IS NULL
```

Muchas veces vamos a querer usar solo las filas que NO contengan NULL en cierta columna; es decir, por ejemplo, campañas de las que SI se conoce su `start_date`. Cómo hacemos eso?

En esa situación entra en juego el operador `NOT`.

### Operador NOT

Este operador sirve para negar los operadores `IN`, `LIKE`, `BETWEEN` e `IS` (además de otros más avanzados que vamos a ver más adelante).

Así, se generan 4 "nuevos" operadores:

* `NOT IN`, que verifica que un valor **NO** esté en una lista


    ``` sql
    -- Queremos las campañas cuyos nombres no sean campaign_1, campaign_2 o campaign_3
    SELECT campaign_name, impressions FROM campaigns WHERE campaign_name NOT IN ('campaign_1', 'campaign_2', 'campaign_3')
    ```

* `ǸOT LIKE`, que verifica que un valor **NO** cumpla con una expresión regular


    ``` sql
    -- Queremos solo las campañas cuyo nombre NO empiece con digitas
    SELECT * FROM campaigns WHERE campaign_name NOT LIKE 'digitas%'
    ```

* `NOT BETWEEN`, que verifica que un valor **NO** esté entre 2 otros


    ``` sql
    SELECT * FROM campaigns WHERE clicks NOT BETWEEN 200 AND 400
    ```

* `IS NOT`, que puede usarse para verificar que no valor **NO** sea NULL (mucho más util que verificar que lo sea)

    ``` sql
    SELECT * FROM campaigns WHERE start_date IS NOT NULL
    ```

## Combinando condiciones

Hasta ahora todos los `WHERE` que escribimos usaron una sola condición. Pero, qué pasa si necesitamos más de una condición?

Por ejemplo, podriamos necesitar:

* Las campañas que tengan más de 10000 impresiones **Y** más de 500 clicks
* Las campañas que tengan menos de 1000 impresiones **O** menos de 20 clicks

Notaran el énfasis en el Y y el O, dos operadores lógicos que podemos usar para unir varias condiciones en una sola. En SQL, naturalmente, se escriben `AND` y `OR`.

Podemos implementar los dos ejemplo de arriba:

``` sql
-- campañas que tengan más de 10000 impresiones y más de 500 clicks
SELECT * FROM campaigns WHERE impressions > 10000 AND clicks > 500
```

``` sql
-- campañas que tengan menos de 1000 impresiones o menos de 20 clicks
SELECT * FROM campaigns WHERE impressions < 1000 OR clicks < 20
```

Se pueden combinar tantas condiciones como se quiera, pero hay que tener cuidado con la precendencia de los operadores. (Son las 2.40 am y la precedencia es medio larga de explicar, así que se los explico en persona y después extiendo el apunte :sweat_smile:).

## Usando expresiones para filtrar

Hasta ahora solo hicimos comparaciones contra columnas de la tabla, pero también se pueden hacer comparaciones con expresiones.

Por ejemplo, busquemos los nombres de todas las campañas cuyo CTR sea mayor a 0.05:

``` sql
SELECT * FROM campaigns WHERE (clicks / impressions) > 0.05
```