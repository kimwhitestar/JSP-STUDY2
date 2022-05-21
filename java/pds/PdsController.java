package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.pds")
public class PdsController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PdsInterface command = null;
		String viewPage = "/WEB-INF";
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/")+1, uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		//세션이 끊겼으면, 회원레벨을 비회원으로 바꿔서 작업의 진행을 로그인창으로 보낸다.
//		if (4 < level || 1 == level) { //준회원, 비회원은 비접근
//			request.getRequestDispatcher("/").forward(request, response);
//		}
//		//Pds 목록
//		else 
			if (com.equals("pdsList")) {
			command = new PdsListCommand();
			command.execute(request, response);
			viewPage += "/pds/pdsList.jsp";
		}
		//Pds 추가 
		else
			if (com.equals("pdsInput")) {
			viewPage += "/pds/pdsInput.jsp";
		}
		//Pds 추가 Ok
		else if (com.equals("pdsInputOk")) {
			command = new PdsInputOkCommand();
			command.execute(request, response);
			viewPage = "/message/message.jsp";
		}
		//Pds 내용
		else if (com.equals("pdsContent")) {
			command = new PdsContentCommand();
			command.execute(request, response);
			viewPage += "/pds/pdsContent.jsp";
		}
		//Pds Down 횟수
		else if (com.equals("pdsDownNum")) {
			command = new PdsDownNumCommand();
			command.execute(request, response);
			return;
		}
		//Pds 압축 다운로드
		else if (com.equals("pdsCompress")) {
			command = new PdsCompressCommand();
			command.execute(request, response);
			return;
		}
			
		//Pds 삭제 
		else if (com.equals("pdsDelete")) {
			command = new PdsDeleteCommand();
			command.execute(request, response);
			return;
		}
			

		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}