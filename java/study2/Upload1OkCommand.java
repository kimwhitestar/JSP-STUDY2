package study2;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class Upload1OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//MultipartRequest(저장소이름(request), "서버에 저장될 파일의 경로", "최대용량", "코드변환방식", 기타 옵션(중복방지클래스)
		//***화일업로드 확인인 반드시 WAS재기동 하면 아래 폴더에 data/밑에 'pdsTest/'가 만들어진다
		//**I:\JavaGreenJsp\works\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\javagreenJ\data
		//위의 폴더에 그림이 저장되므로 꼭 백업하기를...
		//***파일업로드 서버에 저장될 실제경로를 찾자! getRealPath() : application객체를 이용하여 사용할 수 있다
		//**I:\JavaGreenJsp\works\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\javagreenJ\
		//.......... ERROR가 있으면 화일업로드 안되므로 태그에러도 꼼꼼히 체크
		
		//application이 서블릿컨텍스트에서 객체를 이용하여 실제 경로를 찾는다
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

		String fName = request.getParameter("fName");
		System.out.println("원본 파일 이름1 fName : " + fName);
		
		//업로드 시킬때의 업로드 파일명
		String orgFName = multiReq.getOriginalFileName("fName");//form의 file 파라미터명
		System.out.println("원본 파일 이름2 orgFName : " + orgFName);
		//실제로 서버(화일시스템)에 저장되는 파일명
		String fileSystemFName = multiReq.getFilesystemName("fName");
		System.out.println("실제로 서버(화일시스템)에 저장되는 파일명3 fName : " + fileSystemFName);
		System.out.println("실제경로 : " + realPath);
		
		if (null == fileSystemFName) {
			request.setAttribute("msg", "upload1No");
		}
		else {
			request.setAttribute("msg", "upload1Ok");
		}
		request.setAttribute("url", request.getContextPath() + "/upload1.st");
	}
}