<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="article.aspx.cs" Inherits="ProyectoDAI.article" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image id ="Image1" runat="server"  src ="https://www.cyberpuerta.mx/out/cyberpuertaV5/img/logo2.png"></asp:Image>
            <asp:TextBox id = "TextBox1" runat="server"></asp:TextBox>
            <asp:Button id = "Button1" runat="server" Text="Buscar" OnClick ="Button1_Click"></asp:Button>
            <asp:Button id = "Button2" runat="server" Text="Iniciar sesión" OnClick ="Button2_Click"></asp:Button>
            <asp:Button ID = "Button3" runat="server" Text="Carrito de compras" OnClick ="Button3_Click"></asp:Button>
        </div>
        <div id ="show">
            <asp:Image id ="Image2" runat="server" src ="https://i.blogs.es/ceda9c/dalle/450_1000.jpg" ></asp:Image>
            <asp:Label runat="server"  ID="Label1"></asp:Label>
        </div>
        <div>
            <asp:Button runat ="server" ID ="Button4" Text ="Agregar al carrito" OnClick ="Button4_Click"></asp:Button>
        </div>
    </form>
</body>
</html>
