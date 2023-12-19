# Partes de la página.
El proyecto realizado fue la creación de un tipo "marketplace" de artículos de tecnología, aunque se puede enfocar a cualquier sector que queramos modificando los artículos de la base de datos.

Podemos observar tres claros aspectos del proyecto:
  * Base de datos en SQL.
  * Vistas de la página en HTML/CSS.
  * Programación de métodos de la página en C#.

## Base de datos en SQL.
La base de datos fue pensada para poder manejar múltiples proveedores para los mismos artículos, permitiendo la diferente cantidad de precios y existencias por cada uno, lo que hizo el trabajo más difícil de lo normal, para esto se usaron las siguientes tablas extras:
```sql
create table ArticuloUsuarioProv(
cUser int references usuario,
cArticulo varchar(20) references articulo,
cProv int references proveedor,
numero int,
primary key(cUser,cArticulo,cProv)
)

create table ArticuloPedido(
cPedido int primary key references pedido,
cArticulo varchar(20) references articulo
)

create table ProveedorArticulo(
cProv int references proveedor,
cArticulo varchar(20) references articulo,
precio float,
existencia int,
primary key(cProv,cArticulo)
)
```
El punto de las mismas, es el poder actual como carrito de compras en el caso de la primera, el poder tener un registro de los pedidos en la página, y por último, el identificar de que proveedor viene que artículo, ya que los dimos de alta con su SKU, el cual es el mismo para todos los artículos iguales.

Otra cosa de las cosas especiales que hicimos para el administrador fue la creación de una tabla que guardase las ligas a las bases de datos que subían los proveedores, esto para que el se encargue de darlas de alta en el sistema.
```sql
create table excel(
cExcel int primary key,
liga varchar(300) not null,
cProv int references Proveedor
)
```

Por último, permitimos que múltiples tipos de usuarios se dieran de alta en la base de datos, como los clientes y las empresas compartían los mismos atributos, hicimos un vínculo recursivo a la tabla en vez de un vínculo ISA.
```sql
create table usuario(
cUser int primary key,
email varchar(64) not null,
pass varchar(64) not null,
nombre varchar(64) not null,
rfc varchar(18),
cEmpresa int references usuario,
)
```

## Vistas de la página en HTML/CSS.
La página se compone de 7 vistas individuales y 4 archivos de CSS independientes.
  1) account.aspx
  2) article.aspx
  3) articlelist.aspx
  4) cart.aspx
  5) index.aspx
  6) login.aspx
  7) signin.aspx
  8) login.css
  9) signin.css
  10) buscar.css
  11) imagecarousel.css

El nombre de cada página describe lo que hace, todas las páginas tienen añadidos buscar.css como su stylesheet, y login y signin tienen además los stylesheet con su nombre. El imagecarousel se utiliza para aquellas páginas que tengan algún tipo de imágen en ella, especialmente index y article.

## Programación de métodos de la página en C#.
Como sabemos, cada página .aspx tiene anidado su clase C#, además de esas se utilizó la clase `Connection.cs` para la conexión a la base de datos, esta es la que contiene los métodos de strings de conexión, etcétera. No se utilizó ningún otro tipo de clase de C#, y cada página contiene métodos comunes de navegación, que son los siguientes:
```c#
        protected void buscar_Click(object sender, EventArgs e)
        {
            if(buscar.Text != string.Empty)
            {
                Session.Add("articulo", buscar.Text);
                Response.Redirect("articlelist.aspx");
                if (Session["articulo"].ToString() != string.Empty)
                {
                    Session["articulo"] = buscar.Text;
                }
            }
            
        }

        protected void session_Click(object sender, EventArgs e)
        {
            if (Session["cUser"] != null || Session["cProv"] != null || Session["cAdmin"] != null)
            {
                Session.Abandon();
            }
            Response.Redirect("login.aspx");    
        }

        protected void cart_Click(object sender, EventArgs e)
        {
            Response.Redirect("cart.aspx");
        }

        protected void imgbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void cuenta_Click(object sender, EventArgs e)
        {
            Response.Redirect("account.aspx");
        }
```

# Manual de la página.
## Look inicial.
Empezamos con el índice de la página bajo el nombre `index.aspx`, esta página contiene en la parte superior un menú de navegación y búsqueda, así como el contenido que se muestra será diferente para los diferentes tipos de usuarios de la página.

### Iniciar sesión y registrarse.
Para registrarse será necesario seguir los pasos antes mencionados, ingresar los datos que pide los campos de texto y seleccionar que tipo de usuario seremos para la página. Los tipos de usuarios seleccionables son:
  * Cliente.
  * Empresa.
  * Proveedor.

Cliente y empresa se encuentran bajo la misma tabla en la base de datos, pero la empresa debe de registrar su RFC forzosamente, mientras que el cliente no lo necesita hacer. En el caso del proveedor tiene que registrar los mismos datos que la empresa, simplemente que sus credenciales serán guardadas en otra tabla. Al darle clic al botón `Registrarse` se le notificará al usuario si su registro fue existoso.

Después de registrarse, el cliente deberá iniciar sesión en la página, el inició de sesión para todos los usuarios se hace en la misma página de `login.aspx`, incluyendo el de los administradores. Después de esto, el usuario podrá acceder a todas las funcionalidades de la página, el único pero sería que los proveedores y administradores no tienen permitido el comprar artículos, porque obviamente no tiene sentido que exista la tabla clientes si todos pueden comprar lo que quieran.

### Búsqueda de artículos.
En todas las páginas se encuentra una barra de búsqueda junto con un botón, el buscar un artículo nos llevará a la página `articlelist.aspx`, donde un gridview nos mostrará todos los artículos que coinciden con nuestra búsqueda. El gridview tiene un botón de autoseleccionar, el cual nos llevará a la página `article.aspx`, que contendrá el nombre, descripción y proveedores de dicho artículo, mostrado en varios labels y un gridview, en el gridview podremos añadir al carrito el artículo, seleccionando el proveedor y el número de artículos que queremos añadir, si el número de artículos que queremos comprar es más grande que la existencia del proveedor un label nos hará saber esto, diciéndonos que no se pudo agregar al carrito el artículo seleccionado.

### Carrito.
Se encarga de mostrarnos los artículos que hemos añadido a nuestro carrito, tiene forma de enseñarnos el total de todos los artículos dentro del carrito, además de que nos permite pagar por ellos, borrándolos de nuestro carrito e insertándolos dentro de la tabla `pedidos`.

### Cuenta.
Muestra la información del usuario, cosas como el nombre, correo, y el tipo de cuenta (si es cliente, empresa, etcétera), además de contener métodos que pueden ayudar al usuario como el cambio de contraseña o dar de baja su cuenta, algunos de estos métodos están bloqueados para cuentas como proveedores y administradores por seguridad.

Con la anterior explicación es bastante intuitivo el entender la página, es un e-Commerce "programado desde 0", que permite al usuario realizar diferentes funciones, manteniendo el principio de compra-venta entre usuario-proveedor.

# Conclusiones.
El proyecto fue un giro bastante bueno a los conocimientos de HTML previos que tuve, descubrí mi particular odio por CSS otra vez, pero en general fue una buena experiencia. La página tiene métodos bastante complicados, que nos pasamos horas probando hasta que funcionaran como lo pensamos, por lo que esperamos que te agrade de la misma manera que a nosotros.
