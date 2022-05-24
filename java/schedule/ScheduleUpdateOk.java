package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import schedule.database.ScheduleDAO;
import schedule.database.ScheduleVO;

@WebServlet("/scheduleUpdateOk")
public class ScheduleUpdateOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		String part = request.getParameter("part")==null?"":request.getParameter("part");
		String content = request.getParameter("content")==null?"":request.getParameter("content");

		ScheduleVO vo = new ScheduleVO();
		vo.setIdx(idx);
		vo.setPart(part);
		vo.setContent(content);
		
		int res = new ScheduleDAO().update(vo);
		
		if (1 == res) {
			response.getWriter().write("scheduleUpdateOk");
		} else {
			response.getWriter().write("scheduleUpdateNo");
		}
	}
}