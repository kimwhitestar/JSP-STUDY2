package study2.ajax;

public class UserVO {
	private int idx;
	private String mid;
	private String name;
	private String age;
	private String address;

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "UserVO [address=" + address + ", age=" + age + ", idx=" + idx + ", mid=" + mid + ", name=" + name
				+ ", getAddress()=" + getAddress() + ", getAge()=" + getAge() + ", getIdx()=" + getIdx() + ", getMid()="
				+ getMid() + ", getName()=" + getName() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
}
