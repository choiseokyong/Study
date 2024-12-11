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
	ResultSet rs = null;
	String query = null;
	ServletContext sc = this.getServletContext();
	
	try{
		Class.forName(sc.getInitParameter("driver"));
		con = DriverManager.getConnection(sc.getInitParameter("url"),sc.getInitParameter("username"),sc.getInitParameter("password"));
		query = "SELECT * FROM student WHERE id=?";
		pst = con.prepareStatement(query);
		pst.setInt(1, id);
		rs = pst.executeQuery();
		
		out.print("<html><head><title>수정</title></head>");
		out.print("<body><h1>수정</h1><hr>");
		if(!rs.next()){
			out.print("데이터가 없습니다.");
		}else{
			out.print("<form action='modify.jsp' method='post'>");
			out.print("<table>");
			out.print("<tr><td><input type='text' name='name' value='"+rs.getString("name")+"' placeholder='이름'></td></tr>");
			out.print("<tr><td><input type='text' name='pwd' value='"+rs.getString("password")+"' placeholder='비밀번호'></td></tr>");
			out.print("<tr><td><input type='text' name='subject' value='"+rs.getString("subject")+"' placeholder='제목'></td></tr>");
			out.print("<tr><td><textarea name='content' rows='3' cols='22'>"+rs.getString("content")+"</textarea></td></tr>");
			out.print("<tr><td><input type='submit' value='수정'><input type='button' value='취소'></td></tr>");
			out.print("</table>");
			out.print("</form>");
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