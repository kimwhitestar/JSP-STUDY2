package schedule;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import schedule.database.ScheduleDAO;
import schedule.database.ScheduleVO;

public class ScheduleCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//오늘날짜처리(저장)
		Calendar cld = Calendar.getInstance();
		int year = cld.get(Calendar.YEAR);
		int month = cld.get(Calendar.MONTH);
		int day = cld.get(Calendar.DATE);
		
		//화면에 보여줄 해당 '년/월' 셋팅
		Calendar cldView = Calendar.getInstance();
		int yy = request.getParameter("yy")==null? year : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null? month : Integer.parseInt(request.getParameter("mm"));
		int dd = request.getParameter("dd")==null? day : Integer.parseInt(request.getParameter("dd"));

		//앞에서 넘어온 변수(yy,mm)값이 '1월'이나 또는 '12월'이었다면 편집
		//1월은 '0', 12월은 '11'
		if (0 > mm) {
			yy--;
			mm = 11;
		}
		if (11 < mm) {
			yy++;
			mm = 0;
		}
		
		cldView.set(yy, mm, dd); //해당 년도/월의 1일을 기준으로 설정
		int startWeek = cldView.get(Calendar.DAY_OF_WEEK); //해당일의 요일 숫자 
		int lastDay = cldView.getActualMaximum(Calendar.DAY_OF_MONTH); //해당월의 마지막일자
		
		//달력 앞쪽 빈공간과 뒷쪽 빈공간에 이전/다음 월의 날짜를 채워서 출력
		int prevYear = yy;
		int prevMonth = (mm) - 1;
		int nextYear = yy;
		int nextMonth = (mm) + 1;
		
		if (-1 == prevMonth) {
			prevYear --;
			prevMonth = 11;
		}
		if (12 == nextMonth) {
			nextYear++;
			nextMonth = 0;
		}
		Calendar cldPrev = Calendar.getInstance();
		cldPrev.set(prevYear, prevMonth, 1);
		int prevLastDay = cldPrev.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		Calendar cldNext = Calendar.getInstance();
		cldNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = cldNext.get(Calendar.DAY_OF_WEEK);
		
		//오늘기준 달력
		request.setAttribute("toYear", year);
		request.setAttribute("toMonth", month);
		request.setAttribute("toDay", day);
		
		//화면에 보여줄 달력저장
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		//현재달의 이전월/다음월 날짜
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		
		request.setAttribute("prevLastDay", prevLastDay);
		request.setAttribute("nextStartWeek", nextStartWeek);

		//스케줄에 등록되어 있는 그달에 해당하는 일정
		HttpSession session = request.getSession();
		String sMid = (String)session.getAttribute("sMid");
		
		//날짜 date format
		String ym = "";
		int tempMM = mm + 1;
		if (tempMM >= 1 && tempMM <= 9) {
			ym = yy + "-0" + (mm + 1);
		}
		else {
			ym = yy + "-" + (mm + 1);
		}
		
		ScheduleDAO dao = new ScheduleDAO();
		List<ScheduleVO> vos = dao.searchScheduleList(sMid, ym);
		System.out.println("vos : " + vos);
		
		request.setAttribute("vos", vos);
	}
}