package com.example.zero.dao;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.ChucVu;

@Repository
public class ChucVuDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	@Transactional
	public List<ChucVu> getChucVu() throws Exception {
		List<ChucVu> danhSachChucVu = new ArrayList<ChucVu>();
		Session session = sessionFactory.getCurrentSession();
		danhSachChucVu = session.createQuery("from chuc_vu").getResultList();
		return danhSachChucVu;
	}
	
	@Transactional
	public ChucVu getChucVu(int id) throws Exception {
		ChucVu chucVu = new ChucVu();
		Session session = sessionFactory.getCurrentSession();
		chucVu = session.get(ChucVu.class, id);
		return chucVu;
	}
}
