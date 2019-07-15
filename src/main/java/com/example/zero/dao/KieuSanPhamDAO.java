package com.example.zero.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.KieuSanPham;

@Repository
public class KieuSanPhamDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public KieuSanPham getKieuSanPham(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		KieuSanPham kieuSanPham = session.get(KieuSanPham.class, id);
		return kieuSanPham;
	}
	
	@Transactional
	public boolean xoaKieuSanPham(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		int result = session.createQuery("delete from kieu_san_pham where id = :id")
						.setParameter("id", id).executeUpdate();
		return result > 0? true : false;
	}
	
	@Transactional
	public List<KieuSanPham> getDanhSachKieuSanPham() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<KieuSanPham> danhSachKieuSanPham = session.createQuery("from kieu_san_pham").getResultList();
		return danhSachKieuSanPham;
	}

	@Transactional
	public void capNhatKieuSanPham(KieuSanPham kieuSanPham) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		session.update(kieuSanPham);
	}

	@Transactional
	public List<KieuSanPham> getDanhSachKieuSanPhamTheoDanhMuc(int idDanhMuc) {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<KieuSanPham> danhSachKieuSanPham = session.createQuery("from kieu_san_pham k where k.sanPham.danhMuc.id = :iddanhmuc")
												.setParameter("iddanhmuc", idDanhMuc).getResultList();
		return danhSachKieuSanPham;
	}
}