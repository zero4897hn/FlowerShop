package com.example.zero.dao;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.TraLoiDanhGia;

@Repository
public class TraLoiDanhGiaDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public boolean themTraLoiDanhGia(TraLoiDanhGia traLoiDanhGia) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(traLoiDanhGia);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Transactional
	public TraLoiDanhGia getTraLoiDanhGia(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		TraLoiDanhGia traLoiDanhGia = session.get(TraLoiDanhGia.class, id);
		return traLoiDanhGia;
	}

	@Transactional
	public boolean xoaTraLoiDanhGia(int id) {
		Session session = sessionFactory.getCurrentSession();
		int result = session.createQuery("delete from tra_loi_danh_gia where id = :id").setParameter("id", id)
				.executeUpdate();
		return result > 0;
	}

	@Transactional
	public boolean capNhatTraLoiDanhGia(TraLoiDanhGia traLoiDanhGia) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(traLoiDanhGia);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
