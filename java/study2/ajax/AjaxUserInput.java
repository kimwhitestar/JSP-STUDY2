package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.ajax.database.UserDAO;
import study2.ajax.database.UserVO;

@WebServlet("/ajaxUserInput")
public class AjaxUserInput extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = new UserDAO();
		
		String mid = request.getParameter("mid");
		String name = request.getParameter("name");
		int age = 0;
		if (null!=request.getParameter("age") && !request.getParameter("age").trim().equals(""))  
			age = Integer.parseInt(request.getParameter("age"));
		String address = request.getParameter("address");

		if (null == mid || null == name) {
			response.getWriter().write("0");//insert res = 0(등록실패)
			return;
		}
		
		//아이디 중복 체크-여기서는 그냥 회원정보가져온 vo의 mid로 비교
		UserVO vo = dao.search(mid);
		if (null != vo && vo.getMid().equals(mid)) {
			response.getWriter().write("0");//insert res = 0(등록실패)
			return;
		}
		
		UserVO insertVO = new UserVO();
		insertVO.setMid(mid);
		insertVO.setName(name);
		insertVO.setAge(age);
		insertVO.setAddress(address);
		int res = dao.insert(insertVO);
		response.getWriter().write(String.valueOf(res));//insert res = 1(등록성공) , 0(등록실패<sql exception>)
	}
}
