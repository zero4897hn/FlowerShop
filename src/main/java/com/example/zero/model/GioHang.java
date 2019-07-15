package com.example.zero.model;

public class GioHang {
	int idKieuSanPham;
	int soLuong;
	public GioHang() {
	}
	public GioHang(int idKieuSanPham, int soLuong) {
		this.idKieuSanPham = idKieuSanPham;
		this.soLuong = soLuong;
	}
	public int getIdKieuSanPham() {
		return idKieuSanPham;
	}
	public void setIdKieuSanPham(int idKieuSanPham) {
		this.idKieuSanPham = idKieuSanPham;
	}
	public int getSoLuong() {
		return soLuong;
	}
	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.idKieuSanPham + "";
	}
}
