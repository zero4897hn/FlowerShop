package com.example.zero.dao;

import java.math.BigInteger;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.PhanHoi;

@Repository
public class PhanHoiDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public List<PhanHoi> getDanhSachPhanHoi() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<PhanHoi> danhSachPhanHoi = session.createQuery("from phan_hoi p order by p.thoiGianPhanHoi desc").getResultList();
		return danhSachPhanHoi;
	}
	
	@Transactional
	public int getSoPhanHoiChuaDoc() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		return ((BigInteger) session.createNativeQuery("SELECT COUNT(*) FROM phan_hoi WHERE phan_hoi.da_xem = 0").getSingleResult()).intValue();
	}
	
	@Transactional
	public void danhDauDaDocTatCaPhanHoi() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.createNativeQuery("UPDATE phan_hoi SET phan_hoi.da_xem = 1").executeUpdate();
	}

	@Transactional
	public boolean luuPhanHoi(PhanHoi phanHoi) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(phanHoi);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
