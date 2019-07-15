package com.example.zero.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity(name = "khuyen_mai")
public class KhuyenMai {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "ten_khuyen_mai")
	private String tenKhuyenMai;
	@Column(name = "thoi_gian_bat_dau")
	private Timestamp thoiGianBatDau;
	@Column(name = "thoi_gian_ket_thuc")
	private Timestamp thoiGianKetThuc;
	@Column(name = "phan_tram_giam")
	private int phanTramGiam;
	@Column(name = "gia_giam_toi_da")
	private long giaGiamToiDa;
	@Column(name = "mo_ta")
	private String moTa;
	@Column(name = "hinh_khuyen_mai")
	private String hinhKhuyenMai;
	@Column(name = "da_xoa")
	private boolean daXoa;
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany(targetEntity = KieuSanPham.class, cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinTable(name = "chi_tiet_khuyen_mai",
		joinColumns = @JoinColumn(name = "id_khuyen_mai", referencedColumnName = "id"),
		inverseJoinColumns = @JoinColumn(name = "id_kieu_san_pham", referencedColumnName = "id")
	)
	@JsonIgnoreProperties(value = {"danhSachKhuyenMai"})
	private List<KieuSanPham> danhSachKieuSanPham;
	public int getId() {
		return id;
	}
	public String getTenKhuyenMai() {
		return tenKhuyenMai;
	}
	public void setTenKhuyenMai(String tenKhuyenMai) {
		this.tenKhuyenMai = tenKhuyenMai;
	}
	public Timestamp getThoiGianBatDau() {
		return thoiGianBatDau;
	}
	public void setThoiGianBatDau(Timestamp thoiGianBatDau) {
		this.thoiGianBatDau = thoiGianBatDau;
	}
	public Timestamp getThoiGianKetThuc() {
		return thoiGianKetThuc;
	}
	public void setThoiGianKetThuc(Timestamp thoiGianKetThuc) {
		this.thoiGianKetThuc = thoiGianKetThuc;
	}
	public int getPhanTramGiam() {
		return phanTramGiam;
	}
	public void setPhanTramGiam(int phanTramGiam) {
		this.phanTramGiam = phanTramGiam;
	}
	public long getGiaGiamToiDa() {
		return giaGiamToiDa;
	}
	public void setGiaGiamToiDa(long giaGiamToiDa) {
		this.giaGiamToiDa = giaGiamToiDa;
	}
	public String getMoTa() {
		return moTa;
	}
	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}
	public String getHinhKhuyenMai() {
		return hinhKhuyenMai;
	}
	public void setHinhKhuyenMai(String hinhKhuyenMai) {
		this.hinhKhuyenMai = hinhKhuyenMai;
	}
	public List<KieuSanPham> getDanhSachKieuSanPham() {
		return danhSachKieuSanPham;
	}
	public void setDanhSachKieuSanPham(List<KieuSanPham> danhSachKieuSanPham) {
		this.danhSachKieuSanPham = danhSachKieuSanPham;
	}
	public boolean isDaXoa() {
		return daXoa;
	}
	public void setDaXoa(boolean daXoa) {
		this.daXoa = daXoa;
	}
}