package com.example.zero.dao;

import java.math.BigInteger;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.DanhGia;

@Repository
public class DanhGiaDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public boolean addDanhGia(DanhGia danhGia) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(danhGia);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	public List<DanhGia> getDanhSachDanhGia() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<DanhGia> danhSachDanhGia = session.createQuery("from danh_gia d order by d.thoiGianDanhGia desc").getResultList();
		return danhSachDanhGia;
	}

	@Transactional
	public DanhGia getDanhGia(int id) {
		Session session = sessionFactory.getCurrentSession();
		DanhGia danhGia = session.get(DanhGia.class, id);
		return danhGia;
	}

	@Transactional
	public boolean capNhatDanhGia(DanhGia danhGia) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(danhGia);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	public boolean xoaDanhGia(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		int result = session.createQuery("delete from danh_gia where id = :id").setParameter("id", id).executeUpdate();
		return result > 0;
	}

	@Transactional
	public int getSoDanhGiaChuaDoc() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		return ((BigInteger) session.createNativeQuery("SELECT COUNT(*) FROM danh_gia WHERE danh_gia.da_xem = 0 AND danh_gia.da_xoa = 0").getSingleResult()).intValue();
	}
}
