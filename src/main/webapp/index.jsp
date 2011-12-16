<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="de.ingrid.iplug.util.*"%>
<%

String mode = WebUtil.getParameter(request, "mode", "invalid");
if(mode.equals("descriptor")){
	response.sendRedirect(response.encodeRedirectURL("descriptor"));
}else if(mode.equals("query")){
	response.sendRedirect(response.encodeRedirectURL("query?q=wasser"));
}else if(mode.equals("admin")){
	response.sendRedirect(response.encodeRedirectURL("admin"));
}	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Opensearch-Server</title>
<link href="<%=response.encodeURL("admin/css/admin.css")%>" rel="stylesheet" type="text/css" />

</head>
<body>
<center>
    <div class="headline"><br />
        Willkommen zum Opensearch-Server
        <br /><br />
    </div>
    <br />
	<form name="mode" method="post" action="<%=response.encodeURL("index.jsp")%>">
		<table class="table" width="400" align="center">
		    <tr>
		        <td colspan="3" class="tablehead" align="center">Menü</td>
		    </tr>
		    <tr>
                <td class="tablecell"><a href="index.jsp?mode=descriptor"><input type="button" value="Deskriptor anzeigen"/></a></td>
                <td class="tablecell"><a href="index.jsp?mode=query"><input type="button" value="Zur Suchabfrage"/></a></td>
                <td class="tablecell"><a href="index.jsp?mode=admin"><input type="button" value="Zur Adminoberfläche"/></a></td>
		    </tr>
		</table>
	</form>
</center>
</body>
</html>
