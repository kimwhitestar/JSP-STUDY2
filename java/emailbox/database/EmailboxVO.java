package emailbox.database;

public class EmailboxVO {
	private int idx;				  	
	private String title;			
	private String content; 	  
	private String sendId; 		
	private String sendSw; 		  
	private String sendDate; 	
	private String receiveId;
	private String receiveSw; 	 
	private String receiveDate;
	private String cReceiveDate;
	private int nReceiveDate;
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
	public String getSendSw() {
		return sendSw;
	}
	public void setSendSw(String sendSw) {
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
	public String getReceiveSw() {
		return receiveSw;
	}
	public void setReceiveSw(String receiveSw) {
		this.receiveSw = receiveSw;
	}
	public String getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}
	public String getcReceiveDate() {
		return cReceiveDate;
	}
	public void setcReceiveDate(String cReceiveDate) {
		this.cReceiveDate = cReceiveDate;
	}
	public int getnReceiveDate() {
		return nReceiveDate;
	}
	public void setnReceiveDate(int nReceiveDate) {
		this.nReceiveDate = nReceiveDate;
	}
	@Override
	public String toString() {
		return "EmailboxVO [idx=" + idx + ", title=" + title + ", content=" + content + ", sendId=" + sendId + ", sendSw="
				+ sendSw + ", sendDate=" + sendDate + ", receiveId=" + receiveId + ", receiveSw=" + receiveSw + ", receiveDate="
				+ receiveDate + ", cReceiveDate=" + cReceiveDate + ", nReceiveDate=" + nReceiveDate + "]";
	}
}