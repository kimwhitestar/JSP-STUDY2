package study2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.st")
public class StudyController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StudyInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		if (com.equals("el1")) {
			viewPage += "/study2/el_JSTL/el1.jsp";
		}
		else if (com.equals("el2")) {
			viewPage += "/study2/el_JSTL/el2.jsp";
		}
		else if (com.equals("jstl1")) {
			viewPage += "/study2/el_JSTL/jstl1.jsp";
		}
		else if (com.equals("jstl2")) {
			viewPage += "/study2/el_JSTL/jstl2.jsp";
		}
		else if (com.equals("jstl3")) {
			viewPage += "/study2/el_JSTL/jstl3.jsp";
		}
		//nav 메뉴에서 비밀번호 암호화 첫화면에 이동
		else if (com.equals("shaPass")) {
			viewPage += "/study2/sha/shaPass.jsp";
		}
		//암호화한 pwd를 갖고 이동
		else if (com.equals("shaPassOk")) {
			command = new ShaPassOkCommand();
			command.execute(request, response);
			viewPage += "/study2/sha/shaPass.jsp";
		}
		//Ajax1-UserList
		else if (com.equals("userList")) {
			command = new Ajax1Command();
			command.execute(request, response);
			viewPage += "/study2/ajax/ajax1.jsp";
		}
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
