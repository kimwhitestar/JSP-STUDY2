package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardListCommand;

@WebServlet("*.scdl")
public class ScheduleController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ScheduleInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		//세션이 끊겼으면, 회원레벨을 비회원으로 바꿔서 작업의 진행을 로그인창으로 보낸다.
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
//		if (4 < level) {
//			request.getRequestDispatcher("/").forward(request, response);
//		}
//		//게시판목록(검색키 조회)
//		else 
		if (com.equals("schedule")) {
			command = new ScheduleCommand();
			command.execute(request, response);
			viewPage += "/schedule/schedule.jsp";
		}
		else if (com.equals("scMenu")) {
			command = new ScMenuCommand();
			command.execute(request, response);
			viewPage += "/schedule/scMenu.jsp";
		}
		else if (com.equals("scContent")) {
			command = new ScContentCommand();
			command.execute(request, response);
			viewPage += "/schedule/scContent.jsp";
		}
		else if (com.equals("scheduleUpdate")) {
			viewPage += "/schedule/scUpdate.jsp";
		}
		
//		else if (com.equals("calendar")) {
//			command = new CalendarCommand();
//			command.execute(request, response);
//			viewPage += "/schedule/calendar.jsp";
//		}
//		else if (com.equals("calendar2")) {
//			command = new Calendar2Command();
//			command.execute(request, response);
//			viewPage += "/schedule/calendar2.jsp";
//		}

		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}