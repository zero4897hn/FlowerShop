package com.example.zero.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity(name = "danh_muc")
public class DanhMuc {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "ten_danh_muc")
	private String tenDanhMuc;
	@JsonManagedReference
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "danhMuc", cascade = {
			CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH
	})
	private List<SanPham> danhSachSanPham;
	public int getId() {
		return id;
	}
	public String getTenDanhMuc() {
		return tenDanhMuc;
	}
	public void setTenDanhMuc(String tenDanhMuc) {
		this.tenDanhMuc = tenDanhMuc;
	}
	public List<SanPham> getDanhSachSanPham() {
		return danhSachSanPham;
	}
	public void addSanPham(SanPham sanPham) {
		if (danhSachSanPham == null) {
			danhSachSanPham = new ArrayList<SanPham>();
		}
		danhSachSanPham.add(sanPham);
		sanPham.setDanhMuc(this);
	}
}
