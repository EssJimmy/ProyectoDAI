<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="ProyectoDAI.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" id="ImageButton1">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>    
    <form id="form1" runat="server">
        <%--//Este div debería ir centrado pero todavia no he metido css asi que tocará esperar--%>
        <div>
            <asp:Image id ="ImageBox1" runat="server" src ="https://www.cyberpuerta.mx/out/cyberpuertaV5/img/logo2.png" ></asp:Image>
            <asp:TextBox id = "TextBox1" runat="server"></asp:TextBox>
            <asp:Button id = "Button1" runat="server" Text="Buscar" OnClick ="Button1_Click"></asp:Button>
            <asp:Button id = "Button2" runat="server" Text="Iniciar sesión" OnClick ="Button2_Click"></asp:Button>
            <asp:Button ID = "Button3" runat="server" Text="Carrito de compras" OnClick ="Button3_Click"></asp:Button>           
        </div>
    </form>
</body>
</html>
