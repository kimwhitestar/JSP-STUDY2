package study2;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.Paging;
import study2.ajax.UserDAO;
import study2.ajax.UserVO;

public class Ajax1Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		
		Paging paging = new Paging(request, response);
		int pageNo = request.getParameter("pageNo")==null?0:Integer.parseInt(request.getParameter("pageNo"));
		paging.setPaging(pageNo, dao.totRecCnt(), 3, 3);
		
		List<UserVO> vos = dao.searchUserList(paging.getStartIndexNo(), paging.getPageSize());
		request.setAttribute("vos", vos);
	}
}