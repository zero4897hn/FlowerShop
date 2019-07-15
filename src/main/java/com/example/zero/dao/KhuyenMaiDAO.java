package com.example.zero.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.KhuyenMai;

@Repository
public class KhuyenMaiDAO {
	@Autowired
	SessionFactory sessionFactory;

	@Transactional
	public boolean themKhuyenMai(KhuyenMai khuyenMai) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(khuyenMai);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	public List<KhuyenMai> getDanhSachKhuyenMai() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<KhuyenMai> danhSachKhuyenMai = session.createQuery("from khuyen_mai").getResultList();
		return danhSachKhuyenMai;
	}

	@Transactional
	public boolean removeKhuyenMai(int id) {
		Session session = sessionFactory.getCurrentSession();
		int result = session.createQuery("delete from khuyen_mai where id = :id").setParameter("id", id).executeUpdate();
		return result > 0;
	}

	@Transactional
	public KhuyenMai getKhuyenMai(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		KhuyenMai khuyenMai = session.get(KhuyenMai.class, id);
		return khuyenMai;
	}

	@Transactional
	public boolean updateKhuyenMai(KhuyenMai khuyenMai) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(khuyenMai);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	public void deleteSanPhamCoKhuyenMai(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.createNativeQuery("DELETE FROM chi_tiet_khuyen_mai WHERE id_khuyen_mai = :id").setParameter("id", id).executeUpdate();
	}
}
