package com.example.zero.dao;

import java.util.List;

import javax.persistence.NoResultException;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.zero.model.ChucVu;
import com.example.zero.model.DangNhap;
import com.example.zero.model.NhanVien;

@Repository
public class DangNhapDAO {
	@Autowired
	SessionFactory sessionFactory;
	
	@Transactional
	public DangNhap getDangNhap(String tenDangNhap, String matKhau) {
		DangNhap dangNhap;
		try {
			Session session = sessionFactory.getCurrentSession();
			String sql = "from dang_nhap where ten_dang_nhap = :tdn and mat_khau = :mk";
			dangNhap = (DangNhap) session.createQuery(sql)
					.setParameter("tdn", tenDangNhap)
					.setParameter("mk", matKhau)
					.getSingleResult();
		}
		catch (NoResultException e) {
			dangNhap = null;
		}
		catch (Exception e) {
			throw e;
		}
		return dangNhap;
	}
	
	@Transactional
	public boolean addNhanVien(DangNhap dangNhap, int maChucVu) {
		try {
			Session session = sessionFactory.getCurrentSession();
			ChucVu chucVu = session.get(ChucVu.class, maChucVu);
			NhanVien nhanVien = dangNhap.getNhanVien();
			nhanVien.setChucVu(chucVu);
			session.save(nhanVien);
			session.save(dangNhap);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public boolean checkExistTenDangNhap(String tenDangNhap) {
		try {
			Session session = sessionFactory.getCurrentSession();
			int countDangNhap = session.createQuery("from dang_nhap where ten_dang_nhap = :tdn").setParameter("tdn", tenDangNhap).list().size();
			if (countDangNhap == 0) return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public boolean checkMatKhau(int idNhanVien, String matKhauHienTai) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		DangNhap dangNhap = (DangNhap) session.createQuery("from dang_nhap where id_nhan_vien = :idnhanvien")
							.setParameter("idnhanvien", idNhanVien).getSingleResult();
		if (matKhauHienTai.equals(dangNhap.getMatKhau())) return true;
		return false;
	}

	@Transactional
	public void capNhatMatKhau(int idNhanVien, String matKhauMoi) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		DangNhap dangNhap = (DangNhap) session.createQuery("from dang_nhap where id_nhan_vien = :idnhanvien")
							.setParameter("idnhanvien", idNhanVien).getSingleResult();
		dangNhap.setMatKhau(matKhauMoi);
		session.update(dangNhap);
	}
	
	@Transactional
	public List<DangNhap> getAllTaiKhoan() throws Exception {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<DangNhap> danhSachTaiKhoan = session.createQuery("from dang_nhap").getResultList();
		return danhSachTaiKhoan;
	}
	
	@Transactional
	public boolean xoaTaiKhoan(int idDangNhap) {
		Session session = sessionFactory.getCurrentSession();
		DangNhap dangNhap = session.get(DangNhap.class, idDangNhap);
		session.delete(dangNhap);
		return true;
	}
	
	@Transactional
	public DangNhap getDangNhapByNhanVien(int idNhanVien) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		DangNhap dangNhap = (DangNhap) session.createQuery("from dang_nhap where id_nhan_vien = :idnhanvien")
							.setParameter("idnhanvien", idNhanVien)
							.getSingleResult();
		return dangNhap;
	}
	
	@Transactional
	public boolean updateDangNhap(DangNhap dangNhap) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.update(dangNhap);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Transactional
	public DangNhap getDangNhap(int id) throws Exception {
		Session session = sessionFactory.getCurrentSession();
		DangNhap dangNhap = session.get(DangNhap.class, id);
		return dangNhap;
	}

	@Transactional
	public boolean xoaTaiKhoan(DangNhap dangNhap) {
		try {
			Session session = sessionFactory.getCurrentSession();
			session.delete(dangNhap);
			return true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}