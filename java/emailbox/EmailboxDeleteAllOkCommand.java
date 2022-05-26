package emailbox;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import emailbox.database.EmailboxDAO;

public class EmailboxDeleteAllOkCommand implements EmailboxInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		
		EmailboxDAO dao = new EmailboxDAO();
		boolean isDeletedAll = dao.deleteAll(mid);
		if (isDeletedAll) {
			response.getWriter().write("emailboxDeleteAllOk");
			//request.setAttribute("msg", "emailboxDeleteOk");
		} else {
			response.getWriter().write("emailboxDeleteAllNo");
			//request.setAttribute("msg", "emailboxDeleteNo");
		}
		//request.setAttribute("url", request.getContextPath() + "/emailboxMain.m?mSw=1");
	}
}