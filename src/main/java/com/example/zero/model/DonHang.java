package com.example.zero.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity(name = "don_hang")
public class DonHang {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_kieu_san_pham", referencedColumnName = "id")
	private KieuSanPham kieuSanPham;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_hoa_don", referencedColumnName = "id")
	@JsonBackReference
	private HoaDon hoaDon;
	@Column(name = "so_luong")
	private int soLuong;
	@Column(name = "thanh_tien")
	private long thanhTien;
	public int getId() {
		return id;
	}
	public KieuSanPham getKieuSanPham() {
		return kieuSanPham;
	}
	public void setKieuSanPham(KieuSanPham kieuSanPham) {
		this.kieuSanPham = kieuSanPham;
	}
	public HoaDon getHoaDon() {
		return hoaDon;
	}
	public void setHoaDon(HoaDon hoaDon) {
		this.hoaDon = hoaDon;
	}
	public int getSoLuong() {
		return soLuong;
	}
	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}
	public long getThanhTien() {
		return thanhTien;
	}
	public void setThanhTien(long thanhTien) {
		this.thanhTien = thanhTien;
	}
}
