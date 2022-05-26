package emailbox.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.TimeDiff;
import conn.MysqlConn;

public class EmailboxDAO {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private EmailboxVO vo = null;
	private String sql = new String("");

	//메세지 리스트(전체메세지(받은메세지(신규/읽은메세지포함))/신규메세지/보낸메세지/휴지통)
	public List searchEmailboxList(String mid, int mSw) {
		List<EmailboxVO> vos = null;
		try {
			if ( 1 == mSw ) { //전체메세지(받은메세지(신규/읽은메세지포함)
				sql = "select * from emailbox where receiveId = ? and (receiveSw = 'n' or receiveSw = 'r') order by idx desc limit ?, ? ";
			} else if ( 2 == mSw ) { //신규메세지
				sql = "select * from emailbox where receiveId = ? and receiveSw = 'n' order by idx desc limit ?, ? ";
			} else if ( 3 == mSw ) { //보낸메세지
				sql = "select * from emailbox where sendId = ? and sendSw = 's' order by idx desc limit ?, ? ";
			} else if ( 4 == mSw ) { //수신확인
				sql = "select * from emailbox where sendId = ? and receiveSw = 'n' order by idx desc limit ?, ? ";
			} else if ( 5 == mSw ) { //휴지통
				sql = "select * from emailbox where (receiveId = ? and receiveSw = 'g') or (sendId = ? and sendSw = 'g') order by idx desc ";
			} else  { // 0 == mSw 신규메세지 작성이기에 그냥 리턴
				return vos;
			}
			vos = new ArrayList<>();
			TimeDiff diff = new TimeDiff();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			if (5 == mSw) {
				pstmt.setString(2, mid);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) { //1개 검색된 ResultSet DTO의 레코드로 이동 
				vo = new EmailboxVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveDate(rs.getString("receiveDate"));
				vo.setcReceiveDate(rs.getString("receiveDate"));
				vo.setnReceiveDate(diff.timeDiff(vo.getcReceiveDate()));
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
	
	public EmailboxVO search(int idx, int mFlg) {
		try {
			if ( 13 != mFlg ) { //휴지통에서 내용보기가 할 때는 receiveSw 'n'을 'r'로 안바꾼다.
				sql = "update emailbox set receiveSw = 'r', receiveDate = now() where idx = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				int res = pstmt.executeUpdate();
			}
			
			sql = "select * from emailbox where idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if (rs.next()) { //1개 검색된 ResultSet DTO의 레코드로 이동 
				vo = new EmailboxVO();
				vo.setIdx(idx);
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveDate(rs.getString("receiveDate"));
				vo.setcReceiveDate(rs.getString("receiveDate"));
				vo.setnReceiveDate(new TimeDiff().timeDiff(vo.getcReceiveDate()));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			if (null != rs) instance.rsClose();
		}
		return vo;
	}

	public int update(EmailboxVO vo) {
		int res = 0;
		try {
			sql = "update emailbox set ";
			pstmt = conn.prepareStatement(sql);
			int idx = 0;
			pstmt.setString(++idx, vo.getTitle());
			pstmt.setString(++idx, vo.getContent());
			pstmt.setString(++idx, vo.getSendId());
			pstmt.setString(++idx, vo.getReceiveId());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	public int insert(EmailboxVO vo) {
		int res = 0;
		try {
			sql = "insert into emailbox values ( default, ?, ?, ?, 's', default, ?, 'n', default )";
			pstmt = conn.prepareStatement(sql);
			int idx = 0;
			pstmt.setString(++idx, vo.getTitle());
			pstmt.setString(++idx, vo.getContent());
			pstmt.setString(++idx, vo.getSendId());
			pstmt.setString(++idx, vo.getReceiveId());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	public int updateGabege(int idx, int mSw) {
		int res = 0;
		try {
			if ( 11 == mSw ) {
				sql = "update emailbox set receiveSw = 'g' where idx = ? ";
			}
			else { //mSw 12
				sql = "update emailbox set sendSw = 'g' where idx = ? ";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	//휴지통 비우기 receiveSw, sendSw 모두 'x'
	public boolean deleteAll(String mid) {
		boolean isDeleted = true;
		int res = 0;
		try {
			sql = "update emailbox set receiveSw = 'x' where receiveId = ? and receiveSw = 'g' ";
			pstmt = conn.prepareStatement(sql);
			res = pstmt.executeUpdate();
			instance.pstmtClose();
			if (1 > res) isDeleted = false;
			
			sql = "update emailbox set sendSw = 'x' where sendId = ? and sendSw = 'g' ";
			pstmt = conn.prepareStatement(sql);
			res = pstmt.executeUpdate();
			instance.pstmtClose();
			if (1 > res) isDeleted = false;

			sql = "delete from emailbox where receiveSw = 'x' and sendSw = 'x' ";
			pstmt = conn.prepareStatement(sql);
			res = pstmt.executeUpdate();
			if (1 > res) isDeleted = false;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return isDeleted;
	}
}