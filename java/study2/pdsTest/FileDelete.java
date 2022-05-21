package study2.pdsTest;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fileDelete")
public class FileDelete extends HttpServlet {
		@Override
		protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String fName = request.getParameter("file");
			String realPath = request.getServletContext().getRealPath("/data/pdsTest/");
			
			File file = new File(realPath + fName);

			if (file.exists()) {
				file.delete(); //파일시스템에서 생성된 객체파일 삭제
				response.getWriter().write("fileDeleteOk");
			}
			else {
				response.getWriter().write("fileDeleteNo");
			}
		}
}