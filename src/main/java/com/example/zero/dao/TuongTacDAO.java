package com.example.zero.dao;

import java.math.BigInteger;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.NhanVien;
import com.example.zero.model.TuongTac;

@Repository
public class TuongTacDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public List<TuongTac> getDanhSachTuongTac() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<TuongTac> danhSachTuongTac = session.createQuery("from tuong_tac order by thoi_gian_tuong_tac desc")
				.getResultList();
		return danhSachTuongTac;
	}
	
	@Transactional
	public void themTuongTac(TuongTac tuongTac) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.save(tuongTac);
	}

	@Transactional
	public int getSoHoaDonDaChot(NhanVien nhanVien) {
		Session session = sessionFactory.getCurrentSession();
		BigInteger bigInteger = (BigInteger) session.createNativeQuery("SELECT COUNT(*) FROM tuong_tac WHERE tuong_tac.id_nhan_vien = :idnhanvien AND tuong_tac.noi_dung LIKE 'đã xác nhận đã giao cho khách hóa đơn %' ")
				.setParameter("idnhanvien", nhanVien.getId()).getSingleResult();
		return bigInteger.intValue();
	}
}
