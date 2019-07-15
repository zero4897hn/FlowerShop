package com.example.zero.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity(name = "tra_loi_danh_gia")
public class TraLoiDanhGia {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@JsonIgnoreProperties(value = {"danhSachTraLoiDanhGia", "nhanVien", "sanPham"})
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_danh_gia", referencedColumnName = "id")
	private DanhGia danhGia;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_nhan_vien", referencedColumnName = "id")
	@JsonIgnoreProperties(value = {"chungMinhNhanDan", "chucVu", "danhSachDanhGia", "danhSachHoaDon"})
	private NhanVien nhanVien;
	@Column(name = "noi_dung")
	private String noiDung;
	@Column(name = "thoi_gian_tra_loi")
	private Timestamp thoiGianTraLoi;
	@Column(name = "da_xoa")
	private boolean daXoa;
	public int getId() {
		return id;
	}
	public DanhGia getDanhGia() {
		return danhGia;
	}
	public void setDanhGia(DanhGia danhGia) {
		this.danhGia = danhGia;
	}
	public NhanVien getNhanVien() {
		return nhanVien;
	}
	public void setNhanVien(NhanVien nhanVien) {
		this.nhanVien = nhanVien;
	}
	public String getNoiDung() {
		return noiDung;
	}
	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}
	public String getThoiGianTraLoi() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return simpleDateFormat.format(thoiGianTraLoi);
	}
	public boolean isDaXoa() {
		return daXoa;
	}
	public void setDaXoa(boolean daXoa) {
		this.daXoa = daXoa;
	}
}
