package pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pds.database.PdsDAO;
import pds.database.PdsVO;

public class PdsCompressCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.search(idx);
		
		String[] fNames = vo.getfName().split("/");
		String[] fSNames = vo.getfSName().split("/");
		
		//파일 압축
		ZipOutputStream zo = null;
		FileOutputStream fo = null;
//		ServletOutputStream so = new ServletOutputStream();
		FileInputStream fi = null;

		String realPath = request.getServletContext().getRealPath("/WEB-INF/pds/temp/");
		String zipPath = request.getServletContext().getRealPath("/WEB-INF/pds/temp/zip/");
		String zipName = vo.getTitle() + ".zip";
		
		fo = new FileOutputStream(zipPath + zipName);
		zo = new ZipOutputStream(fo);
		byte[] b = new byte[2048];
		int data = 0;
		File file = null;
		File moveAndRename = null;
		for (int i=0; i<fNames.length; i++) {
			file = new File(realPath + fSNames[i]);
			moveAndRename = new File(realPath + fNames[i]);
			file.renameTo(moveAndRename);
			fi = new FileInputStream(moveAndRename);
			zo.putNextEntry(new ZipEntry(fNames[i]));
			
			while((data = fi.read(b, 0, b.length)) != -1) {
				zo.write(b, 0, data);
			}
			zo.flush();
			zo.closeEntry();
			fi.close();
		}
		
		//mimeType : 파일 전송방식 - 앞의 형식설정이 없을 경우 2진 바이너리 형식으로 받음
		String mimeType = request.getServletContext().getMimeType(file.toString()); //http header mimetype
		if (null == mimeType) {
			response.setContentType("application/octet-stream"); //2진 바이너리형식
		}
		// 사용하는 브라우저가 Explorer의 경우 'euc-kr', 나머지는 'utf-8'로 받음
		String downloadName = "";
		if (request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downloadName = new String(zipName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downloadName = new String(zipName.getBytes("EUC-KR"), "8859_1");
		}
		//다운로드할 파일명과 형식을 헤더파일에 담아서 클라이언트에 전송할 준비를 한다
		response.setHeader("Content-Disposition", "attachment;filename=" + downloadName);
		
		//Java에 의해서 실제로 파일을 다운로드/업로드한다
		fi = new FileInputStream(zipPath + zipName);
		ServletOutputStream sos = response.getOutputStream();
		
		//생성된 객체에 실제로 파일을 전송
		b = new byte[2048];//2kb-안정적
		data = 0;
		while((data = fi.read(b, 0, b.length)) != -1) {
			sos.write(b, 0, data);
		}
		sos.flush();
		fi.close();
		
		new File(zipPath + zipName).delete();
		dao.updatePdsDownNum(idx);
		
	}
}