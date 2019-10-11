package com.example.zero.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.TinhTrangHoaDon;

@Repository
public class TinhTrangHoaDonDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public List<TinhTrangHoaDon> getAll() {
		Session session = sessionFactory.getCurrentSession();
		List<TinhTrangHoaDon> danhSachTinhTrang = (List<TinhTrangHoaDon>) session.createQuery("from tinh_trang_hoa_don", TinhTrangHoaDon.class).getResultList();
		return danhSachTinhTrang;
	}
	
	@Transactional
	public TinhTrangHoaDon getById(int id) {
		Session session = sessionFactory.getCurrentSession();
		TinhTrangHoaDon tinhTrangHoaDon = session.get(TinhTrangHoaDon.class, id);
		return tinhTrangHoaDon;
	}
}
