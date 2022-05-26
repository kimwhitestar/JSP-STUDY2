package emailbox;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.m")
public class EmailboxController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		EmailboxInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		//세션이 끊겼으면, 회원레벨을 비회원으로 바꿔서 작업의 진행을 로그인창으로 보낸다.
		HttpSession session = request.getSession();
//		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		//이메일 main
		if (com.equals("emailboxMain")) {
			command = new EmailboxMainCommand();
			command.execute(request, response);
			viewPage += "/emailbox/emailboxMain.jsp";
		}
		//이메일 작성
		else if (com.equals("emailboxInputOk")) {
			command = new EmailboxInputOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		//휴지통으로
		else if (com.equals("emailboxGabegeOk")) {
			command = new EmailboxGabegeOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		//휴지통 메세지 삭제
		else if (com.equals("emailboxDeleteOk")) {
			command = new EmailboxDeleteOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		//휴지통 비우기
		else if (com.equals("emailboxDeleteAllOk")) {
			command = new EmailboxDeleteAllOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		
		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
