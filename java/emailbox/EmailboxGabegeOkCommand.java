package emailbox;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import emailbox.database.EmailboxDAO;

public class EmailboxGabegeOkCommand implements EmailboxInterface {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?1:Integer.parseInt(request.getParameter("idx"));
		int mSw = request.getParameter("mSw")==null?1:Integer.parseInt(request.getParameter("mSw"));

		EmailboxDAO dao = new EmailboxDAO();
		int res = dao.updateGabege(idx, mSw);
		if (1 == res) {
			request.setAttribute("msg", "emailboxGabegeOk");
		} else {
			request.setAttribute("msg", "emailboxGabegeNo");
		}
		request.setAttribute("url", request.getContextPath() + "/emailboxMessage.m?mSw=1");
	}
}