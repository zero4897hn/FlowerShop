package com.example.zero.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.springframework.lang.Nullable;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity(name = "nhan_vien")
public class NhanVien {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "ten_nhan_vien")
	private String tenNhanVien;
	@Nullable
	@Column(name = "gioi_tinh", nullable = true)
	private Boolean gioiTinh;
	@Column(name = "ngay_sinh")
	private Date ngaySinh;
	@Column(name = "dia_chi")
	private String diaChi;
	@Column(name = "chung_minh_nhan_dan")
	private String chungMinhNhanDan;
	@Column(name = "so_dien_thoai")
	private String soDienThoai;
	@Column(name = "email")
	private String email;
	@OneToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_chuc_vu", referencedColumnName = "id")
	private ChucVu chucVu;
	@Column(name = "avatar")
	private String avatar;
	@Column(name = "ngay_them")
	private Timestamp ngayThem;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "nhanVien", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<DanhGia> danhSachDanhGia;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "nhanVien", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<HoaDon> danhSachHoaDon;
	public int getId() {
		return id;
	}
	public String getTenNhanVien() {
		return tenNhanVien;
	}
	public void setTenNhanVien(String tenNhanVien) {
		this.tenNhanVien = tenNhanVien;
	}
	public String getGioiTinh() {
		if (gioiTinh == null) return "Chưa rõ";
		return gioiTinh? "Nam" : "Nữ";
	}
	public void setGioiTinh(boolean gioiTinh) {
		this.gioiTinh = gioiTinh;
	}
	public String getNgaySinh() {
		if (ngaySinh == null) return "Chưa cập nhật";
		else {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
			return simpleDateFormat.format(ngaySinh);
		}
	}
	public void setNgaySinh(Date ngaySinh) {
		this.ngaySinh = ngaySinh;
	}
	public String getDiaChi() {
		return diaChi;
	}
	public void setDiaChi(String diaChi) {
		this.diaChi = diaChi;
	}
	public String getChungMinhNhanDan() {
		return chungMinhNhanDan;
	}
	public void setChungMinhNhanDan(String chungMinhNhanDan) {
		this.chungMinhNhanDan = chungMinhNhanDan;
	}
	public String getSoDienThoai() {
		return soDienThoai;
	}
	public void setSoDienThoai(String soDienThoai) {
		this.soDienThoai = soDienThoai;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public ChucVu getChucVu() {
		return chucVu;
	}
	public void setChucVu(ChucVu chucVu) {
		this.chucVu = chucVu;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public List<DanhGia> getDanhSachDanhGia() {
		return danhSachDanhGia;
	}
	public void addDanhGia(DanhGia danhGia) {
		if (danhSachDanhGia == null) {
			danhSachDanhGia = new ArrayList<DanhGia>();
		}
		danhSachDanhGia.add(danhGia);
		danhGia.setNhanVien(this);
	}
	public List<HoaDon> getDanhSachHoaDon() {
		return danhSachHoaDon;
	}
	public void addHoaDon(HoaDon hoaDon) {
		if (danhSachHoaDon == null) {
			danhSachHoaDon = new ArrayList<HoaDon>();
		}
		danhSachHoaDon.add(hoaDon);
		hoaDon.setNhanVien(this);
	}
	public String getNgayThem() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return simpleDateFormat.format(ngayThem);
	}
}
