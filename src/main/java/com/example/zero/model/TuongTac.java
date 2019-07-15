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

@Entity(name = "tuong_tac")
public class TuongTac {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "truong_tuong_tac")
	private String truongTuongTac;
	@Column(name = "id_tuong_tac")
	private Integer idTuongTac;
	@Column(name = "ten_tuong_tac")
	private String tenTuongTac;
	@Column(name = "noi_dung")
	private String noiDung;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_nhan_vien", referencedColumnName = "id")
	@JsonIgnoreProperties(value = {"danhSachDanhGia", "danhSachHoaDon", "chungMinhNhanDan", "diaChi", "ngayThem", "chucVu"})
	private NhanVien nhanVien;
	@Column(name = "thoi_gian_tuong_tac")
	private Timestamp thoiGianTuongTac;
	public int getId() {
		return id;
	}
	public String getTruongTuongTac() {
		return truongTuongTac;
	}
	public void setTruongTuongTac(String truongTuongTac) {
		this.truongTuongTac = truongTuongTac;
	}
	public Integer getIdTuongTac() {
		return idTuongTac;
	}
	public void setIdTuongTac(Integer idTuongTac) {
		this.idTuongTac = idTuongTac;
	}
	public String getNoiDung() {
		return noiDung;
	}
	public void setNoiDung(String noiDung) {
		this.noiDung = noiDung;
	}
	public NhanVien getNhanVien() {
		return nhanVien;
	}
	public String getTenTuongTac() {
		return tenTuongTac;
	}
	public void setTenTuongTac(String tenTuongTac) {
		this.tenTuongTac = tenTuongTac;
	}
	public void setNhanVien(NhanVien nhanVien) {
		this.nhanVien = nhanVien;
	}
	public String getThoiGianTuongTac() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return simpleDateFormat.format(thoiGianTuongTac);
	}
}
