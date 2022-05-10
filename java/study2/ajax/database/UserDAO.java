package study2.ajax.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.MysqlConn;

public class UserDAO {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private UserVO vo = null;
	private String sql = new String("");
	
	//페이징 총 레코드(게시판목록)건수
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as totRecCnt from user";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next(); //ResultSet레코드움직이기(count함수는 무조건 0값조차 가져옴)
			totRecCnt = rs.getInt("totRecCnt");
		} catch (SQLException e) {
			e.getMessage();
		} finally {
			instance.rsClose();
			instance.pstmtClose();
		}
		return totRecCnt;
	}
	
	//User 목록 조회
	public List<UserVO> searchUserList(int startIndexNo, int pageSize) {
		List<UserVO> vos = new ArrayList<>();
		try {
			sql = "select * from user order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo = new UserVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				vo.setAddress(rs.getString("address"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}

	public UserVO search(String mid) {
		UserVO vo = null;
		try {
			sql = "select * from user where mid = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo = new UserVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setName(rs.getString("name"));
				vo.setAge(rs.getInt("age"));
				vo.setAddress(rs.getString("address"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vo;
	}

	//User 등록
	public int insert(UserVO vo) {
		int res = 0;
		try {
			sql = "insert into user values ( default, ?, ?, ";
			if (0 == vo.getAge()) {
				sql += " default, ";
			} else {
				sql += " ?, ";
			}
			sql += " ? )";
			
			pstmt = conn.prepareStatement(sql);
			int idx = 0;
			pstmt.setString(++idx, vo.getMid());
			pstmt.setString(++idx, vo.getName());
			if (0 < vo.getAge()) {
				pstmt.setInt(++idx, vo.getAge());
			}
			pstmt.setString(++idx, vo.getAddress());
			res = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	public int delete(int idx) {
		int res = 0;
		try {
			sql = "delete from user where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch(SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;	
	}
}
