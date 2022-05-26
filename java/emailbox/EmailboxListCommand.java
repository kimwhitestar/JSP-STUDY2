package emailbox;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EmailboxListCommand implements EmailboxInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//String sMid = (String) session.getAttribute("sMid");
		int mSw = request.getParameter("mSw")==null?1:Integer.parseInt(request.getParameter("mSw"));
		int mFlg = (request.getParameter("mFlg")==null || request.getParameter("mFlg").equals(""))?1:Integer.parseInt(request.getParameter("mFlg"));

		EmailboxDAO dao = new EmailboxDAO();
		List vos = dao.searchEmailboxList("", mSw);
		
		request.setAttribute("mSw", mSw);
		request.setAttribute("mFlg", mFlg);
		request.setAttribute("vos", vos);
	}
}