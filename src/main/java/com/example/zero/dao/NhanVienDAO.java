package com.example.zero.dao;

import java.math.BigInteger;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.NhanVien;

@Repository
public class NhanVienDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public boolean capNhatNhanVien(NhanVien nhanVien) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(nhanVien);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public NhanVien getNhanVien(int id) {
		try {
			Session session = sessionFactory.getCurrentSession();
			NhanVien nhanVien = session.get(NhanVien.class, id);
			return nhanVien;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Transactional
	public int getSoNhanVienQuanTri() {
		Session session = sessionFactory.getCurrentSession();
		BigInteger bigInteger = (BigInteger) session.createNativeQuery("SELECT COUNT(*) FROM nhan_vien WHERE nhan_vien.id_chuc_vu = :idchucvu")
				.setParameter("idchucvu", 3).getSingleResult();
		return bigInteger.intValue();
	}
}
