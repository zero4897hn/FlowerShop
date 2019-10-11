package com.example.zero.dao;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.QuaTrinhVanChuyen;

@Repository
public class QuaTrinhVanChuyenDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public void save(QuaTrinhVanChuyen tinhTrangHoaDon) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(tinhTrangHoaDon);
	}
	
	@Transactional
	public QuaTrinhVanChuyen getById(int id) {
		Session session = sessionFactory.getCurrentSession();
		QuaTrinhVanChuyen quaTrinhVanChuyen = session.get(QuaTrinhVanChuyen.class, id);
		return quaTrinhVanChuyen;
	}
}
