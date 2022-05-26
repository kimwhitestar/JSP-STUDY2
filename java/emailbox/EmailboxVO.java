package emailbox;

public class EmailboxVO {
	private int idx;				  	
	private String title;			
	private String content; 	  
	private String sendId; 		
	private char sendSw; 		  
	private String sendDate; 	
	private String receiveId; 	
	private char receiveSw; 	 
	private String receiveDate;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSendId() {
		return sendId;
	}
	public void setSendId(String sendId) {
		this.sendId = sendId;
	}
	public char getSendSw() {
		return sendSw;
	}
	public void setSendSw(char sendSw) {
		this.sendSw = sendSw;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getReceiveId() {
		return receiveId;
	}
	public void setReceiveId(String receiveId) {
		this.receiveId = receiveId;
	}
	public char getReceiveSw() {
		return receiveSw;
	}
	public void setReceiveSw(char receiveSw) {
		this.receiveSw = receiveSw;
	}
	public String getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}
	@Override
	public String toString() {
		return "EmailboxVO [idx=" + idx + ", title=" + title + ", content=" + content + ", sendId=" + sendId + ", sendSw="
				+ sendSw + ", sendDate=" + sendDate + ", receiveId=" + receiveId + ", receiveSw=" + receiveSw + ", receiveDate="
				+ receiveDate + "]";
	}
}