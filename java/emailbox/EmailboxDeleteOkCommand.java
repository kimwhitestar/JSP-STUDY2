package emailbox;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import emailbox.database.EmailboxDAO;

public class EmailboxDeleteOkCommand implements EmailboxInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?1:Integer.parseInt(request.getParameter("idx"));
		int mFlg = request.getParameter("mFlg")==null?1:Integer.parseInt(request.getParameter("mFlg"));

		EmailboxDAO dao = new EmailboxDAO();
		int res = dao.updateGabege(idx, mFlg);
		if (1 == res) {
			response.getWriter().write("emailboxDeleteOk");
			//request.setAttribute("msg", "emailboxDeleteOk");
		} else {
			response.getWriter().write("emailboxDeleteNo");
			//request.setAttribute("msg", "emailboxDeleteNo");
		}
		//request.setAttribute("url", request.getContextPath() + "/emailboxMain.m?mSw=1");

	}
}