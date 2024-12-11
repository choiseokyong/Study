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
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs = null;
	ServletContext sc = this.getServletContext();
	String sql = null;
	try{
		Class.forName(sc.getInitParameter("driver"));
		con = DriverManager.getConnection(sc.getInitParameter("url"),sc.getInitParameter("username"),sc.getInitParameter("password"));
		sql = "SELECT * FROM student";
		pst = con.prepareStatement(sql);
		rs = pst.executeQuery();
		
		out.print("<html><head><title>목록</title></head>");
		out.print("<body><h1>목록</h1><a href='add.html'>등록</a><hr>");
		if(!rs.next()){
			out.print("등록된 데이터가 없습니다.");
		}else{
			do{
				out.print(rs.getInt("id"));
				out.print(rs.getString("name"));
				out.print(rs.getString("password"));
				out.print(rs.getString("subject"));
				out.print(rs.getString("content"));
				out.print(rs.getString("cre_date"));
				out.print(rs.getString("mod_date")+"<a href='modify_view.jsp?id="+rs.getInt("id")+"'>수정</a>");
				out.print("<a href='delete.jsp?id="+rs.getInt("id")+"'>삭제</a><br>");
			}while(rs.next());
		}
		out.print("</body></html>");
	}catch(ClassNotFoundException e){
		out.print(e);
	}catch(SQLException e){
		out.print(e);
	}finally{
		try{
			if(rs != null) rs.close();
			if(pst != null) pst.close();
			if(con != null) con.close();
		}catch(SQLException e){
			out.print(e);
		}
	}
	
%>
</body>
</html>