package study2.mapping2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//FrontController는 service구현객체에서 dao로 회원목록을 가져와, 'urlMapping.um'확장자로 넘어온 요청을, 'urlMapping'서블릿주소URL을 참조해서 응답화일jsp로 이동한다.
@WebServlet("*.um")
public class UrlController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UrlInterface command = null;
		String viewPage = null;
		
		String uri = request.getRequestURI();
		System.out.println("uri : " + uri);
		
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		System.out.println("command object name : " + com);

		if (com.equals("urlMapping")) {
			viewPage = "/WEB-INF/study2/mapping/urlMapping.jsp";
		}
		else if (com.equals("urlMappingList")) {
			
			command = new UrlMappingListCommand(); 
			command.execute(request, response);/*request객체에 dao에서 검색한 회원목록을 셋팅함*/
			viewPage = "/WEB-INF/study2/mapping/urlMappingList.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}