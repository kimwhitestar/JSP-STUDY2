package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import schedule.database.ScheduleDAO;
import schedule.database.ScheduleVO;

@WebServlet("/scheduleInputOk")
public class ScheduleInputOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null?"":request.getParameter("mid");
		String ymd = request.getParameter("ymd")==null?"":request.getParameter("ymd");
		String part = request.getParameter("part")==null?"":request.getParameter("part");
		String content = request.getParameter("content")==null?"":request.getParameter("content");

		ScheduleVO vo = new ScheduleVO();
		vo.setMid(mid);
		vo.setsDate(ymd);
		vo.setPart(part);
		vo.setContent(content);
		
		int res = new ScheduleDAO().insert(vo);
		
		if (1 == res) {
			response.getWriter().write("scheduleInputOk");
		} else {
			response.getWriter().write("scheduleInputNo");
		}
	}
}