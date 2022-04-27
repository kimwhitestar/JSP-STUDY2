package study2.mapping2;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.database.LoginDAO;
import study.database.LoginVO;

public class UrlMappingListCommand implements UrlInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginDAO dao = new LoginDAO();
		List<LoginVO> vos = dao.searchLoginList();
		request.setAttribute("vos", vos);
	}
}
