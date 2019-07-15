package com.example.zero.dao;

import java.math.BigInteger;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.HoaDon;

@Repository
public class HoaDonDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public boolean luuHoaDon(HoaDon hoaDon) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(hoaDon);
			hoaDon.getDanhSachDonHang().forEach(x -> {
				session.save(x);
			});
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public List<HoaDon> getDanhSachHoaDon() {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<HoaDon> danhSachHoaDon = session.createQuery("from hoa_don h order by h.ngayLap desc").getResultList();
		return danhSachHoaDon;
	}

	@Transactional
	public HoaDon getHoaDon(int id) {
		Session session = sessionFactory.getCurrentSession();
		HoaDon hoaDon = session.get(HoaDon.class, id);
		return hoaDon;
	}

	@Transactional
	public boolean capNhatHoaDon(HoaDon hoaDon) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(hoaDon);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public int getSoHoaDonChuaDoc() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		return ((BigInteger) session.createNativeQuery("SELECT COUNT(*) FROM hoa_don WHERE hoa_don.da_xem = 0").getSingleResult()).intValue();
	}

	@Transactional
	public HoaDon getHoaDon(String maHoaDon) {
		Session session = sessionFactory.getCurrentSession();
		HoaDon hoaDon = (HoaDon) session.createQuery("from hoa_don where ma_hoa_don = :mahoadon")
				.setParameter("mahoadon", maHoaDon).getSingleResult();
		return hoaDon;
	}

	@Transactional
	public boolean tonTaiHoaDon(String maHoaDon) {
		Session session = sessionFactory.getCurrentSession();
		int result = ((BigInteger) session.createNativeQuery("SELECT COUNT(*) FROM hoa_don WHERE hoa_don.ma_hoa_don = :mahoadon")
				.setParameter("mahoadon", maHoaDon).getSingleResult()).intValue();
		return result > 0;
	}
}
