package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import schedule.database.ScheduleDAO;

@WebServlet("/secheduleDeleteOk")
public class SecheduleDeleteOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		
		ScheduleDAO dao = new ScheduleDAO();
		int res = dao.delete(idx);
		if (1 == res) {
			response.getWriter().write("secheduleDeleteOk");
		} else {
			response.getWriter().write("secheduleDeleteNo");
		}
	}
}