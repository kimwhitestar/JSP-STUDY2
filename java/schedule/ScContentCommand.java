package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import schedule.database.ScheduleDAO;
import schedule.database.ScheduleVO;

public class ScContentCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		String ymd = request.getParameter("ymd")==null?"":request.getParameter("ymd");
		
		ScheduleVO vo = new ScheduleDAO().searchScContent(idx);
		vo.setYmd(ymd);
		
		request.setAttribute("vo", vo);
	}
}