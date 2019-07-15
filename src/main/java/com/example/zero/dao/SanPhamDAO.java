package com.example.zero.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.SanPham;

@Repository
public class SanPhamDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public List<Object> getDanhSachIdSanPhamHot(int soLuong) {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<Object> dsSanPham = session.createNativeQuery("SELECT san_pham.id FROM san_pham JOIN kieu_san_pham ON san_pham.id = kieu_san_pham.id_san_pham WHERE san_pham.ban_ra = :banra AND san_pham.da_xoa = :daxoa ORDER BY kieu_san_pham.luong_mua DESC")
									.setParameter("banra", true)
									.setParameter("daxoa", false)
									.setFirstResult(0)
									.setMaxResults(soLuong)
									.getResultList();
		return dsSanPham;
	}

	@Transactional
	public SanPham getSanPham(int id) {
		Session session = sessionFactory.getCurrentSession();
		SanPham sanPham = session.get(SanPham.class, id);
		return sanPham;
	}
	
	@Transactional
	public int getSizeOfSanPhamTheoDanhMuc(int idDanhMuc) {
		Session session = sessionFactory.getCurrentSession();
		return ((Long) session.createQuery("select count(id) from san_pham where id_danh_muc = :iddanhmuc")
				.setParameter("iddanhmuc", idDanhMuc)
				.getSingleResult()).intValue();
	}
	
	@Transactional
	public boolean themSanPham(SanPham sanPham) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.save(sanPham);
			sanPham.getDanhSachKieuSanPham().forEach(x -> {
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
	public List<SanPham> getDanhSachTatCaSanPham() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<SanPham> danhSachSanPham = session.createQuery("from san_pham").getResultList();
		return danhSachSanPham;
	}
	
	@Transactional
	public boolean suaSanPham(SanPham sanPham) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(sanPham);
			sanPham.getDanhSachKieuSanPham().forEach(x -> {
				session.saveOrUpdate(x);
			});
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public boolean xoaSanPham(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		int result = session.createNativeQuery("DELETE FROM san_pham WHERE id = :idsp")
						.setParameter("idsp", id).executeUpdate();
		return result > 0? true : false;
	}
}
