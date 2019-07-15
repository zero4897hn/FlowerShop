package com.example.zero.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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
import javax.persistence.ManyToOne;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity(name = "kieu_san_pham")
public class KieuSanPham {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_san_pham", referencedColumnName = "id")
	@JsonIgnoreProperties(value = {"danhSachKieuSanPham", "banRa", "luongMua", "danhSachDanhGia", "moTa"})
	private SanPham sanPham;
	@Column(name = "ten_kieu")
	private String tenKieu;
	@Column(name = "gia_tien")
	private long giaTien;
	@Column(name = "so_luong")
	private int soLuong;
	@Column(name = "luong_mua")
	private int luongMua;
	@Column(name = "ngay_nhap")
	private Timestamp ngayNhap;
	@LazyCollection(LazyCollectionOption.FALSE)
	@ManyToMany(targetEntity = KhuyenMai.class, cascade = {
		CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinTable(name = "chi_tiet_khuyen_mai",
		joinColumns = @JoinColumn(name = "id_kieu_san_pham", referencedColumnName = "id"),
		inverseJoinColumns = @JoinColumn(name = "id_khuyen_mai", referencedColumnName = "id")
	)
	@JsonIgnoreProperties(value = "danhSachKieuSanPham")
	private List<KhuyenMai> danhSachKhuyenMai;
	public int getId() {
		return id;
	}
	public SanPham getSanPham() {
		return sanPham;
	}
	public void setSanPham(SanPham sanPham) {
		this.sanPham = sanPham;
	}
	public String getTenKieu() {
		return tenKieu;
	}
	public void setTenKieu(String tenKieu) {
		this.tenKieu = tenKieu;
	}
	public long getGiaTien() {
		return giaTien;
	}
	public void setGiaTien(long giaTien) {
		this.giaTien = giaTien;
	}
	public int getSoLuong() {
		return soLuong;
	}
	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}
	public int getLuongMua() {
		return luongMua;
	}
	public void setLuongMua(int luongMua) {
		this.luongMua = luongMua;
	}
	public List<KhuyenMai> getDanhSachKhuyenMai() {
		return danhSachKhuyenMai;
	}
	public void setDanhSachKhuyenMai(List<KhuyenMai> danhSachKhuyenMai) {
		this.danhSachKhuyenMai = danhSachKhuyenMai;
	}
	public String getNgayNhap() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return simpleDateFormat.format(ngayNhap);
	}
}