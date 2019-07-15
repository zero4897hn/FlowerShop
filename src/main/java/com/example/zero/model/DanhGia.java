package com.example.zero.model;

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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity(name = "danh_gia")
public class DanhGia {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_san_pham", referencedColumnName = "id")
	@JsonIgnoreProperties(value = {"danhSachKieuSanPham", "danhSachDanhGia", "luongMua", "banRa"})
	private SanPham sanPham;
	@ManyToOne(cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	@JoinColumn(name = "id_nhan_vien", referencedColumnName = "id")
	@JsonIgnoreProperties(value = {"danhSachDanhGia", "danhSachHoaDon", "ngayThem", "chungMinhNhanDan"})
	private NhanVien nhanVien;
	@Column(name = "so_sao")
	private Integer soSao;
	@Column(name = "tieu_de")
	private String tieuDe;
	@Column(name = "noi_dung")
	private String noiDung;
	@Column(name = "thoi_gian_danh_gia")
	private Timestamp thoiGianDanhGia;
	@Column(name = "da_xem")
	private boolean daXem;
	@Column(name = "da_xoa")
	private boolean daXoa;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "danhGia", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<TraLoiDanhGia> danhSachTraLoiDanhGia;

	public int getId() {
		return id;
	}
	public Integer getSoSao() {
		return soSao;
	}
	public void setSoSao(Integer soSao) {
		this.soSao = soSao;
	}
	public SanPham getSanPham() {
		return sanPham;
	}
	public void setSanPham(SanPham sanPham) {
		this.sanPham = sanPham;
	}
	public String getTieuDe() {
		return tieuDe;
	}
	public void setTieuDe(String tieuDe) {
		this.tieuDe = tieuDe;
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
	public void setNhanVien(NhanVien nhanVien) {
		this.nhanVien = nhanVien;
	}
	public String getThoiGianDanhGia() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		return simpleDateFormat.format(this.thoiGianDanhGia);
	}
	public List<TraLoiDanhGia> getDanhSachTraLoiDanhGia() {
		return danhSachTraLoiDanhGia;
	}
	public void addTraLoiDanhGia(TraLoiDanhGia traLoiDanhGia) {
		if (danhSachTraLoiDanhGia == null) {
			danhSachTraLoiDanhGia = new ArrayList<TraLoiDanhGia>();
		}
		danhSachTraLoiDanhGia.add(traLoiDanhGia);
		traLoiDanhGia.setDanhGia(this);
	}
	public boolean isDaXem() {
		return daXem;
	}
	public void setDaXem(boolean daXem) {
		this.daXem = daXem;
	}
	public boolean isDaXoa() {
		return daXoa;
	}
	public void setDaXoa(boolean daXoa) {
		this.daXoa = daXoa;
	}
}
