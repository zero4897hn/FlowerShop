package com.example.zero.model;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity(name = "qua_trinh_van_chuyen")
public class QuaTrinhVanChuyen {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_hoa_don", referencedColumnName = "id")
	@JsonBackReference
	private HoaDon hoaDon;
	@OneToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_tinh_trang", referencedColumnName = "id")
	private TinhTrangHoaDon tinhTrangHoaDon;
	@Column(name = "ghi_chu")
	private String ghiChu;
	@Column(name = "ngay_dien_ra")
	private Timestamp ngayDienRa;
	public int getId() {
		return id;
	}
	public HoaDon getHoaDon() {
		return hoaDon;
	}
	public void setHoaDon(HoaDon hoaDon) {
		this.hoaDon = hoaDon;
	}
	public TinhTrangHoaDon getTinhTrangHoaDon() {
		return tinhTrangHoaDon;
	}
	public void setTinhTrangHoaDon(TinhTrangHoaDon tinhTrangHoaDon) {
		this.tinhTrangHoaDon = tinhTrangHoaDon;
	}
	public String getGhiChu() {
		return ghiChu;
	}
	public void setGhiChu(String ghiChu) {
		this.ghiChu = ghiChu;
	}
	public Timestamp getNgayDienRa() {
		return ngayDienRa;
	}
}
