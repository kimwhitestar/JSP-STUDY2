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
		
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
