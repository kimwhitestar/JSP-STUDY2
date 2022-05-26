package emailbox;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EmailboxInputOkCommand implements EmailboxInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		//String sMid = (String) session.getAttribute("sMid");
		int mSw = request.getParameter("mSw")==null?1:Integer.parseInt(request.getParameter("mSw"));
		int mFlg = (request.getParameter("mFlg")==null || request.getParameter("mFlg").equals(""))?1:Integer.parseInt(request.getParameter("mFlg"));
		String sendId = request.getParameter("sendId");
		String receiveId = request.getParameter("receiveId");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		EmailboxDAO dao = new EmailboxDAO();
		EmailboxVO vo = new EmailboxVO();
		vo.setSendId(sendId);
		vo.setReceiveId(receiveId);
		vo.setTitle(title);
		vo.setContent(content);
		
		int res = dao.insert(vo);
		if (1 == res) {
			request.setAttribute("msg", "emailboxInputOk");
			request.setAttribute("url", request.getContextPath() + "/emailboxMessage.m?mSw=3");
		} else {
			request.setAttribute("msg", "emailboxInputNo");
			request.setAttribute("url", request.getContextPath() + "/emailboxMessage.m?mSw=4");
		}
	}
}