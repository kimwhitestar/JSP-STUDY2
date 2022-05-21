package study2;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

//멀티 UPLOADING (화일 여러개 한번에 올리기)
public class Upload2OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pdsTest");//컨텍스트Root (window'\\'과 같음)
//		System.out.println("realPath : " + realPath);
		
		int maxSize = 1024 * 1024 * 10; //최대용량을 10MB로 사용하고자 한다
		String encoding = "UTF-8";
		
		//DefaultFileRenamePolicy-중복화일에 1,2,3등 이름바꿔주는클래스
		MultipartRequest multiReq = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		//jsp화일에서 화일 업로드하면,
		//I:\JavaGreenJsp\works\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\javagreenJ\data\pdsTest\
		//위의 폴더안에 그림화일 업로드 저장됨

		Enumeration fileNames =  multiReq.getFileNames();//여러화일 컬렉트로 받기
		String file = "";
		String orgFName = "";
		String fileSystemFName = "";
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement();
			orgFName = multiReq.getOriginalFileName(file);
			fileSystemFName = multiReq.getFilesystemName(file);
			System.out.println("업로드시의 원본 파일명 : " + orgFName);
			System.out.println("실제로 서버(화일시스템)에 저장되는 파일명 : " + fileSystemFName);
		}
		
//		String fName1 = request.getParameter("fName1");
//		String fName2 = request.getParameter("fName2");
//		String fName3 = request.getParameter("fName3");
//		System.out.println("원본 파일 이름1 fName : " + fName1);
//		System.out.println("원본 파일 이름1 fName : " + fName2);
//		System.out.println("원본 파일 이름1 fName : " + fName3);
//		
//		//업로드 시킬때의 업로드 파일명
//		String orgFName = multiReq.getOriginalFileName("fName");//form의 file 파라미터명
//		System.out.println("원본 파일 이름2 orgFName : " + orgFName);
//		//실제로 서버(화일시스템)에 저장되는 파일명
//		String fileSystemFName = multiReq.getFilesystemName("fName");
//		System.out.println("실제로 서버(화일시스템)에 저장되는 파일명3 fName : " + fileSystemFName);
//		System.out.println("실제경로 : " + realPath);
		
		if (null == fileSystemFName) {
			request.setAttribute("msg", "upload1No");
		}
		else {
			request.setAttribute("msg", "upload1Ok");
		}
		int uploadFlag = multiReq.getParameter("uploadFlag")==null?0:Integer.parseInt(multiReq.getParameter("uploadFlag"));
		
		if(0 == uploadFlag ) {
			request.setAttribute("url", request.getContextPath() + "/upload2.st");
		} 
		else if(3 == uploadFlag ) {
			request.setAttribute("url", request.getContextPath() + "/upload3.st");
		}
		else if(4 == uploadFlag ) {
			request.setAttribute("url", request.getContextPath() + "/upload4.st");
		} 
	}
}