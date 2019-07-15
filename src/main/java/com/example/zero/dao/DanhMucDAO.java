package com.example.zero.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.DanhMuc;

@Repository
public class DanhMucDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public List<DanhMuc> getDanhSachDanhMucSanPham() {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<DanhMuc> danhSachDanhMuc = session.createQuery("from danh_muc").getResultList();
		return danhSachDanhMuc;
	}
	
	@Transactional
	public boolean updateDanhMuc(DanhMuc danhMuc) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(danhMuc);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public DanhMuc getDanhMuc(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		DanhMuc danhMuc = session.get(DanhMuc.class, id);
		return danhMuc;
	}
	
	@Transactional
	public boolean deleteDanhMuc(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		int result = session.createQuery("delete from danh_muc where id = :id")
		.setParameter("id", id).executeUpdate();
		if (result > 0) return true;
		else return false;
	}
	
	@Transactional
	public boolean addDanhMuc(DanhMuc danhMuc) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(danhMuc);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public String getTenDanhMucBySanPham(int idSanPham) {
		Session session = sessionFactory.getCurrentSession();
		String tenDanhMuc = session.createNativeQuery("SELECT danh_muc.ten_danh_muc FROM danh_muc WHERE id IN (SELECT san_pham.id_danh_muc FROM san_pham WHERE san_pham.id = " + idSanPham + ")").getSingleResult().toString();
		return tenDanhMuc;
	}

	@Transactional
	public List<DanhMuc> getDanhSachDanhMuc() {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<DanhMuc> danhSachDanhMuc = session.createQuery("select D.id, D.tenDanhMuc from danh_muc D").getResultList();
		return danhSachDanhMuc;
	}
}
