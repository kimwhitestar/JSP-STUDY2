package schedule;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import schedule.database.ScheduleDAO;
import schedule.database.ScheduleVO;

public class ScMenuCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String sMid = (String)session.getAttribute("sMid");
		String ymd = request.getParameter("ymd")==null?"":request.getParameter("ymd");
		
		String[] ymds = ymd.split("-");
		if (1 == ymds[1].length()) ymds[1] = "0" + ymds[1];
		if (1 == ymds[2].length()) ymds[2] = "0" + ymds[2];
		ymd = ymds[0] + "-" + ymds[1] + "-" + ymds[2];
		
		ScheduleDAO dao = new ScheduleDAO();
		List<ScheduleVO> vos = dao.searchScMenu(sMid, ymd);
		System.out.println("vos : " + vos);
		
		request.setAttribute("vos", vos);
		request.setAttribute("scheduleCnt", vos.size());
		request.setAttribute("ymd", ymd);
	}
}