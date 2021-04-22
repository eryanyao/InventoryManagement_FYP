<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

    <link href="/assets/css/signin.css" rel="stylesheet">
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet">
    <link rel="shortcut icon" type="image/ico" href="/assets/image/login.png" />
</head>
<body class="text-center">
    <form class="form-signin" runat="server">
      <h1 class="h3 mb-3 font-weight-normal">Inventory Management</h1>
       <asp:TextBox ID="txtUsrname"  class="form-control" runat="server"  placeholder="Username" required autofocus></asp:TextBox>
  
       <asp:TextBox ID="txtPass" runat="server" TextMode="Password" class="form-control" placeholder="Password" required></asp:TextBox>
    
    <asp:Button ID="btnLogin" runat="server"  class="btn btn-lg btn-primary btn-block" runat="server" Text="Login" OnClick="btnLogin_Click" />
      
      <p class="mt-5 mb-3 text-muted">&copy; 2020-2021 &nbsp; ER YAN YAO</p>
    </form>
</body>
</html>
