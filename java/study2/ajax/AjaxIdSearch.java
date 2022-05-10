package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ajaxIdSearch")//url패턴
public class AjaxIdSearch extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid");
		String mid2 = request.getParameter("mid2");
System.out.printf("mid=%s mid2=%s \n", mid, mid2);
		
		UserDAO dao = new UserDAO();
		UserVO vo = dao.search(mid);
		
		String name = "";
		
		if (null == vo.getName()) {
			name = "찾는 자료가 없습니다";
		}
		else {
			name = vo.getName();
		}
		
		//ajax는 자기가 req,res하므로(정해져있다?) request.getRequestDispatcher("갈 주소로 보내기")는 하지않는다
		//response.getWriter()만 있으면 된다 PrintWriter() 객체 생성은 하지않는다
		response.getWriter().write(name);
	}
}
