package com.example.zero.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.TrangChu;

@Repository
public class TrangChuDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public TrangChu getTrangChu(String tenTruong) {
		Session session = sessionFactory.getCurrentSession();
		try {
			TrangChu trangChu = (TrangChu) session.createQuery("from trang_chu t where t.tenTruong = :tentruong").setParameter("tentruong", tenTruong).getSingleResult();
			return trangChu;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return new TrangChu();
	}

	@Transactional
	public boolean updateTrangChu(TrangChu trangChu) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.saveOrUpdate(trangChu);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	public List<TrangChu> getDuLieuTrangChu() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<TrangChu> danhSachTrangChu = session.createQuery("from trang_chu").getResultList();
		return danhSachTrangChu;
	}
}