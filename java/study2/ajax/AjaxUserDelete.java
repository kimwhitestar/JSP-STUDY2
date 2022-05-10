package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.ajax.database.UserDAO;

@WebServlet("/ajaxUserDelete")
public class AjaxUserDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (null == request.getParameter("idx") || request.getParameter("idx").trim().equals("")) {
			response.getWriter().write("0");
			return;
		}
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		UserDAO dao = new UserDAO();
		int res = dao.delete(idx);
		
		response.getWriter().write(String.valueOf(res));
	}
}
