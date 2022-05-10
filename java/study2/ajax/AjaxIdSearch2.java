package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.ajax.database.UserDAO;
import study2.ajax.database.UserVO;


@WebServlet("/ajaxIdSearch2")//url패턴
public class AjaxIdSearch2 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid");
		
		if (null == mid) {
			response.getWriter().write("id가 null로 넘어왔습니다");
			return;
		}
		
		UserVO vo = new UserDAO().search(mid);
		if (null==vo) {
			response.getWriter().write("찾는 자료가 없습니다.");
			return;
		}
		
		//ajax는 자기가 req,res하므로(정해져있다?) request.getRequestDispatcher("갈 주소로 보내기")는 하지않는다
		//response.getWriter()만 있으면 된다 PrintWriter() 객체 생성은 하지않는다
		String name = vo.getName();
		response.getWriter().write(name);
	}
}
