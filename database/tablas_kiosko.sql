create database kiosko_prog3;
use kiosko_prog3;

create table usuarios(
	id_usuario int auto_increment primary key,
    nombre_usuario varchar(100) not null,
    email_usuario varchar(100) not null unique,
    password varchar(100) not null,
    rol enum('ADMIN','EMPLEADO') default 'EMPLEADO',
    fecha_creacion timestamp default current_timestamp
    );
    
create table categorias (
	id_categoria int auto_increment primary key,
	nombre_categoria varchar(100) not null unique
);
    
    create table productos(
    id_producto int auto_increment primary key,
    nombre_producto varchar(150) not null,
    precio decimal(10,2)not null,
    stock int not null default 0,
    
    id_categoria int not null,
    
    constraint fk_producto_categoria
		foreign key (id_categoria)
        references categorias (id_categoria)
        on update cascade
        on delete restrict /*no borrar categoria si hay productso utlizando*/
    
    );
    
create table clientes(
id_cliente int auto_increment primary key,
nombre_cliente varchar(150) not null,
apellido_cliente varchar(150) not null,
telefono_cliente varchar(20),
email_cliente varchar(100)
);

create table ventas (
	id_venta int auto_increment primary key,
    fecha_venta datetime default current_timestamp,
    total_venta decimal (10,2) not null,
    
    id_cliente int not null,
    id_usuario int not null,
    
    constraint fk_venta_cliente
		foreign key (id_cliente)
        references clientes (id_cliente)
        on update cascade
        on delete restrict,
        
	constraint fk_venta_usuario
		foreign key (id_usuario)
        references usuarios (id_usuario)
        on update cascade
        on delete restrict
);

create table detalle_venta( /*relacion de muchos a muchos*/
id_venta int not null,
id_producto int not null,

cantidad int not null,
precio_unitario decimal(10,2)not null,
subtotal decimal (10,2) not null,

primary key (id_venta, id_producto),

constraint fk_detalle_venta
	foreign key (id_venta)
    references ventas (id_venta)
    on update cascade
    on delete cascade,
    
constraint fk_detalle_producto
	foreign key (id_producto)
    references productos (id_producto)
    on update cascade
    on delete restrict
);