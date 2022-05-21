package schedule;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.StudyInterface;

public class CalendarCommand implements CalendarInterface {

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
		
		//오늘기준 달력
		request.setAttribute("toYear", year);
		request.setAttribute("toMonth", month);
		request.setAttribute("toDay", day);
		
		//화면에 보여줄 달력저장
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
	}
}