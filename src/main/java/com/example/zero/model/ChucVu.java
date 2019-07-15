package com.example.zero.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity(name = "chuc_vu")
public class ChucVu {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "ten_chuc_vu")
	private String tenChucVu;
	public ChucVu() {
	}
	public ChucVu(String tenChucVu) {
		this.tenChucVu = tenChucVu;
	}
	public int getId() {
		return id;
	}
	public String getTenChucVu() {
		return tenChucVu;
	}
	public void setTenChucVu(String tenChucVu) {
		this.tenChucVu = tenChucVu;
	}
}
