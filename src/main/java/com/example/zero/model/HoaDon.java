package com.example.zero.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity(name = "hoa_don")
public class HoaDon {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "ma_hoa_don")
	private String maHoaDon;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_nhan_vien", referencedColumnName = "id")
	@JsonIgnoreProperties(value = {"danhSachDanhGia", "danhSachHoaDon", "chungMinhNhanDan"})
	private NhanVien nhanVien;
	@Column(name = "ho_ten_nguoi_nhan")
	private String hoTenNguoiNhan;
	@Column(name = "dia_chi_giao_hang")
	private String diaChiGiaoHang;
	@Column(name = "so_dien_thoai")
	private String soDienThoai;
	@Column(name = "ghi_chu")
	private String ghiChu;
	@Column(name = "da_xem")
	private boolean daXem;
	@Column(name = "ngay_lap")
	private Timestamp ngayLap;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "hoaDon", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<DonHang> danhSachDonHang;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "hoaDon", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<QuaTrinhVanChuyen> danhSachQuaTrinh;
	public int getId() {
		return id;
	}
	public String getMaHoaDon() {
		return maHoaDon;
	}
	public String getDiaChiGiaoHang() {
		return diaChiGiaoHang;
	}
	public void setDiaChiGiaoHang(String diaChiGiaoHang) {
		this.diaChiGiaoHang = diaChiGiaoHang;
	}
	public String getSoDienThoai() {
		return soDienThoai;
	}
	public void setSoDienThoai(String soDienThoai) {
		this.soDienThoai = soDienThoai;
	}
	public List<DonHang> getDanhSachDonHang() {
		return danhSachDonHang;
	}
	public void addDonHang(DonHang donHang) {
		if (danhSachDonHang == null) {
			danhSachDonHang = new ArrayList<DonHang>();
		}
		danhSachDonHang.add(donHang);
		donHang.setHoaDon(this);
	}
	public List<QuaTrinhVanChuyen> getDanhSachQuaTrinh() {
		return danhSachQuaTrinh;
	}
	public void addQuaTrinh(QuaTrinhVanChuyen quaTrinhVanChuyen) {
		if (danhSachQuaTrinh == null) {
			danhSachQuaTrinh = new ArrayList<QuaTrinhVanChuyen>();
		}
		danhSachQuaTrinh.add(quaTrinhVanChuyen);
		quaTrinhVanChuyen.setHoaDon(this);
	}
	public NhanVien getNhanVien() {
		return nhanVien;
	}
	public void setNhanVien(NhanVien nhanVien) {
		this.nhanVien = nhanVien;
	}
	public String getHoTenNguoiNhan() {
		return hoTenNguoiNhan;
	}
	public void setHoTenNguoiNhan(String hoTenNguoiNhan) {
		this.hoTenNguoiNhan = hoTenNguoiNhan;
	}
	public String getGhiChu() {
		return ghiChu;
	}
	public void setGhiChu(String ghiChu) {
		this.ghiChu = ghiChu;
	}
	public boolean isDaXem() {
		return daXem;
	}
	public void setDaXem(boolean daXem) {
		this.daXem = daXem;
	}
	public Timestamp getNgayLap() {
		return ngayLap;
	}
	public void setNgayLap(Timestamp ngayLap) {
		this.ngayLap = ngayLap;
	}
}
