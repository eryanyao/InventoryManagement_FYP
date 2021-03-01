<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="im_products_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../../assets/css/popout.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-shopping-basket"></i> &nbsp;Products</b> <small style="font-size:x-small;">Manage</small></h3>
    </header>

    <div class="w3-container">
        <asp:Button Text="Add Product" runat="server" ID="btnAdd" CssClass="w3-button w3-border w3-green" OnClick="btnAdd_Click" />
    </div>

      <asp:SqlDataSource ID="brandSQL" runat="server" ConnectionString="<%$ ConnectionStrings:connStr %>" SelectCommand="SELECT * FROM product" UpdateCommand="UPDATE brand SET brand_name = @brand_name, brand_status=@brand_status WHERE Id = @id" DeleteCommand="DELETE FROM brand WHERE Id=@Id;">
        <InsertParameters>
            <asp:Parameter Name="category_name" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="brand_name" />
            <asp:Parameter Name="brand_status" />
            <asp:Parameter Type="String" Name="Id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px; margin-right: 20px; margin-top: 20px;" runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Products</strong></h2>

            <table id="example" class="display" style="width: 99%;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Image</th>
                        <th>SKU</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th style="width: 200px;"></th>
                        
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rBrand" runat="server" DataSourceID="brandSQL">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label Text='<%# Eval("Id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Image ImageUrl='<%# img(Eval("product_img").ToString())%>' Height="100px" runat="server" /> 
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_sku")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_price")%>' runat="server" />
                                </td>
                                <td style="width:200px">
                                    <asp:Label Text='<%# Eval("product_quantity")%>' runat="server" />
                                </td>
                                <td>
                                   <asp:Label ID="lblStatus" Text='<%# show(Eval("product_status").ToString())%>' CssClass='<%# color(Eval("product_status").ToString())%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="btnEdit" CssClass="w3-button w3-green w3-row w3-padding" CommandArgument='<%# Eval("Id")%>' OnCommand="btnEdit_Command" CommandName="ProductId" runat="server" Width="60px" Text="Edit" />
                                     <asp:Button ID="btnDelete" runat="server" CssClass="w3-button w3-red w3-padding"
                                        CommandArgument='<%# Eval("Id")%>' OnCommand="btnDelete_Command" CommandName="brandId"
                                        Width="60px" Text="Delete" />
                                </td>
                 
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>

        <div id="myModal" class="modal" runat="server" visible="false">
        <!-- Modal content -->
        <div class="modal-content">
            <asp:Button Text="&times;" ID="btnCancel" OnClick="btnCancel_Click" BorderStyle="None"
                CssClass="close"
                runat="server" /><br />
            <p class="w3-large">Are you sure you want to delete this item?</p>
            <table class="w3-padding w3-table w3-bordered">
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 100px;"><b>Id</b></td>
                    <td>
                        <asp:Label ID="lblId" Text="1" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 100px;"><b>Image</b></td>
                    <td>
                         <asp:Image ID="ImgPrv" Height="160px" Width="240px" runat="server" CssClass="w3-border w3-image" /></td>

                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 100px;"><b>Name</b></td>
                    <td>
                        <asp:Label ID="lblName" Text="Drink" runat="server"></asp:Label></td>
                </tr>
                
             
            </table>
            <br />
            <br />
            <asp:Button ID="btnDelete" CssClass="w3-button w3-green w3-row w3-padding"
                runat="server" Width="100px" Text="OK" OnClick="btnDelete_Click" />
            <asp:Button ID="btnNo" runat="server" CssClass="w3-button w3-red w3-padding" OnClick="btnCancel_Click"
                Width="100px" Text="Cancel" />
        </div>
    </div>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#example').DataTable();
        });
    </script>
</asp:Content>

