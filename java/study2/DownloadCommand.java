package study2;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownloadCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pdsTest");
		
		String[] files = new File(realPath).list();//atom.txt화일 생성
		
		for (String file : files) {
			System.out.println("files : " + file);
		}
		request.setAttribute("files", files);
		
	}
}