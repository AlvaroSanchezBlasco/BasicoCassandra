-- Para que el modelo sea multiidioma, añadimos un campo más a las tablas que lo necesiten, 
-- en el que se especifica el idioma, para posteriormente, añadir dicho campo a cada consulta.
-- Crearemos un índice secundario en cada tabla que sea posible, con el campo lang (correspondiente al idioma), 
-- para poder filtrar por ese campo, sin necesidad de añadirlo a la PK y así, poder mantener las ordenaciones 
-- que son necesarias para el resultado deseado. 

-- El crear el modelo multiidioma, implica que el número de registros por tabla se multiplica directamente 
-- por el número de idiomas que queramos contemplar. Así, si elegimos que tenga dos idiomas, 
-- el número de registros será el doble, tres idiomas el triple de registros, etc.

 --CREATE KEYSPACE cql_utad
 --WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 3 };

-- PRODUCTOS DESTACADOS
-- Para el conjunto de productos destacados, nuestro modelo no contempla una tabla para ello. 
-- Será el dpto. de Marketing quien decida qué se muestra.

-- OPCIONAL: Añadir un nuevo bloque de 8 productos aleatorios a la página de Home.
-- PRODUCTOS ALEATORIOS
-- Esta tabla se nutrirá de 8 registros elegidos al azar mediante algún algoritmo, que se decidirá en el 
-- análisis funcional de la aplicación y que puede estar basado en pesos de los productos, en consultas que esté 
-- realizando el usuario, etc. 

-- CONTADOR DE VENTAS
DROP TABLE contador_ventas;

-- Creamos la tabla contador_ventas para mantener actualizado el número de veces que se compra un producto. 
-- De alguna forma se tendrá que actualizar el valor de num_ventas cada vez que se compre un producto.

create table contador_ventas (
  num_ventas int,
  cte_pk int,
  id_producto int,
  imagen text, 
  precio_unitario int, 
  nombre_producto text, 
  lang text, 
  PRIMARY KEY (cte_pk, num_ventas, id_producto)) with clustering order by (num_ventas desc);

-- Indice secundario para la tabla contador_ventas, para poder usar el campo lang en nuestras consultas.
drop index lang_cont_vent;

CREATE INDEX lang_cont_vent
  ON contador_ventas (lang);

-- Como necesitamos una PK para hacer la consulta, determinamos un valor constante en la tabla, 
-- para poder recuperar la lista de elementos que nos interesa mostrar. 
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (1,1,1,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (1,1,1,'',12,'NOMBRE_EN','EN');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (2,1,1,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (2,1,1,'',12,'NOMBRE_EN','EN');  
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (3,1,1,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (3,1,1,'',12,'NOMBRE_EN','EN');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (4,1,1,'',12,'NOMBRE_ES','ES');  
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (4,1,1,'',12,'NOMBRE_EN','EN');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (5,1,1,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (6,1,1,'',12,'NOMBRE_ES','ES');  
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (7,1,1,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (8,1,1,'',12,'NOMBRE_ES','ES');  
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (9,1,1,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (10,1,1,'',12,'NOMBRE_ES','ES');  
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (22,1,1,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (23,1,1,'',12,'NOMBRE_ES','ES');  
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (14,1,2,'',12,'NOMBRE_ES','ES');
insert into contador_ventas (num_ventas, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (26,1,1,'',12,'NOMBRE_ES','ES');  

-- Para confirmar que estamos realizando la consulta correctamente y recuperando los datos que tienen más ventas, 
--añadimos el campo num_ventas a la consulta, pero en realidad, no es necesario recuperarlo.
select num_ventas, id_producto, imagen, precio_unitario, nombre_producto from contador_ventas WHERE lang='EN' limit 8;

-- ULTIMOS AÑADIDOS
-- Al igual que para recuperar los más vendidos, usamos la misma idea, y creamos una tabla para recuperar los últimos añadidos al catálogo.
-- El mantenimiento de esta tabla tiene que hacerse al mismo tiempo que se da de alta un producto.
drop table ultimos_anyadidos;

create table ultimos_anyadidos (
  anyadido timestamp,
  cte_pk int,
  id_producto int, 
  imagen text, 
  precio_unitario int, 
  nombre_producto text,
  lang text,  
  PRIMARY KEY (cte_pk, anyadido, id_producto)) with clustering order by (anyadido desc);

-- Indice secundario para la tabla ultimos_anyadidos, para poder usar el campo lang en nuestras consultas.
DROP INDEX lang_ult_any;

CREATE INDEX lang_ult_any
  ON ultimos_anyadidos (lang);

insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 1, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 2, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 3, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 4, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 5, '', 1, '', 'EN');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 6, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 7, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 8, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 9, '', 1, '', 'EN');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 10, '', 1, '', 'ES');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 11, '', 1, '', 'EN');
insert into ultimos_anyadidos (anyadido, cte_pk, id_producto, imagen, precio_unitario, nombre_producto, lang) values (dateof(now()), 1, 12, '', 1, '', 'ES');

-- Para confirmar que estamos realizando la consulta correctamente y recuperando los datos que han sido añadidos más recientemente, 
-- añadimos el campo anyadido a la consulta, pero en realidad, no es necesario recuperarlo.
select anyadido, id_producto, imagen, precio_unitario, nombre_producto from ultimos_anyadidos where lang='ES' limit 8;
select anyadido, id_producto, imagen, precio_unitario, nombre_producto from ultimos_anyadidos where lang='EN' limit 8;

-- COMPRAS CLIENTE
-- Es necesario que a la hora de generar el json con los datos de la compra se haya tenido en cuenta el idioma.
drop table compras_cliente;
-- Ultima compra del cliente (si existe)
-- Serializaremos en el campo compra el texto en un json, con los datos correspondientes a las compras de cada cliente
create table compras_cliente (
  anyadido timestamp,
  id_usuario int,
  id_compra int,
  compra text,
  lang text,
  PRIMARY KEY (id_usuario, anyadido, id_compra)) with clustering order by (anyadido desc);

-- Indice secundario para trabajar con multiidioma.
drop index lang_comp_cli;

create index lang_comp_cli on compras_cliente (lang);

insert into compras_cliente (anyadido, id_usuario, id_compra, compra, lang) values (dateof(now()), 1, 1, 'json serializado de la compra', 'ES');
insert into compras_cliente (anyadido, id_usuario, id_compra, compra, lang) values (dateof(now()), 2, 1, 'json serializado de la compra', 'ES');
insert into compras_cliente (anyadido, id_usuario, id_compra, compra, lang) values (dateof(now()), 1, 1, 'json serializado de la compra', 'ES');
insert into compras_cliente (anyadido, id_usuario, id_compra, compra, lang) values (dateof(now()), 3, 1, 'json serializado de la compra', 'EE');
insert into compras_cliente (anyadido, id_usuario, id_compra, compra, lang) values (dateof(now()), 1, 1, 'json serializado de la compra', 'ES');

--Queremos la última compra, por eso limitamos a 1
select anyadido, id_usuario, compra from compras_cliente where id_usuario = 1 and lang='ES' limit 1;

--Queremos el historico de compras del usuario, quitamos el limit a la anterior consulta.
select anyadido, id_usuario, compra from compras_cliente where id_usuario = 1 and lang = 'ES';

-- CATEGORIAS
-- Para las categorias, nutrimos nuestra tabla inicial, y preparamos las consultas.

--CATEGORIA POR NOMBRE
DROP TABLE categoria_por_nombre;
-- Creamos la tabla de categorias donde tendremos también toda la información que 
-- podemos necesitar sobre el producto asociado a una categoria.

-- El multiidioma en esta tabla, tal y como está planteado originalmente, no puede realizarse mediante 
-- un índice secundario como hemos venido haciendo en casos anteriores, ya que la cláusula order_by que 
-- planteamos para hacer la ordenación inversa a la definida en la creación de la tabla no funciona con 
-- indices secundarios.
-- Para solucionar el multiidioma, hay que añadir al text que determina la categoría el idioma además:
-- Ej. Teniamos la categoría DESTACADOS, y habrá que subdividirá en DESTACADOS_ES y DESTACADOS_EN.

-- Otra solución, para poder hacer uso de un indice secundario, sería crear dos tablas de categorías por nombre, 
-- e indicar en la creación de las mismas el orden ascendente o descendente. Así, si queremos ordenar de una forma u otra, 
-- consultaríamos una tabla u otra, y el indice secundario de lenguaje tendría cabida y funcionaría.
-- Personalmente, no me gusta crear una nueva tabla para cambiar la oredenación de los registros. 
-- Por eso simplemente he decidido añadir la característica del lenguaje al campo idcategoría, que ya pertenece a mi PK. 

CREATE TABLE categoria_por_nombre (
  idcategoria text,
  id_producto int,
  imagen text, 
  precio_unitario int, 
  nombre_producto text, 
  primary key (idcategoria, nombre_producto, id_producto)) with clustering order by (nombre_producto asc);

insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_ES', 1, 'IMAG0001.jpg', 10, 'nombre');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_EN', 2, 'IMAG0001.jpg', 1, 'nombre2');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_ES', 3, 'IMAG0001.jpg', 5, 'nombre3');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_ES', 4, 'IMAG0001.jpg', 40, 'nombr4e');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_EN', 5, 'IMAG0001.jpg', 1, 'nombre5');

insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_ES', 6, 'IMAG0001.jpg', 10, 'nombre6');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_EN', 7, 'IMAG0001.jpg', 1, 'nombre7');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_EN', 8, 'IMAG0001.jpg', 5, 'nombre8');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_ES', 9, 'IMAG0001.jpg', 40, 'nombre9');
insert into categoria_por_nombre (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_EN', 10, 'IMAG0001.jpg', 1, 'nombre10');

-- Ponemos limit a 3 para nuestras pruebas, pero habría que usar limit 40
-- El paginado asumimos que vendrá notificado desde la aplicación, por eso añadimos el where nombre > 'lo que venga'
select imagen, precio_unitario, nombre_producto from categoria_por_nombre WHERE idcategoria = 'DESTACADOS_EN' and nombre_producto > 'nombre2' limit 3;
-- Si queremos hacer la ordenación contraria a lo definido en la creación de la tabla, usamos esta consulta. 
select imagen, precio_unitario, nombre_producto from categoria_por_nombre WHERE idcategoria = 'DESTACADOS_ES' and nombre_producto > 'nombre2' order by nombre_producto desc limit 3;

--CATEGORIA POR PRECIO
DROP TABLE categoria_por_precio;
-- Creamos la tabla de categorias donde tendremos también toda la información que 
-- podemos necesitar sobre el producto asociado a una categoria.

-- El multiidioma en esta tabla, al igual que en la tabla de categoría por nombre, no puede realizarse mediante 
-- un índice secundario como hemos venido haciendo en casos anteriores, ya que la cláusula order_by que 
-- planteamos para hacer la ordenación inversa a la definida en la creación de la tabla no funciona con 
-- indices secundarios.
-- Para solucionar el multiidioma, hay que añadir al text que determina la categoría el idioma además:
-- Ej. Teniamos la categoría DESTACADOS, y habrá que subdividirá en DESTACADOS_ES y DESTACADOS_EN.

-- Otra solución, para poder hacer uso de un indice secundario, sería crear dos tablas de categorías por precio, 
-- e indicar en la creación de las mismas el orden ascendente o descendente. Así, si queremos ordenar de una forma u otra, 
-- consultaríamos una tabla u otra, y el indice secundario de lenguaje tendría cabida y funcionaría.
-- Personalmente, no me gusta crear una nueva tabla para cambiar la oredenación de los registros. 
-- Por eso simplemente he decidido añadir la característica del lenguaje al campo idcategoría, que ya pertenece a mi PK. 

CREATE TABLE categoria_por_precio (
  idcategoria text,
  id_producto int, 
  imagen text, 
  precio_unitario int, 
  nombre_producto text, 
  primary key (idcategoria, precio_unitario, id_producto)) with clustering order by (precio_unitario asc);

insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_ES', 1, 'IMAG0001.jpg', 10, 'nombre_producto');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_ES', 2, 'IMAG0001.jpg', 1, 'nombre_producto2');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_ES', 3, 'IMAG0001.jpg', 5, 'nombre_producto3');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_EN', 4, 'IMAG0001.jpg', 40, 'nombr4e');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('DESTACADOS_EN', 5, 'IMAG0001.jpg', 11, 'nombre_producto5');

insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_EN', 6, 'IMAG0001.jpg', 10, 'nombre_producto6');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_ES', 7, 'IMAG0001.jpg', 1, 'nombre_producto7');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_ES', 8, 'IMAG0001.jpg', 5, 'nombre_producto8');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_ES', 9, 'IMAG0001.jpg', 40, 'nombre_producto9');
insert into categoria_por_precio (idcategoria, id_producto, imagen, precio_unitario, nombre_producto) values ('INFORMATICA_EN', 10, 'IMAG0001.jpg', 1, 'nombre_producto10');

-- Ponemos limit a 3 para nuestras pruebas, pero habría que usar limit 40
-- El paginado asumimos que vendrá notificado desde la aplicación, por eso añadimos el precio_unitario > 'lo que venga'
select idcategoria,imagen, precio_unitario, nombre_producto from categoria_por_precio where idcategoria= 'DESTACADOS_EN' and precio_unitario > 6 limit 3;
--Si queremos hacer la ordenación contraria a lo definido en la creación de la tabla, usamos esta consulta.
select idcategoria,imagen, precio_unitario, nombre_producto from categoria_por_precio where idcategoria= 'INFORMATICA_ES' and precio_unitario > 6 order by precio_unitario desc limit 3;

-- TABLA DE PRODUCTO
-- MOSTRAR código de referencia, imagen, nombre, precio, descripción
-- Tabla de producto
DROP TABLE producto ;
-- Creamos la tabla de productos, para identificarlo a la hora de mostarlo en pantalla.
CREATE TABLE producto  (
  id_producto int,
  imagen text, 
  precio_unitario int, 
  nombre_producto text, 
  descripcion text,
  lang text,
  primary key (id_producto));

-- Creamos un índice secundario para la tabla producto, para poder filtrar por el idioma.
drop index lang_prod;

create index lang_prod
	on producto (lang);

insert into producto  (id_producto, imagen, precio_unitario, nombre_producto, descripcion, lang) values (1, 'IMAG0001.jpg', 10, 'nombre_producto1', 'descripcoion1', 'ES');
insert into producto  (id_producto, imagen, precio_unitario, nombre_producto, descripcion, lang) values (2, 'IMAG0001.jpg', 10, 'nombre_producto2', 'descripcoion2', 'EN');
insert into producto  (id_producto, imagen, precio_unitario, nombre_producto, descripcion, lang) values (3, 'IMAG0001.jpg', 10, 'nombre_producto3', 'descripcoion3', 'ES');
insert into producto  (id_producto, imagen, precio_unitario, nombre_producto, descripcion, lang) values (4, 'IMAG0001.jpg', 10, 'nombre_producto4', 'descripcoion4', 'EN');
insert into producto  (id_producto, imagen, precio_unitario, nombre_producto, descripcion, lang) values (5, 'IMAG0001.jpg', 10, 'nombre_producto5', 'descripcoion5', 'ES');

select id_producto, imagen, precio_unitario, nombre_producto, descripcion from producto  where id_producto = 4 and lang='EN';
select id_producto, imagen, precio_unitario, nombre_producto, descripcion from producto  where id_producto = 5 and lang='ES';

-- TABLA DE COOCURRENCIA
-- coocurrencia nos lo dan
-- podemos crear una tabla para la actualización de las coocurrencias.
DROP TABLE coocurrencia;

CREATE TABLE IF NOT EXISTS coocurrencia (
    id_producto bigint,
    nombre_producto text,
    num_coocurrencias bigint,
    id_prod_cooc text,
    nom_prod_cooc text,
    img_prod_cooc text,
    pvp_prod_cooc float,
    desc_prod_cooc text,
    lang text,
    PRIMARY KEY (id_producto, num_coocurrencias, id_prod_cooc)
) WITH CLUSTERING ORDER BY (num_coocurrencias DESC);

-- Indice secundario para el multiidioma en la tabla de coocurrencias.
drop index lang_cooc;

create index lang_cooc on coocurrencia (lang);

SELECT * FROM coocurrencia WHERE id_producto = 1 LIMIT 8;

-- TABLA DE CARRITO
-- idcarrito, id_usuario, json con [nombres de productos, cantidad, precio por unidad, pvpAgrupado], pvpTotal 
-- El json con la relación de productos tendrá que tener en cuenta el idioma al ser generado.

-- OPCIONAL: GASTOS DE ENVÍO EN LA INFORMACIÓN DE LA PÁGINA DEL CARRITO
-- Mostrar gastos de envío en la información de la página de carrito y en el detalle de las compras. 
-- Los gastos de envío se calculan en función de la dirección del usuario usando un servicio externo (consulta al proveedor logístico).	
-- Para tratar este añadido, se me ocurren varias ideas.
-- Primera: Conociendo el id_usuario, el servicio externo leerá de la tabla de usuario, que contenga el campo dirección del mismo, 
-- y nos devuelve los datos de los gastos de envío.
-- Segunda: Añadir a las tablas de información de carrito y detalle de compras dos nuevos campos, uno con la dirección de envío, 
-- y otro con el importe de los gastos de envío, de tal forma que sea accesible. 
-- No me parece optimo, ya que cada vez que modifiquen la dirección, habrá que recalcular los gastos de envío, y realizar una 
-- modificación del registro.

DROP TABLE carrito;

CREATE TABLE carrito (
  idcarrito int,
  id_usuario int,
  relacion_productos text,
  pvp_total double,
  pvp_gastos_envio double,
  lang text, 
  primary key (idcarrito, id_usuario));

-- Para multiidioma, creamos un indice secundario para el idioma.
drop index lang_carro;

create index lang_carro on carrito (lang);

insert into carrito (idcarrito, id_usuario, relacion_productos, pvp_total, pvp_gastos_envio, lang) values (1, 1, 'json con [nombres de productos, cantidad, precio por unidad, pvpAgrupado]', 101, 2, 'ES');
insert into carrito (idcarrito, id_usuario, relacion_productos, pvp_total, pvp_gastos_envio, lang) values (1, 2, 'json con [nombres de productos, cantidad, precio por unidad, pvpAgrupado]', 10, 2, 'ES');
insert into carrito (idcarrito, id_usuario, relacion_productos, pvp_total, pvp_gastos_envio, lang) values (1, 3, 'json con [nombres de productos, cantidad, precio por unidad, pvpAgrupado]', 201, 2, 'ES');
insert into carrito (idcarrito, id_usuario, relacion_productos, pvp_total, pvp_gastos_envio, lang) values (1, 4, 'json con [nombres de productos, cantidad, precio por unidad, pvpAgrupado]', 55, 2, 'ES');
insert into carrito (idcarrito, id_usuario, relacion_productos, pvp_total, pvp_gastos_envio, lang) values (2, 1, 'json con [nombres de productos, cantidad, precio por unidad, pvpAgrupado]', 4, 2, 'ES');

-- Limitamos la busqueda a 8 elementos
select idcarrito, id_usuario, relacion_productos, pvp_total, pvp_gastos_envio from carrito where idcarrito=2 and id_usuario =1 AND lang='ES';

-- TABLA DE FACTURA e HISTORICO DE FACTURA
-- OPCIONAL: GASTOS DE ENVÍO EN LA INFORMACIÓN DE LA PÁGINA DEL Y EN DETALLE DE LAS COMPRAS
-- Los gastos de envío tendran que calcularse en base al usuario, y su dirección de envío, como en la tabla del carrito.
-- Creamos la tabla de factura, que recupera de forma univoca una factura para un id_usuario y si es necesario, 
-- un timestamp dado (para recuperar el histórico) y un json con los datos asociados a la misma.
-- El orden de la PK está orientado a poder realizar busquedas en tiempo, de ahí que el idfactura sea el último campo que la compone.
-- Para realizar una consulta por un idfactura, hace falta saber la fecha. 
-- Para el caso de mostrar la factura de la compra actual, la fecha ha de ser la del día, del id_usuario correspondiente.
-- la relación de productos que van parseados en un json, han de tener en cuenta a la hora de generarlos, el idioma.
-- Añadimos que los datos de la tabla (para el historico) se ordenen de forma descendente respecto al timestamp de la fecha de la factura, 
-- para que, si queremos recuperar la última factura, sea es registro el primero que nos devuelva la consulta. 
DROP TABLE factura;

CREATE TABLE factura (
  id_usuario int,
  idfactura int,
  fecha_factura timestamp,
  importe_factura double,
  relacion_productos text,
  pvp_gastos_envio double,
  lang text,
  primary key (id_usuario, fecha_factura, idfactura)) with clustering order by (fecha_factura desc);

-- Indice secundario para el multiidioma de la tabla factura.
drop index lang_fact;
create index lang_fact on factura (lang);

insert into factura (id_usuario, idfactura, importe_factura, pvp_gastos_envio, fecha_factura, relacion_productos, lang) values (1, 1, 1, 1,dateof(now()),'json con productos asosciados a la factura', 'ES');
insert into factura (id_usuario, idfactura, importe_factura, pvp_gastos_envio, fecha_factura, relacion_productos, lang) values (1, 2, 2, 2,dateof(now()),'json con productos asosciados a la factura', 'ES');
insert into factura (id_usuario, idfactura, importe_factura, pvp_gastos_envio, fecha_factura, relacion_productos, lang) values (1, 3, 3, 3,dateof(now()),'json con productos asosciados a la factura', 'ES');
insert into factura (id_usuario, idfactura, importe_factura, pvp_gastos_envio, fecha_factura, relacion_productos, lang) values (2, 4, 4, 4,dateof(now()),'json con productos asosciados a la factura', 'ES');
insert into factura (id_usuario, idfactura, importe_factura, pvp_gastos_envio, fecha_factura, relacion_productos, lang) values (2, 1, 5, 5,dateof(now()),'json con productos asosciados a la factura', 'ES');

-- Seleccionamos la factura actual del usuario.
select idfactura, id_usuario, relacion_productos from factura where id_usuario=1 and fecha_factura = dateof(now()) and idfactura = 2 and lang='ES';

--Seleccionamos el historico de faturas del usuario
select idfactura, id_usuario, relacion_productos from factura where id_usuario=1 and lang='ES' limit 1;
