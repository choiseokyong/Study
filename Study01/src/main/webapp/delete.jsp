<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	Connection con = null;
	PreparedStatement pst = null;
	String query = null;
	ServletContext sc = this.getServletContext();
	
	try{
		Class.forName(sc.getInitParameter("driver"));
		con = DriverManager.getConnection(sc.getInitParameter("url"),sc.getInitParameter("username"),sc.getInitParameter("password"));
		query = "DELETE FROM student WHERE id=?";
		pst = con.prepareStatement(query);
		pst.setInt(1,id);
		pst.executeUpdate();
		
	}catch(ClassNotFoundException e){
		out.print(e);
	}catch(SQLException e){
		out.print(e);
	}finally{
		try{
			if(pst != null) pst.close();
			if(con != null) con.close();
		}catch(SQLException e){
			out.print(e);
		}
	}

	response.sendRedirect("list.jsp");

%>
</body>
</html>