package emailbox;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import emailbox.database.EmailboxDAO;
import emailbox.database.EmailboxVO;

public class EmailboxMessageCommand implements EmailboxInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//String sMid = (String) session.getAttribute("sMid");
		int idx = request.getParameter("idx")==null?1:Integer.parseInt(request.getParameter("idx"));
		int mSw = request.getParameter("mSw")==null?1:Integer.parseInt(request.getParameter("mSw"));
		int mFlg = (request.getParameter("mFlg")==null || request.getParameter("mFlg").equals(""))?1:Integer.parseInt(request.getParameter("mFlg"));

		EmailboxDAO dao = new EmailboxDAO();
		
		if ( 6 == mSw ) { //메세지 상세보기(제목클릭) 처리부문(mSw가 6번으로 넘어온다)
			EmailboxVO vo = dao.search(idx, mFlg);
			request.setAttribute("vo", vo);
			request.setAttribute("mFlg", mFlg);
		} else { //전체메세지
			List vos = dao.searchEmailboxList("", mSw);
			request.setAttribute("vos", vos);
			request.setAttribute("mFlg", mFlg);
		}
		request.setAttribute("mSw", mSw);
	}
}