package study2.mapping;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//URL확장자 디렉토리패턴
@WebServlet("*.url")
public class UrlMappingController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doAction(req, res);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doAction(req, res);
	}
	
	protected void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuffer url = request.getRequestURL();
		System.out.println("url : " + url);
		
		String uri = request.getRequestURI();
		System.out.println("uri : " + uri);
		
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		System.out.println("command object name : " + com);

		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('콘솔창을 확인해 보세요...');");
/*컨트롤러서블릿(*.url) -> 컨트롤러서블릿(/url)로 이동 처리*/
//		out.println("location.href='/WEB-INF/study2/mapping/urlMapping.jsp';");//GET방식 loation접근안됨
		out.println("location.href='"+request.getContextPath()+"/study1/urlMapping';");//컨트롤러서블릿주소필요
		out.println("</script>");
	}
}
