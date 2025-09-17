## INTEGRANTES.
| Nombre | Cargo | URL GitHub |
|---|:---:|---:|
| Daniel Alquinga | 馃悰 Desarrollador | https://github.com/superdavi/Practica1_Grupo2.git |
| Daniel Baldeon | 馃悰 Desarrollador | https://github.com/debpdhs/Practica1_Grupo2 |
| Bryan Mi帽o | 馃惡 Desarrollador |https://github.com/bmiomi/tareadocker |
| Wilson Segovia | 馃悰 Desarrollador | https://github.com/segoviawilson/Practica1_Grupo2.git|
| Leonardo Tuguminago | 馃悰 Desarrollador | https://github.com/Tuguminago/Proyectos.git |

# Sistema de Gesti贸n de Veh铆culos con Docker

Este proyecto implementa un sistema de gesti贸n de veh铆culos utilizando Docker, MySQL y phpMyAdmin. El sistema permite administrar propietarios y sus veh铆culos mediante una base de datos relacional.

## Arquitectura del Sistema

- **MySQL 8.3**: Base de datos para almacenar informaci贸n de propietarios y veh铆culos
- **phpMyAdmin 5.2.2**: Interfaz web para administraci贸n de la base de datos
- **Docker Network**: Red personalizada para comunicaci贸n entre contenedores

## Configuraci贸n e Instalaci贸n

### PASO 1: Configuraci贸n de Contenedores Docker

```bash
# MySQL
docker run -d \
--name db-mysql-vehiculos \
--network netw-vehiculos \
--env-file .env \
-v mysql_data:/var/lib/mysql \
-v "$PWD"/init.sql:/docker-entrypoint-initdb.d/init.sql \
-p 3306:3306 \
mysql:8.3

# phpMyAdmin
docker run -d \
--name web_phpmyadmin_vehiculos \
--network netw-vehiculos \
--env-file .env \
-e PMA_HOST=db-mysql-vehiculos \
-p 8080:80 \
phpmyadmin:5.2.2
```

**Explicaci贸n:**
- **MySQL Container**: Crea un contenedor con MySQL 8.3, monta un volumen persistente para los datos y ejecuta un script de inicializaci贸n
- **phpMyAdmin Container**: Proporciona interfaz web conectada al contenedor MySQL
- **Network**: Ambos contenedores utilizan la red personalizada `netw-vehiculos`
- **Volumes**: Persistencia de datos MySQL y script de inicializaci贸n
- **Ports**: MySQL en puerto 3306, phpMyAdmin en puerto 8080
**Captura de la Ejecuci贸n**
<img width="886" height="609" alt="image" src="https://github.com/user-attachments/assets/ee9c91e9-a51f-4880-9fc3-50803a45073c" />

### PASO 2: Estructura de Base de Datos (init.sql)

```sql
-- Crear tabla de propietario
CREATE TABLE propietario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cedula VARCHAR(15) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(150)
);

-- Crear tabla de vehiculo
CREATE TABLE vehiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(8) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL,
    propietario_id INT,
    FOREIGN KEY (propietario_id) REFERENCES propietario(id)
);

-- Insertar registros en propietario
INSERT INTO propietario (cedula, nombre, telefono, direccion) VALUES
('1111111111', 'Daniel Alquinga', '0992222222', 'ABC'),
('1222222222', 'Leonardo Tuguminago', '0993333333', 'DEF'),
('1333333333', 'Bryan Mi帽o', '0994444444', 'GHI'),
('1444444444', 'Wilson Segovia', '0995555555', 'JKL'),
('1555555555', 'Daniel Baldeon', '0996666666', 'MNO');

-- Insertar registros en vehiculo
INSERT INTO vehiculo (placa, marca, modelo, anio, propietario_id) VALUES
('PBB-5555', 'Hyundai', 'i10', 2018, 1),
('PBB-2222', 'Mazda', 'Cx3', 2012, 2),
('PBB-3333', 'Chevrolet', 'Aveo', 2017, 3),
('PBB-9999', 'Nissan', 'Sentra', 2019, 4),
('PCC-4444', 'Toyota', '4Runner', 2022, 5);
```

**Explicaci贸n:**
- **Tabla propietario**: Almacena informaci贸n personal de los due帽os de veh铆culos
- **Tabla vehiculo**: Contiene datos de los veh铆culos con referencia al propietario
- **Relaci贸n**: Clave for谩nea entre veh铆culo y propietario (1:N)
- **Datos de prueba**: 5 propietarios y 5 veh铆culos para testing
**Captura de la Ejecuci贸n**
<img width="886" height="886" alt="image" src="https://github.com/user-attachments/assets/0d18e38a-4db4-466e-b965-7ddac3243d8c" />

### PASO 3: Creaci贸n de Red Docker

```bash
docker network create --driver bridge netw-vehiculos
docker network ls
```
**Captura de la Ejecuci贸n**

<img width="886" height="213" alt="image" src="https://github.com/user-attachments/assets/08eda610-37bd-415f-aed4-d355f445a46b" />

**Salida esperada:**
```
NETWORK ID     NAME             DRIVER    SCOPE
c768b266264f   bridge           bridge    local
e21e631237e9   host             host      local
ef173c5efe1b   netw-vehiculos   bridge    local
dd26efa30c17   none             null      local
```
**Captura de la Ejecuci贸n**
<img width="886" height="213" alt="image" src="https://github.com/user-attachments/assets/91472fb3-f8d7-495c-b728-c12773b8fc36" />

**Explicaci贸n:**
- Crea una red personalizada tipo `bridge` llamada `netw-vehiculos`
- Permite comunicaci贸n entre contenedores por nombre
- Aislamiento de red del resto del sistema

# PASO 4: Descarga y Ejecuci贸n de MySql
# Ejecutar el contenedor MySQL
docker run -d --name db-mysql-vehiculos --network netw-vehiculos --env-file .env -v mysql_data:/var/lib/mysql -p 3306:3306 mysql:8.3

# Verificar estado de contenedores
<img width="886" height="180" alt="image" src="https://github.com/user-attachments/assets/73bc67d7-a332-40b4-9525-fc2ba37221f1" />

Explicaci贸n:
- CONTAINER ID: Identificador 煤nico del contenedor (39bc102b715e)
- IMAGE: Imagen utilizada (mysql:8.3)
- COMMAND: Comando de entrada ejecutado
- CREATED/STATUS: Tiempo de creaci贸n y estado actual
- PORTS: Mapeo de puertos - MySQL accesible en puerto 3306 tanto en IPv4 como IPv6
- NAMES: Nombre asignado al contenedor (db-mysql-vehiculos)
- Estado: "Up 9 seconds" indica que el contenedor est谩 ejecut谩ndose correctamente

### PASO 5: Descarga y Ejecuci贸n de phpMyAdmin

```bash
docker run -d \
--name web_phpmyadmin_vehiculos \
--network netw-vehiculos \
--env-file .env \
-e PMA_HOST=db-mysql-vehiculos \
-p 8080:80 \
phpmyadmin:5.2.2
```

**Salida:**
```
Unable to find image 'phpmyadmin:5.2.2' locally
5.2.2: Pulling from library/phpmyadmin
[Capas descargadas...]
Pull complete
```

**Explicaci贸n:**
- Docker descarga la imagen phpMyAdmin si no existe localmente
- Configura la conexi贸n al contenedor MySQL mediante `PMA_HOST`
- Expone el servicio web en el puerto 8080

## Configuraci贸n Adicional

### Archivo .env
```env
MYSQL_ROOT_PASSWORD=tu_password_seguro
MYSQL_DATABASE=vehiculos_db
MYSQL_USER=vehiculos_user
MYSQL_PASSWORD=vehiculos_pass
```

### Comandos 脷tiles

```bash
# Ver contenedores en ejecuci贸n
docker ps

# Ver logs de un contenedor
docker logs db-mysql-vehiculos

# Conectar a MySQL directamente
docker exec -it db-mysql-vehiculos mysql -u root -p

# Detener todos los contenedores
docker stop db-mysql-vehiculos web_phpmyadmin_vehiculos

# Eliminar contenedores
docker rm db-mysql-vehiculos web_phpmyadmin_vehiculos

# Eliminar red
docker network rm netw-vehiculos
```

## Acceso al Sistema

- **phpMyAdmin**: http://localhost:8080
- **MySQL directo**: localhost:3306
- **Credenciales**: Configuradas en el archivo `.env`

<img width="886" height="419" alt="image" src="https://github.com/user-attachments/assets/b08f4e44-b7a5-4059-a62f-17b2b74a4ff4" />
<img width="886" height="469" alt="image" src="https://github.com/user-attachments/assets/621bd885-4111-48cf-994e-f85104e800b4" />


## Estructura del Proyecto

```
PracticaGrupo2/
鈹溾攢鈹€ .env
鈹溾攢鈹€ init.sql
鈹溾攢鈹€ despliegue.txt
鈹斺攢鈹€ README.md
```

## Caracter铆sticas T茅cnicas

- **Persistencia**: Los datos se mantienen entre reinicios del contenedor
- **Escalabilidad**: F谩cil agregar m谩s contenedores o servicios
- **Seguridad**: Red aislada y variables de entorno para credenciales
- **Mantenibilidad**: Configuraci贸n declarativa y reproducible

# Conclusiones

-Logros Alcanzados

Implementaci贸n Exitosa de Microservicios: Se logr贸 configurar un sistema distribuido utilizando Docker, separando la base de datos (MySQL) de la interfaz de administraci贸n (phpMyAdmin) en contenedores independientes.
Gesti贸n Eficiente de Redes: La creaci贸n de la red personalizada netw-vehiculos permiti贸 la comunicaci贸n segura entre contenedores, eliminando la necesidad de exponer servicios innecesarios al host.
Persistencia de Datos Garantizada: El uso de vol煤menes Docker (mysql_data) asegura que la informaci贸n de propietarios y veh铆culos se mantenga intacta entre reinicios del sistema.
Automatizaci贸n de Inicializaci贸n: El script init.sql automatiza la creaci贸n de tablas y datos de prueba, reduciendo errores manuales y garantizando consistencia en diferentes entornos.
Separaci贸n de Configuraci贸n: El archivo .env centraliza las variables sensibles, mejorando la seguridad y facilitando el despliegue en diferentes ambientes.

Beneficios Obtenidos

- Portabilidad: El sistema puede ejecutarse en cualquier m谩quina con Docker instalado
- Escalabilidad: F谩cil agregar nuevos servicios o r茅plicas de contenedores
- Mantenibilidad: Cada servicio se actualiza independientemente
- Aislamiento: Los fallos en un contenedor no afectan a otros servicios
- Reproducibilidad: El entorno se puede recrear exactamente en cualquier momento

# Recomendaciones.

 - Es necesario crear primero la red Docker y luego el contenedor, ya que este inconveniente se presento al momento de ejecutar la practica. 
 - Se debe validar que la versi贸n de MySQL sea compatible con phpMyAdmin, ya que una incompatibilidad entre ambas versiones podr铆a causar errores al intentar levantar el contenedor.
