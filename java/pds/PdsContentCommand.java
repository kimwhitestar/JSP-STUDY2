package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pds.database.PdsDAO;
import pds.database.PdsVO;

public class PdsContentCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		int pageNo = request.getParameter("pageNo")==null?0:Integer.parseInt(request.getParameter("pageNo"));
		String part = request.getParameter("idx")==null?"":request.getParameter("part");
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.search(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("part", part);
	}
}
