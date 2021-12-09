--Eliminando Base de Datos 
DROP DATABASE blog;
-- Creando Base de Datos 
CREATE DATABASE blog;

\c blog;

--Creando Tablas 

CREATE TABLE usuario(
  id INT,
  email VARCHAR(100) UNIQUE,
  PRIMARY KEY (id)
); 

CREATE TABLE post(
  id INT,
  usuario_id INT, 
  titulo VARCHAR(255),
  fecha DATE,
  PRIMARY KEY(id), 
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE comentario(
  id INT,
  usuario_id INT,
  post_id INT,
  texto VARCHAR(250),
  fecha DATE,
  PRIMARY KEY(id),

  FOREIGN KEY (usuario_id) REFERENCES usuario(id),

  FOREIGN KEY (post_id) REFERENCES post(id)
);
-- Agragando informaciòn a sus respectivas tablas 
\copy usuario FROM 'usuarios.csv' csv header;
\copy post FROM 'post.csv' csv header;
\copy comentario FROM 'comentarios.csv' csv header;


\echo Seleccionar el correo, id y título de todos los post publicados por el usuario 5.

SELECT usuario_id, titulo, email
FROM post INNER JOIN usuario ON usuario.id=post.usuario_id 
WHERE usuario.id=5;

\echo Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com. 

SELECT usuario.email, comentario.* FROM comentario INNER JOIN usuario ON usuario.id=comentario.usuario_id
WHERE  usuario.email != 'usuario06@hotmail.com';

\echo Listar los usuarios que no han publicado ningún post. 

SELECT * FROM usuario LEFT JOIN post ON usuario.id=post.usuario_id WHERE post.usuario_id IS NULL;

\echo Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios). 

SELECT * FROM post FULL OUTER JOIN comentario ON post.id=comentario.post_id;

\echo Listar todos los usuarios que hayan publicado un post en Junio. 

SELECT * from usuario INNER JOIN post ON usuario.id=post.usuario_id WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30';
