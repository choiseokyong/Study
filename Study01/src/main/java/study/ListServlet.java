package study;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/study/list")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
		PreparedStatement pst = null;
		String query = null;
		ServletContext sc = getServletContext();
		ResultSet rs = null;
		PrintWriter out = response.getWriter();
		response.setContentType("text/html;charset=UTF-8");
		
		try {
			Class.forName(sc.getInitParameter("driver"));
			con = DriverManager.getConnection(sc.getInitParameter("url"),sc.getInitParameter("username"),sc.getInitParameter("password"));
			query = "SELECT * FROM student";
			pst = con.prepareStatement(query);
			rs = pst.executeQuery();
			
			out.print("<html><head><title>목록</title></head>");
			out.print("<body><h1>목록</h1><hr>");
			if(!rs.next()) {
				out.print("데이터가 없습니다.");
			}else {
				do {
					out.print(rs.getInt("id"));
					out.print(rs.getString("name"));
					out.print(rs.getString("password"));
					out.print(rs.getString("subject"));
					out.print(rs.getString("content"));
					out.print(rs.getString("cre_date"));
					out.print(rs.getString("mod_date")+"<br>");
				}while(rs.next());
			}
			out.print("</body></html>");
		}catch(ClassNotFoundException e) {
			out.print(e);
		}catch(SQLException e) {
			out.print(e);
		}finally {
			try {
				if(rs != null) rs.close();
				if(pst != null) rs.close();
				if(con != null) rs.close();
			}catch(SQLException e) {
				out.print(e);
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
