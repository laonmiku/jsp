package model;

import java.util.Date;

public class UserVO {
	private String uid;
	private String upass;
	private String uname;
	private String phone;
	private String address1;
	private String address2;
	private String photo;
	private Date jdate;
	private Date udate;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUpass() {
		return upass;
	}
	public void setUpass(String upass) {
		this.upass = upass;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	
	
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
//	@Override
//	public String toString() {
//		return "UserVO [uid=" + uid + ", upass=" + upass + ", uname=" + uname + "]";
//	}
	
	/*마이페이지,조인,업데이트~~~*/
	
	
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public Date getJdate() {
		return jdate;
	}
	public void setJdate(Date jdate) {
		this.jdate = jdate;
	}
	public Date getUdate() {
		return udate;
	}
	public void setUdate(Date udate) {
		this.udate = udate;
	}
	@Override
	public String toString() {
		return "UserVO [uid=" + uid + ", upass=" + upass + ", uname=" + uname + ", phone=" + phone + ", address1="
				+ address1 + ", address2=" + address2 + ", photo=" + photo + ", jdate=" + jdate + ", udate=" + udate
				+ "]";
	}
	
	
}
