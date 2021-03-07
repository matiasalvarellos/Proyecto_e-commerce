-- Creamos la DB
CREATE SCHEMA bazar_db;

-- Seleccionamos la DB
USE bazar_db;

-- Creamos la tabla USERS
CREATE TABLE users(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    type_customer VARCHAR(255) NOT NULL,
    phone varchar(100) DEFAULT NULL,
    address varchar(100) DEFAULT NULL,
    dni varchar(100) DEFAULT NULL,
    post_code varchar(100) DEFAULT NULL, 
    avatar VARCHAR(255) NOT NULL,
    admin TINYINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creamos la tabla PRODUCTS
CREATE TABLE products(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    cost INT UNSIGNED NOT NULL,
    stock INT UNSIGNED NOT NULL,
    description TEXT NOT NULL,
    markup INT UNSIGNED NOT NULL,
    discount INT UNSIGNED NOT NULL,
    price INT UNSIGNED NOT NULL,
    subcategory_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creamos la tabla IMAGES
CREATE TABLE images(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creamos la tabla COLORS
CREATE TABLE colors(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    hexadecimal VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Creamos la tabla pivot PRODUCT_COLOR (PRODUCTS - COLORS)
CREATE TABLE product_color(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id INT UNSIGNED NOT NULL,
    color_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- Creamos la tabla CATEGORIES
CREATE TABLE categories(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO categories (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'PORCELANAS', '2021-02-25 23:49:20', '2021-02-25 23:49:20'),
(2, 'CUBIERTOS', '2021-02-25 23:53:06', '2021-02-25 23:53:06'),
(3, 'CRISTALERIA', '2021-02-25 23:53:33', '2021-02-25 23:53:33'),
(4, 'ARTICULOS DE COCINA', '2021-02-25 23:53:45', '2021-02-25 23:53:45'),
(5, 'SERVICIO', '2021-02-25 23:53:53', '2021-02-25 23:53:53');

-- --------------------------------------------------------

-- Creamos la tabla SUBCATEGORIES
CREATE TABLE subcategories(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--
-- Volcado de datos para la tabla `subcategories`
--

INSERT INTO subcategories (`id`, `name`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Cacerolas', 4, '2021-02-25 23:55:12', '2021-02-25 23:55:12'),
(2, 'Sartenes', 4, '2021-02-25 23:55:44', '2021-02-25 23:55:44'),
(3, 'Cuchilleria', 4, '2021-02-25 23:56:23', '2021-02-25 23:56:23'),
(4, 'Copas', 3, '2021-02-25 23:56:47', '2021-02-25 23:56:47'),
(5, 'Cuchillos', 2, '2021-02-25 23:57:24', '2021-02-25 23:57:24'),
(6, 'Platos', 1, '2021-02-25 23:57:59', '2021-02-25 23:57:59'),
(7, 'Cafeteria', 1, '2021-02-25 23:58:23', '2021-02-25 23:58:23'),
(8, 'Exhibicion', 5, '2021-02-25 23:58:57', '2021-02-25 23:58:57'),
(9, 'Tenedores', 2, '2021-02-26 00:11:45', '2021-02-26 00:11:45'),
(10, 'Vasos', 3, '2021-02-26 01:12:10', '2021-02-26 01:12:10');


--
-- Arranca el carrito
--

-- Creamos la tabla de ORDERS
CREATE TABLE orders(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    total_price INT UNSIGNED NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creamos la tabla ITEMS

CREATE TABLE items(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price INT UNSIGNED NOT NULL,
    subtotal INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    image VARCHAR(255) NOT NULL,
    user_id INT UNSIGNED NOT NULL,
    order_id INT UNSIGNED DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
--
-- Inicia creación de FK
--

ALTER TABLE orders
ADD FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE items
ADD FOREIGN KEY (user_id) REFERENCES users(id),
ADD FOREIGN KEY (order_id) REFERENCES orders(id);

ALTER TABLE subcategories
ADD FOREIGN KEY (category_id) REFERENCES categories(id);

ALTER TABLE images
ADD FOREIGN KEY (product_id) REFERENCES products(id);

ALTER TABLE products
ADD FOREIGN KEY (subcategory_id) REFERENCES subcategories(id);

ALTER TABLE product_color
ADD FOREIGN KEY (product_id) REFERENCES products(id),
ADD FOREIGN KEY (color_id) REFERENCES colors(id);

-- volcado de productos --

INSERT INTO products (`id`, `code`, `name`, `cost`, `stock`, `description`, `markup`, `discount`, `price`, `subcategory_id`, `created_at`, `updated_at`) VALUES
 (1, 0, 'Plato Playo', 613, 200, 'PLATO PLAYO X 27 CM PORCELANA TSUJI MOD. CUADRATTO 2400-77', 60, 0, 981, 6, '2021-02-26 00:03:56', '2021-02-26 00:03:56'),
 (2, 0, 'Cuchillo de Asado', 204, 250, 'CUCHILLO DE ASADO MGO. JUMBO TRAMONTINA MODELO POLYWOOD 03-21116/075', 60, 0, 326, 5, '2021-02-26 00:09:17', '2021-02-26 00:09:17'),
 (3, 0, 'Tenedores de Mesa', 1038, 450, 'TENEDOR DE MESA DE ACERO INOXIDABLE \" TRAMONTINA\" MODELO OSLO ART 63985/020', 65, 0, 1713, 9, '2021-02-26 00:15:03', '2021-02-26 00:15:03'),
 (4, 0, 'Cacerolas altas', 3850, 50, 'CACEROLA ALTAS C/ASAS Y TAPA ACERO INOXIDABLE TRAMONTINA LINEA SOLAR  X 24 CM CAP: 5.7 LTS ART 10-62504/240', 75, 0, 6738, 1, '2021-02-26 00:19:14', '2021-02-26 00:19:14'),
 (5, 0, 'Sarten', 3790, 30, 'LINEA TRAMONTINA  PROFESIONAL - SARTEN ACERO INOXIDABLE TRIPLE FONDO CON RECUBRIMIENTO INTERIOR CERAMICO- Ø 30 - ART 62635/304', 80, 0, 6822, 2, '2021-02-26 00:21:38', '2021-02-26 00:21:38'),
 (6, 0, 'Cuchillo de Cocina', 2335, 500, 'CUCHILLO DE COCINA X 10´´ - TRAMONTINA LINEA CENTURY ART. 24011-110', 80, 0, 4203, 3, '2021-02-26 00:39:01', '2021-02-26 00:39:01'),
 (7, 0, 'Cuchillas de Ceramica', 2745, 0, '	CUCHILLAS DE CERAMICA LINEA ACCURATTO - LAMINAS DE CERAMICA CON ALTA RESISTENCIA AL DESGASTE Y ALTA PRECISION AL CORTE. CUCHILLOS CARNICERO X 7\" ART 24193/007													\r\n', 85, 0, 5078, 3, '2021-02-26 00:43:41', '2021-02-26 00:43:41'),
 (8, 0, 'Chaffing Dish ', 18860, 5, 'CHAFFING  DISH ACERO INOX. MOD ROLL TOP TAPA DESLIZANTE TRAMONTINA  ART 61043-10', 80, 0, 33948, 8, '2021-02-26 00:55:10', '2021-02-26 00:55:10'),
 (9, 0, 'Cacerola Alta', 5470, 35, 'CACEROLA  ALTA LINEA RIFINATTA- ALUMINIO 3 MM  CON TAPA- COLOR ROJO-  ANTIADHERENTE T3 - DIMENSIONES Ø 250 MM CODIGO 20913/724', 65, 0, 9026, 1, '2021-02-26 00:58:32', '2021-02-26 00:58:32'),
 (10, 0, 'Copa Modelo', 217, 300, 'COPA MODELO VINA PRINCE  VINO STEMLESS SIN PIERNA ART 221 X 503 ML', 80, 0, 391, 4, '2021-02-26 01:01:59', '2021-02-26 01:01:59'),
 (11, 0, 'Copa ', 200, 0, 'COPA MODELO CACTUS MARGARITA  ART 3619JS X 355 ML', 60, 0, 320, 4, '2021-02-26 01:03:52', '2021-02-26 01:03:52'),
 (12, 0, 'Plato de Te', 110, 120, 'PLATO DE TE PORCELANA BLANCA TSUJI LINEA BOMBE  DESCENTRADO ART 1900-19', 60, 0, 176, 7, '2021-02-26 01:05:25', '2021-02-26 01:05:25'),
 (13, 0, 'Taza de Te', 143, 80, 'TAZA DE TE PORCELANA BLANCA TSUJI LINEA BOMBE  DESCENTRADO ART 1900-32													\r\n', 60, 0, 229, 7, '2021-02-26 01:07:48', '2021-02-26 01:07:48'),
 (14, 0, 'VASO ', 112, 175, 'VASO TEMPLADO MODELO GIBRALTAR  BEVERAGE X 355 ML ART 15238', 65, 0, 185, 10, '2021-02-26 01:13:42', '2021-02-26 01:13:42');


 INSERT INTO images (`id`, `name`, `product_id`, `created_at`, `updated_at`) VALUES
    (1, 'image-1614297836695.jpg', 1, '2021-02-26 00:03:56', '2021-02-26 00:03:56'),
    (2, 'image-1614298157857.jpg', 2, '2021-02-26 00:09:17', '2021-02-26 00:09:17'),
    (3, 'image-1614298503231.jpg', 3, '2021-02-26 00:15:03', '2021-02-26 00:15:03'),
    (4, 'image-1614298754075.jpg', 4, '2021-02-26 00:19:14', '2021-02-26 00:19:14'),
    (5, 'image-1614298898645.jpg', 5, '2021-02-26 00:21:38', '2021-02-26 00:21:38'),
    (6, 'image-1614299941409.jpg', 6, '2021-02-26 00:39:01', '2021-02-26 00:39:01'),
    (7, 'image-1614300221243.jpg', 7, '2021-02-26 00:43:41', '2021-02-26 00:43:41'),
    (8, 'image-1614301112987.jpg', 9, '2021-02-26 00:58:32', '2021-02-26 00:58:32'),
    (9, 'image-1614301319914.jpg', 10, '2021-02-26 01:01:59', '2021-02-26 01:01:59'),
    (10, 'image-1614301432808.jpg', 11, '2021-02-26 01:03:52', '2021-02-26 01:03:52'),
    (11, 'image-1614301525057.jpg', 12, '2021-02-26 01:05:25', '2021-02-26 01:05:25'),
    (12, 'image-1614301668743.jpg', 13, '2021-02-26 01:07:48', '2021-02-26 01:07:48'),
    (13, 'image-1614302022736.png', 14, '2021-02-26 01:13:42', '2021-02-26 01:13:42');

    -- Volcamos la informacion de color
    
    INSERT INTO colors (`id`, `name`, `hexadecimal`, `created_at`, `updated_at`) VALUES
(3, 'Acero', '#45cbd8', '2021-02-25 23:59:37', '2021-02-25 23:59:37'),
(4, 'Blanco', '#45cbd8', '2021-02-25 23:59:51', '2021-02-25 23:59:51'),
(5, 'Negro', '#45cbd8', '2021-02-25 23:59:55', '2021-02-25 23:59:55'),
(6, 'Rojo', '#45cbd8', '2021-02-26 00:00:21', '2021-02-26 00:00:21'),
(7, 'Cobre', '#45cbd8', '2021-02-26 00:00:25', '2021-02-26 00:00:25'),
(8, 'Transparente', '#45cbd8', '2021-02-26 00:00:37', '2021-02-26 00:00:37');
    
    -- Volcamos la informacion de product_color

INSERT INTO product_color (`id`, `product_id`, `color_id`, `created_at`, `updated_at`) VALUES
(1, 1, 4, '2021-02-26 00:03:56', '2021-02-26 00:03:56'),
(2, 2, 3, '2021-02-26 00:09:17', '2021-02-26 00:09:17'),
(3, 3, 3, '2021-02-26 00:15:03', '2021-02-26 00:15:03'),
(4, 4, 3, '2021-02-26 00:19:14', '2021-02-26 00:19:14'),
(5, 5, 3, '2021-02-26 00:21:38', '2021-02-26 00:21:38'),
(6, 6, 3, '2021-02-26 00:39:01', '2021-02-26 00:39:01'),
(7, 7, 5, '2021-02-26 00:43:41', '2021-02-26 00:43:41'),
(8, 8, 3, '2021-02-26 00:55:10', '2021-02-26 00:55:10'),
(9, 9, 6, '2021-02-26 00:58:32', '2021-02-26 00:58:32'),
(10, 10, 8, '2021-02-26 01:01:59', '2021-02-26 01:01:59'),
(11, 11, 8, '2021-02-26 01:03:52', '2021-02-26 01:03:52'),
(12, 12, 4, '2021-02-26 01:05:25', '2021-02-26 01:05:25'),
(13, 13, 4, '2021-02-26 01:07:48', '2021-02-26 01:07:48'),
(14, 14, 8, '2021-02-26 01:13:42', '2021-02-26 01:13:42');