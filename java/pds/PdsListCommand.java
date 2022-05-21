package pds;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pds.database.PdsDAO;
import pds.database.PdsVO;

public class PdsListCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PdsDAO dao = new PdsDAO();
		
		String part = request.getParameter("part")==null?"전체":request.getParameter("part");
		List<PdsVO> vos = dao.searchPdsList(part);
		request.setAttribute("vos", vos);
		request.setAttribute("part", part);
	}
}