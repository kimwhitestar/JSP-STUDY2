package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.cld")
public class CalendarController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CalendarInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		if (com.equals("calendar")) {
			command = new CalendarCommand();
			command.execute(request, response);
			viewPage += "/schedule/calendar.jsp";
		}
		else if (com.equals("calendar2")) {
			command = new Calendar2Command();
			command.execute(request, response);
			viewPage += "/schedule/calendar2.jsp";
		}

		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}