package com.example.zero.model;

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

@Entity(name = "san_pham")
public class SanPham {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "ten_san_pham")
	private String tenSanPham;
	@Column(name = "hinh_anh")
	private String hinhAnh;
	@Column(name = "mo_ta")
	private String moTa;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_danh_muc", referencedColumnName = "id")
	@JsonIgnoreProperties(value = {"danhSachSanPham", "hinhDanhMuc"})
	private DanhMuc danhMuc;
	@Column(name = "ban_ra")
	private boolean banRa;
	@Column(name = "da_xoa")
	private boolean daXoa;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "sanPham", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<KieuSanPham> danhSachKieuSanPham;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "sanPham", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<DanhGia> danhSachDanhGia;
	public SanPham() {
	}
	public SanPham(String tenSanPham, String hinhAnh, String moTa) {
		this.tenSanPham = tenSanPham;
		this.hinhAnh = hinhAnh;
		this.moTa = moTa;
	}
	public SanPham(String tenSanPham, String hinhAnh, String moTa, DanhMuc danhMuc) {
		this.tenSanPham = tenSanPham;
		this.hinhAnh = hinhAnh;
		this.moTa = moTa;
		this.danhMuc = danhMuc;
	}
	public int getId() {
		return id;
	}
	public String getTenSanPham() {
		return tenSanPham;
	}
	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}
	public String getHinhAnh() {
		return hinhAnh;
	}
	public void setHinhAnh(String hinhAnh) {
		this.hinhAnh = hinhAnh;
	}
	public String getMoTa() {
		return moTa;
	}
	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}
	public DanhMuc getDanhMuc() {
		return danhMuc;
	}
	public void setDanhMuc(DanhMuc danhMuc) {
		this.danhMuc = danhMuc;
	}
	public List<KieuSanPham> getDanhSachKieuSanPham() {
		return danhSachKieuSanPham;
	}
	public void addDanhSachKieuSanPham(KieuSanPham kieuSanPham) {
		if (danhSachKieuSanPham == null) {
			danhSachKieuSanPham = new ArrayList<KieuSanPham>();
		}
		danhSachKieuSanPham.add(kieuSanPham);
		kieuSanPham.setSanPham(this);
	}
	public void setDanhSachKieuSanPham(List<KieuSanPham> danhSachKieuSanPham) {
		this.danhSachKieuSanPham = danhSachKieuSanPham;
	}
	public List<DanhGia> getDanhSachDanhGia() {
		return danhSachDanhGia;
	}
	public void addDanhGia(DanhGia danhGia) {
		if (danhSachDanhGia == null) {
			danhSachDanhGia = new ArrayList<DanhGia>();
		}
		danhSachDanhGia.add(danhGia);
		danhGia.setSanPham(this);
	}
	public boolean isBanRa() {
		return banRa;
	}
	public void setBanRa(boolean banRa) {
		this.banRa = banRa;
	}
	public boolean isDaXoa() {
		return daXoa;
	}
	public void setDaXoa(boolean daXoa) {
		this.daXoa = daXoa;
	}
}
