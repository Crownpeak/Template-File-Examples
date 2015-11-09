 <html>
  <head>
  <script type="text/javascript">
  function CreateExcelSheet()
  {
 var x=document.getElementById("myTable").rows;
 xls = new ActiveXObject("Excel.Application");
 xls.visible = true;
 xls.Workbooks.Add;
 for (i = 0; i < x.length; i++)
  {
   var y = x[i].cells;
   for (j = 0; j < y.length; j++)
   {
    xls.Cells( i+1, j+1).Value = y[j].innerText;
   }
  }
 }
 </script>
  
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
    </head>
    <body>

   <%
  
  set glist = user.getGroupList()
  set ulist = content.createList("")
  debug.log glist
  
  set ugroup = system.createDictionary()
  do while glist.nextEntry()
   set userList = user.getUserList(glist.item("id"))
   do while userList.nextEntry()
    set theUser = user.getUser(userList.item("username"))
    
    uid = theUser.id
    username = theUser.username
    email = theUser.email
    fullname = theUser.getFullName(uid)
    
    if ulist.contains("userid",uid) = false and instr(email,"@crownpeak.com") = 0 then
     set fields = system.createDictionary()
     fields.add "userid",uid
     fields.add "email", email
     fields.add "username",username
     fields.add "fullname",fullname
     
     ulist.addEntry fields
     set fields = nothing
     ugroup.add uid, glist.item("name")
    else
     if glist.item("name") <> "" then
      tempGroup = ""
      tempGroup = ugroup.item(uid)
      tempGroup = tempGroup & "," & glist.item("name")
      ugroup.Remove(uid)
      ugroup.Add uid, tempGroup
     end if
    end if
    
   loop
  loop

  ulist.sort "userid ASC"

  ulist.reset 
  do while ulist.nextEntry()
   'add the group names
   ulist.addItem "groups",ugroup.item(ulist.item("userid"))
  loop
  ulist.reset
  %>
  <form>
  <input type="button" onclick="CreateExcelSheet()" value="Create Excel Sheet">
  </form>
  
  <table id="myTable" border="1">
  <tr>
  <th>User ID</th>
  <th>User Name</th>
  <th>E-Mail</th>
  <th>Full Name</th>
  <th>Group Name</th>
  </tr>
  
  <% do while ulist.nextEntry() %>
  
  
  <tr>
  <td><%=ulist.item("userid")%></td>
  <td><%=ulist.item("username")%></td>
  <td><%=ulist.item("email")%></td>
  <td><%=ulist.item("fullname")%></td>
  <td><%=ulist.item("groups")%></td>
  </tr>
  <% loop %>
  </table>

  
  <%
  
   
   %>

    </body>
</html>
