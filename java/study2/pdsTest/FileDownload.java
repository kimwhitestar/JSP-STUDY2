package study2.pdsTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fileDownload")
public class FileDownload extends HttpServlet {
	@Override
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		ServletContext application = request.getServletContext();
//		String realPath = application.getRealPath("/data/pdsTest");
		String realPath = request.getServletContext().getRealPath("/data/pdsTest/");
		
		String fName = request.getParameter("file");

		File file = new File(realPath+fName);
		
		//mimeType : 파일 전송방식 - 앞의 형식설정이 없을 경우 2진 바이너리 형식으로 받음
		String mimeType = getServletContext().getMimeType(file.toString()); //http header mimetype
		if (null == mimeType) {
			response.setContentType("application/octet-stream"); //2진 바이너리형식
		}
		// 사용하는 브라우저가 Explorer의 경우 'euc-kr', 나머지는 'utf-8'로 받음
		String downloadName = "";
		if (request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downloadName = new String(fName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downloadName = new String(fName.getBytes("EUC-KR"), "8859_1");
		}
		//다운로드할 파일명과 형식을 헤더파일에 담아서 클라이언트에 전송할 준비를 한다
		response.setHeader("Content-Disposition", "attachment;filename=" + downloadName);
		
		//Java에 의해서 실제로 파일을 다운로드/업로드한다
		FileInputStream fi = new FileInputStream(file);
		ServletOutputStream sos = response.getOutputStream();
		
		//생성된 객체에 실제로 파일을 전송
		byte[] b = new byte[2048];//2kb-안정적
		int data = 0;
		while((data = fi.read(b, 0, b.length)) != -1) {
			sos.write(b, 0, data);
		}
		
		sos.flush();
		sos.close();
		fi.close();
	}
}