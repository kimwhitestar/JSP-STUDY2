package study2.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.ajax.database.UserDAO;
import study2.ajax.database.UserVO;


@WebServlet("/ajaxIdSearch3")//url패턴
public class AjaxIdSearch3 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid");
		
		String data = null;
		if (null == mid) {
			data = "id가 null로 넘어왔습니다";
			response.getWriter().write(data);
			return;
		}

		UserVO vo = new UserDAO().search(mid);
		String name = "", address = "";
		int age = 0;
		if (null == vo) {
			data = "찾는 데이타가 없음(서블릿에서 ajax화면으로 전송시 null로는 전송할 수 없음)";
		}
		else {
			mid = vo.getMid();
			name = vo.getName();
			age = vo.getAge();
			address = vo.getAddress();
			//ajax는 자기가 req,res하므로(정해져있다?) request.getRequestDispatcher("갈 주소로 보내기")는 하지않는다
			//response.getWriter()만 있으면 된다 PrintWriter() 객체 생성은 하지않는다
			data = mid + "/" + name  + "/" + age  + "/" + (address==null?"":address);
		}
		System.out.println("data="+data);
		response.getWriter().write(data); //문자로만 보냄.객체로는 못넘김
	}
}
