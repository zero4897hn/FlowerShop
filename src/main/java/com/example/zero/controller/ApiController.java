package com.example.zero.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.zero.dao.ChucVuDAO;
import com.example.zero.dao.DangNhapDAO;
import com.example.zero.dao.DanhGiaDAO;
import com.example.zero.dao.DanhMucDAO;
import com.example.zero.dao.HoaDonDAO;
import com.example.zero.dao.KhuyenMaiDAO;
import com.example.zero.dao.KieuSanPhamDAO;
import com.example.zero.dao.NhanVienDAO;
import com.example.zero.dao.PhanHoiDAO;
import com.example.zero.dao.SanPhamDAO;
import com.example.zero.dao.TraLoiDanhGiaDAO;
import com.example.zero.dao.TrangChuDAO;
import com.example.zero.dao.TuongTacDAO;
import com.example.zero.entity.MSWordWriter;
import com.example.zero.model.ChucVu;
import com.example.zero.model.DangNhap;
import com.example.zero.model.DanhGia;
import com.example.zero.model.DanhMuc;
import com.example.zero.model.DonHang;
import com.example.zero.model.HoaDon;
import com.example.zero.model.KhuyenMai;
import com.example.zero.model.KieuSanPham;
import com.example.zero.model.NhanVien;
import com.example.zero.model.PhanHoi;
import com.example.zero.model.SanPham;
import com.example.zero.model.TraLoiDanhGia;
import com.example.zero.model.TrangChu;
import com.example.zero.model.TuongTac;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/api")
public class ApiController {
	@Autowired
	DangNhapDAO dangNhapDAO;
	
	@Autowired
	SanPhamDAO sanPhamDAO;
	
	@Autowired
	DanhGiaDAO danhGiaDAO;
	
	@Autowired
	KieuSanPhamDAO kieuSanPhamDAO;
	
	@Autowired
	NhanVienDAO nhanVienDAO;
	
	@Autowired
	HoaDonDAO hoaDonDAO;
	
	@Autowired
	ChucVuDAO chucVuDAO;
	
	@Autowired
	DanhMucDAO danhMucDAO;
	
	@Autowired
	KhuyenMaiDAO khuyenMaiDAO;
	
	@Autowired
	TrangChuDAO trangChuDAO;
	
	@Autowired
	PhanHoiDAO phanHoiDAO;
	
	@Autowired
	TraLoiDanhGiaDAO traLoiDanhGiaDAO;
	
	@Autowired
	TuongTacDAO tuongTacDAO;
	
	@Autowired
	ServletContext servletContext;
	
	@PostMapping(path = "dang_nhap_tai_khoan", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String dangNhapTaiKhoan(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("tenDangNhap") && jsonNode.has("matKhau")) {
				DangNhap dangNhap = dangNhapDAO.getDangNhap(jsonNode.get("tenDangNhap").asText(), jsonNode.get("matKhau").asText());
				if (dangNhap != null) {
					return "{\"notice\": \"success\", \"idNhanVien\": " + dangNhap.getNhanVien().getId() + "}";
				}
				else {
					return "{\"notice\": \"Sai tên đăng nhập hoặc mật khẩu.\"}";
				}
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "dang_nhap_quan_tri", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String dangNhapQuanTri(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("tenDangNhap") && jsonNode.has("matKhau")) {
				DangNhap dangNhap = dangNhapDAO.getDangNhap(jsonNode.get("tenDangNhap").asText(), jsonNode.get("matKhau").asText());
				if (dangNhap != null) {
					NhanVien nhanVien = dangNhap.getNhanVien();
					if (nhanVien.getChucVu().getId() > 1) {
						return "{\"notice\": \"success\", \"idNhanVien\": " + dangNhap.getNhanVien().getId() + "}";
					}
					return "{\"notice\": \"Bạn không thể đăng nhập trang quản trị với tư cách là khách hàng.\"}";
				}
				else {
					return "{\"notice\": \"Sai tên đăng nhập hoặc mật khẩu.\"}";
				}
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "/get_chuc_vu", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getChucVu() {
		try {
			List<ChucVu> danhSachChucVu = chucVuDAO.getChucVu();
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(danhSachChucVu);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "them_danh_gia", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String themDanhGia(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			DanhGia danhGia = new DanhGia();
			if (jsonNode.has("idNhanVien")) {
				NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
				danhGia.setNhanVien(nhanVien);
			}
			if (jsonNode.has("idSanPham")) {
				SanPham sanPham = sanPhamDAO.getSanPham(jsonNode.get("idSanPham").asInt());
				danhGia.setSanPham(sanPham);
			}
			if (jsonNode.has("tieuDe")) {
				danhGia.setTieuDe(jsonNode.get("tieuDe").asText());
			}
			if (jsonNode.has("noiDung")) {
				danhGia.setNoiDung(jsonNode.get("noiDung").asText());
			}
			if (jsonNode.has("soSao")) {
				danhGia.setSoSao(jsonNode.get("soSao").asInt());
			}
			if (danhGiaDAO.addDanhGia(danhGia)) return "{\"notice\": \"success\", \"danhGia\": " + objectMapper.writeValueAsString(danhGiaDAO.getDanhGia(danhGia.getId())) + "}";
			else return "{\"notice\": \"Đánh giá thất bại\"}";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "get_danh_sach_gio_hang", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachGioHang(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			List<DonHang> danhSachDonHang = new ArrayList<DonHang>();
			for (JsonNode x : jsonNode) if (x.has("idSanPham") && x.has("soLuong")) {
				KieuSanPham kieuSanPham = kieuSanPhamDAO.getKieuSanPham(x.get("idSanPham").asInt());
				DonHang donHang = new DonHang();
				donHang.setKieuSanPham(kieuSanPham);
				donHang.setSoLuong(x.get("soLuong").asInt());
				danhSachDonHang.add(donHang);
			}
			
			return objectMapper.writeValueAsString(danhSachDonHang);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "dat_hang", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String datHang(@RequestBody(required = false) String dataOfJson, @CookieValue(value = "nhanVienCookie", required = false) Integer idNhanVienCookie) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			if (jsonNode.has("gioHang") && jsonNode.has("dungTaiKhoanHienTai")) {
				HoaDon hoaDon = new HoaDon();
				
				if (jsonNode.get("dungTaiKhoanHienTai").asBoolean() && jsonNode.has("idNhanVien")) {
					NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
					hoaDon.setNhanVien(nhanVien);
					hoaDon.setHoTenNguoiNhan(nhanVien.getTenNhanVien());
					hoaDon.setSoDienThoai(nhanVien.getSoDienThoai());
					hoaDon.setDiaChiGiaoHang(nhanVien.getDiaChi());
					if (jsonNode.has("thongTin")) {
						JsonNode jsonNodeThongTin = jsonNode.get("thongTin");
						if (jsonNodeThongTin.has("ghiChu")) {
							hoaDon.setGhiChu(jsonNodeThongTin.get("ghiChu").asText());
						}
					}
				} else {
					if (jsonNode.has("thongTin")) {
						JsonNode jsonNodeThongTin = jsonNode.get("thongTin");
						if (jsonNodeThongTin.has("hoVaTen")) {
							hoaDon.setHoTenNguoiNhan(jsonNodeThongTin.get("hoVaTen").asText());
						}
						if (jsonNodeThongTin.has("soDienThoai")) {
							hoaDon.setSoDienThoai(jsonNodeThongTin.get("soDienThoai").asText());
						}
						if (jsonNodeThongTin.has("diaChi")) {
							hoaDon.setDiaChiGiaoHang(jsonNodeThongTin.get("diaChi").asText());
						}
						if (jsonNodeThongTin.has("ghiChu")) {
							hoaDon.setGhiChu(jsonNodeThongTin.get("ghiChu").asText());
						}
					}
				}
				
				JsonNode jsonNodeGioHang = jsonNode.get("gioHang");
				for (JsonNode x : jsonNodeGioHang) if (x.has("idSanPham") && x.has("soLuong")) {
					KieuSanPham kieuSanPham = kieuSanPhamDAO.getKieuSanPham(x.get("idSanPham").asInt());
					int soLuong = x.get("soLuong").asInt();
					DonHang donHang = new DonHang();
					donHang.setKieuSanPham(kieuSanPham);
					donHang.setSoLuong(soLuong);
					donHang.setThanhTien(soLuong * kieuSanPham.getGiaTien());
					hoaDon.addDonHang(donHang);
					kieuSanPham.setSoLuong(kieuSanPham.getSoLuong() - soLuong);
					kieuSanPham.setLuongMua(kieuSanPham.getLuongMua() + 1);
					kieuSanPhamDAO.capNhatKieuSanPham(kieuSanPham);
				}
				
				if (hoaDonDAO.luuHoaDon(hoaDon)) return "{\"notice\": \"success\", \"id_hoa_don\": \"" + hoaDonDAO.getHoaDon(hoaDon.getId()).getMaHoaDon() + "\"}";
				else return "{\"notice\": \"Đặt hàng thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "/cap_nhat_email", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatEmail(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			if (jsonNode.has("idNhanVien")) {
				NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
				if (jsonNode.has("emailHienTai")) {
					String emailHienTai = jsonNode.get("emailHienTai").asText();
					if (!nhanVien.getEmail().equals(emailHienTai)) {
						return "{\"notice\": \"Email hiện tại bạn nhập không đúng.\"}";
					}
				}
				if (jsonNode.has("emailMoi")) {
					String emailMoi = jsonNode.get("emailMoi").asText();
					nhanVien.setEmail(emailMoi);
					if (nhanVienDAO.capNhatNhanVien(nhanVien)) return "{\"notice\": \"Cập nhật thành công.\"}";
					else return "{\"notice\": \"Cập nhật thất bại.\"}";
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "/cap_nhat_cmnd", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatCMND(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idNhanVien")) {
				NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
				if (jsonNode.has("chungMinhNhanDanHienTai")) {
					String chungMinhNhanDanHienTai = jsonNode.get("chungMinhNhanDanHienTai").asText();
					if (!nhanVien.getChungMinhNhanDan().equals(chungMinhNhanDanHienTai)) {
						return "{\"notice\": \"Chứng minh nhân dân hiện tại bạn nhập không đúng.\"}";
					}
				}
				if (jsonNode.has("chungMinhNhanDanMoi")) {
					String chungMinhNhanDanMoi = jsonNode.get("chungMinhNhanDanMoi").asText();
					nhanVien.setChungMinhNhanDan(chungMinhNhanDanMoi);
					if (nhanVienDAO.capNhatNhanVien(nhanVien)) return "{\"notice\": \"Cập nhật thành công.\"}";
					else return "{\"notice\": \"Cập nhật thất bại.\"}";
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@GetMapping(path = "/cap_nhat_avatar_nhan_vien")
	@ResponseBody
	public String capNhatAvatarNhanVien(@CookieValue(value = "nhanVienCookie", required = false) Integer idNhanVienCookie, @RequestParam String avatarName) {
		try {
			NhanVien nhanVien = nhanVienDAO.getNhanVien(idNhanVienCookie.intValue());
			nhanVien.setAvatar(avatarName);
			if (nhanVienDAO.capNhatNhanVien(nhanVien)) {
				return "success";
			}
			else {
				return "Cập nhật thất bại.";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "Có lỗi trong quá trình xử lý, vui lòng thử lại sau.";
	}
	
	@PostMapping(path = "/upload_file", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String uploadFile(@RequestParam(required = false) MultipartFile file, @RequestParam(required = false) String path) {
		try {
			if (file != null && path != null) {
				String destinationPath = servletContext.getRealPath(path);
				file.transferTo(new File(destinationPath + file.getOriginalFilename()));
			}
			return "{\"notice\": \"success\"}";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Tải file lên thất bại\"}";
	}
	
	@PostMapping(path = "them_nhan_vien", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String themNhanVien(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			NhanVien nhanVien = new NhanVien();
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			DangNhap dangNhap = new DangNhap();
			dangNhap.setNhanVien(nhanVien);
			if (jsonNode.has("tenDangNhap")) {
				String tenDangNhap = jsonNode.get("tenDangNhap").asText();
				if (!dangNhapDAO.checkExistTenDangNhap(tenDangNhap)) {
					return "{\"notice\": \"Tên đăng nhập đã tồn tại.\"}";
				}
				dangNhap.setTenDangNhap(tenDangNhap);
			}
			if (jsonNode.has("tenNhanVien")) {
				nhanVien.setTenNhanVien(jsonNode.get("tenNhanVien").asText());
			}
			if (jsonNode.has("gioiTinh")) {
				nhanVien.setGioiTinh(jsonNode.get("gioiTinh").asBoolean());
			}
			if (jsonNode.has("ngaySinh")) {
				String ngaySinhText = jsonNode.get("ngaySinh").asText();
				nhanVien.setNgaySinh(Date.valueOf(ngaySinhText.substring(0, ngaySinhText.indexOf("T")).trim()));
			}
			if (jsonNode.has("diaChi")) {
				nhanVien.setDiaChi(jsonNode.get("diaChi").asText());
			}
			if (jsonNode.has("chungMinhNhanDan")) {
				nhanVien.setChungMinhNhanDan(jsonNode.get("chungMinhNhanDan").asText());
			}
			if (jsonNode.has("soDienThoai")) {
				nhanVien.setSoDienThoai(jsonNode.get("soDienThoai").asText());
			}
			if (jsonNode.has("email")) {
				nhanVien.setEmail(jsonNode.get("email").asText());
			}
			if (jsonNode.has("avatar")) {
				nhanVien.setAvatar(jsonNode.get("avatar").asText());
			}
			if (jsonNode.has("matKhau")) {
				dangNhap.setMatKhau(jsonNode.get("matKhau").asText());
			}
			int idChucVu = 1;
			if (jsonNode.has("maChucVu")) {
				idChucVu = jsonNode.get("maChucVu").asInt();
			}
			if (dangNhapDAO.addNhanVien(dangNhap, idChucVu)) {
				List<Cookie> cookies = Arrays.asList(request.getCookies());
				Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
				if (cookieOption.isPresent()) {
					Cookie cookie = cookieOption.get();
					NhanVien nhanVienHienTai = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVienHienTai);
					tuongTac.setIdTuongTac(dangNhap.getNhanVien().getId());
					tuongTac.setTenTuongTac(dangNhap.getNhanVien().getTenNhanVien());
					tuongTac.setTruongTuongTac("nhan_vien");
					tuongTac.setNoiDung("đã thêm người dùng");
					tuongTacDAO.themTuongTac(tuongTac);
				}
				return "{\"notice\": \"success\", \"idNhanVienMoi\": " + nhanVien.getId() + "}";
			}
			else {
				return "{\"notice\": \"Thêm nhân viên thất bại.\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "/get_danh_sach_tai_khoan", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachTaiKhoan() {
		try {
			List<DangNhap> danhSachTaiKhoan = dangNhapDAO.getAllTaiKhoan();
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(danhSachTaiKhoan);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "update_nhan_vien", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatNhanVien(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			boolean daThemTuongTac = false;
			
			NhanVien nhanVienHienTai = null;
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVienHienTai = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			if (jsonNode.has("idNhanVien")) {
				NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
				if (jsonNode.has("idChucVu")) {
					int idChucVu = jsonNode.get("idChucVu").asInt();
					if (nhanVien.getChucVu().getId() != idChucVu) {
						if (idChucVu < 3 && nhanVien.getChucVu().getId() == 3 && nhanVienDAO.getSoNhanVienQuanTri() < 2) {
							return "{\"notice\": \"Hệ thống không thể không có người quản trị.\"}";
						}
						ChucVu chucVu = chucVuDAO.getChucVu(idChucVu);
						nhanVien.setChucVu(chucVu);
						if (nhanVienHienTai != null) {
							TuongTac tuongTac = new TuongTac();
							tuongTac.setNhanVien(nhanVienHienTai);
							tuongTac.setTruongTuongTac("nhan_vien");
							tuongTac.setNoiDung("đã đổi chức vụ người dùng");
							tuongTac.setIdTuongTac(nhanVien.getId());
							tuongTac.setTenTuongTac(nhanVien.getTenNhanVien());
							tuongTacDAO.themTuongTac(tuongTac);
							daThemTuongTac = true;
						}
					}
				}
				if (jsonNode.has("tenNhanVien")) {
					nhanVien.setTenNhanVien(jsonNode.get("tenNhanVien").asText());
				}
				if (jsonNode.has("gioiTinh")) {
					nhanVien.setGioiTinh(jsonNode.get("gioiTinh").asText().equals("Nam"));
				}
				if (jsonNode.has("ngaySinh")) {
					String ngaySinh = jsonNode.get("ngaySinh").asText();
					nhanVien.setNgaySinh(Date.valueOf(ngaySinh.substring(0, ngaySinh.indexOf("T"))));
				}
				if (jsonNode.has("chungMinhNhanDan")) {
					nhanVien.setChungMinhNhanDan(jsonNode.get("chungMinhNhanDan").asText());
				}
				if (jsonNode.has("soDienThoai")) {
					nhanVien.setSoDienThoai(jsonNode.get("soDienThoai").asText());
				}
				if (jsonNode.has("diaChi")) {
					nhanVien.setDiaChi(jsonNode.get("diaChi").asText());
				}
				if (jsonNode.has("email")) {
					nhanVien.setEmail(jsonNode.get("email").asText());
				}
				if (nhanVienDAO.capNhatNhanVien(nhanVien)) {
					if (!daThemTuongTac && nhanVienHienTai != null) {
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVienHienTai);
						tuongTac.setTruongTuongTac("nhan_vien");
						tuongTac.setNoiDung("đã cập nhật người dùng");
						tuongTac.setIdTuongTac(nhanVien.getId());
						tuongTac.setTenTuongTac(nhanVien.getTenNhanVien());
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"success\"}";
				} else {
					return "{\"notice\": \"Cập nhật thất bại.\"}";
				}
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "xoa_tai_khoan_nhan_vien", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String xoaTaiKhoanNhanVien(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			if (jsonNode.has("idDangNhap")) {
				int idDangNhap = jsonNode.get("idDangNhap").asInt();
				DangNhap dangNhap = dangNhapDAO.getDangNhap(idDangNhap);
				NhanVien nhanVien = dangNhap.getNhanVien();
				if (nhanVien.getChucVu().getTenChucVu().equals("Quản trị")) {
					if (nhanVienDAO.getSoNhanVienQuanTri() <= 1) {
						return "{\"notice\": \"Không thể xóa tài khoản quản trị khi chỉ còn 1 tài khoản quản trị.\"}";
					}
				}
				if (dangNhapDAO.xoaTaiKhoan(dangNhap)) {
					List<Cookie> cookies = Arrays.asList(request.getCookies());
					Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
					if (cookieOption.isPresent()) {
						Cookie cookie = cookieOption.get();
						NhanVien nhanVienHienTai = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVienHienTai);
						tuongTac.setTruongTuongTac("nhan_vien");
						tuongTac.setNoiDung("đã xóa người dùng");
						tuongTac.setIdTuongTac(dangNhap.getNhanVien().getId());
						tuongTac.setTenTuongTac(dangNhap.getNhanVien().getTenNhanVien());
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"success\"}";
				} else {
					return "{\"notice\": \"Xóa thất bại.\"}";
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "doi_mat_khau_tai_khoan", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doiMatKhauTaiKhoan(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idNhanVien")) {
				DangNhap dangNhap = dangNhapDAO.getDangNhapByNhanVien(jsonNode.get("idNhanVien").asInt());
				if (jsonNode.has("currentAccountPassword") && jsonNode.has("newPassword")) {
					String currentAccountPassword = jsonNode.get("currentAccountPassword").asText();
					if (currentAccountPassword.equals(dangNhap.getMatKhau())) {
						dangNhap.setMatKhau(jsonNode.get("newPassword").asText());
						if (dangNhapDAO.updateDangNhap(dangNhap)) {
							return "{\"notice\": \"Đổi mật khẩu thành công.\"}";
						}
						else {
							return "{\"notice\": \"Đổi mật khẩu thất bại.\"}";
						}
						
					} else {
						return "{\"notice\": \"Mật khẩu tài khoản hiện tại không chính xác, vui lòng nhập lại.\"}";
					}
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "get_tat_ca_danh_muc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getTatCaDanhMucSanPham() {
		try {
			List<DanhMuc> danhSachDanhMuc = danhMucDAO.getDanhSachDanhMucSanPham();
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(danhSachDanhMuc);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "cap_nhat_danh_muc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatDanhMuc(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("id") && jsonNode.has("tenDanhMuc")) {
				DanhMuc danhMuc = danhMucDAO.getDanhMuc(jsonNode.get("id").asInt());
				String danhMucCu = danhMuc.getTenDanhMuc();
				danhMuc.setTenDanhMuc(jsonNode.get("tenDanhMuc").asText());
				if (danhMucDAO.updateDanhMuc(danhMuc)) {
					List<Cookie> cookies = Arrays.asList(request.getCookies());
					Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
					if (cookieOption.isPresent()) {
						Cookie cookie = cookieOption.get();
						NhanVien nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVien);
						tuongTac.setNoiDung("đã đổi tên danh mục sản phẩm " + danhMucCu + " thành " + danhMuc.getTenDanhMuc());
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"Cập nhật thành công.\"}";
				}
			}
			return "{\"notice\": \"Cập nhật thất bại.\"}";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "xoa_danh_muc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String xoaDanhMuc(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("id")) {
				int idDanhMuc = jsonNode.get("id").asInt();
				DanhMuc danhMuc = danhMucDAO.getDanhMuc(idDanhMuc);
				if (sanPhamDAO.getSizeOfSanPhamTheoDanhMuc(idDanhMuc) > 0) {
					return "{\"notice\": \"Danh mục này vẫn còn sản phẩm. Hãy làm trống danh mục này trước.\"}";
				}
				if (danhMucDAO.deleteDanhMuc(idDanhMuc)) {
					List<Cookie> cookies = Arrays.asList(request.getCookies());
					Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
					if (cookieOption.isPresent()) {
						Cookie cookie = cookieOption.get();
						NhanVien nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVien);
						tuongTac.setNoiDung("đã xóa danh mục " + danhMuc.getTenDanhMuc());
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"success\"}";
				}
				else {
					return "{\"notice\": \"Xóa thất bại.\"}";
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "them_danh_muc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String themDanhMuc(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("tenDanhMuc")) {
				DanhMuc danhMuc = new DanhMuc();
				danhMuc.setTenDanhMuc(jsonNode.get("tenDanhMuc").asText());
				if (danhMucDAO.addDanhMuc(danhMuc)) {
					List<Cookie> cookies = Arrays.asList(request.getCookies());
					Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
					if (cookieOption.isPresent()) {
						Cookie cookie = cookieOption.get();
						NhanVien nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVien);
						tuongTac.setNoiDung("đã thêm danh mục " + danhMuc.getTenDanhMuc());
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"success\", \"new_category\": " + objectMapper.writeValueAsString(danhMuc) + "}";
				}
				else {
					return "{\"notice\": \"Thêm thất bại.\"}";
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "them_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String themSanPham(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			SanPham sanPham = new SanPham();
			if (jsonNode.has("tenSanPham")) {
				sanPham.setTenSanPham(jsonNode.get("tenSanPham").asText());
			}
			if (jsonNode.has("moTa")) {
				sanPham.setMoTa(jsonNode.get("moTa").asText());
			}
			if (jsonNode.has("danhMuc")) {
				DanhMuc danhMuc = danhMucDAO.getDanhMuc(jsonNode.get("danhMuc").asInt());
				sanPham.setDanhMuc(danhMuc);
			}
			if (jsonNode.has("anhSanPham")) {
				sanPham.setHinhAnh(jsonNode.get("anhSanPham").asText());
			}
			if (jsonNode.has("kieuSanPham")) {
				JsonNode kieuSanPhamNode = jsonNode.get("kieuSanPham");
				for (JsonNode x : kieuSanPhamNode) {
					KieuSanPham kieuSanPham = new KieuSanPham();
					if (x.has("tenKieu")) kieuSanPham.setTenKieu(x.get("tenKieu").asText());
					if (x.has("giaBan")) kieuSanPham.setGiaTien(x.get("giaBan").asLong());
					if (x.has("soLuong")) kieuSanPham.setSoLuong(x.get("soLuong").asInt());
					sanPham.addDanhSachKieuSanPham(kieuSanPham);
				}
			}
			if (sanPhamDAO.themSanPham(sanPham)) {
				TuongTac tuongTac = new TuongTac();
				tuongTac.setNhanVien(nhanVien);
				tuongTac.setTruongTuongTac("san_pham");
				tuongTac.setIdTuongTac(sanPham.getId());
				tuongTac.setTenTuongTac(sanPham.getTenSanPham());
				tuongTac.setNoiDung("đã thêm sản phẩm ");
				tuongTacDAO.themTuongTac(tuongTac);
				return "{\"notice\": \"success\", \"idSanPham\": " + sanPham.getId() + "}";
			}
			else {
				return "{\"notice\": \"Thêm sản phẩm thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "get_tat_ca_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getTatCaSanPham() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
 			return objectMapper.writeValueAsString(sanPhamDAO.getDanhSachTatCaSanPham());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "get_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getSanPham(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idSanPham")) {
				int idSanPham = jsonNode.get("idSanPham").asInt();
				SanPham sanPham = sanPhamDAO.getSanPham(idSanPham);
				return objectMapper.writeValueAsString(sanPham);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "sua_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String suaSanPham(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			boolean daThemTuongTac = false;
			
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			if (jsonNode.has("id")) {
				SanPham sanPham = sanPhamDAO.getSanPham(jsonNode.get("id").asInt());
				if (jsonNode.has("tenSanPham")) {
					sanPham.setTenSanPham(jsonNode.get("tenSanPham").asText());
				}
				if (jsonNode.has("hinhAnh")) {
					sanPham.setHinhAnh(jsonNode.get("hinhAnh").asText());
				}
				if (jsonNode.has("moTa")) {
					sanPham.setMoTa(jsonNode.get("moTa").asText());
				}
				if (jsonNode.has("danhMuc")) {
					JsonNode jsonNodeDanhMuc = jsonNode.get("danhMuc");
					DanhMuc danhMuc = danhMucDAO.getDanhMuc(jsonNodeDanhMuc.get("id").asInt());
					sanPham.setDanhMuc(danhMuc);
				}
				if (jsonNode.has("daXoa")) {
					boolean daXoa = jsonNode.get("daXoa").asBoolean();
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					tuongTac.setTruongTuongTac("san_pham");
					tuongTac.setIdTuongTac(sanPham.getId());
					tuongTac.setTenTuongTac(sanPham.getTenSanPham());
					tuongTac.setNoiDung(daXoa? "đã xóa sản phẩm " : "đã khôi phục sản phẩm ");
					sanPham.setDaXoa(daXoa);
					tuongTacDAO.themTuongTac(tuongTac);
					daThemTuongTac = true;
				}
				if (jsonNode.has("danhSachKieuSanPham")) {
					List<KieuSanPham> danhSachKieuSanPham = new ArrayList<KieuSanPham>();
					JsonNode jsonNodeDanhSachKieuSanPhamNode = jsonNode.get("danhSachKieuSanPham");
					for (JsonNode x : jsonNodeDanhSachKieuSanPhamNode) {
						if (x.has("isDeleted")) {
							boolean isDeleted = x.get("isDeleted").asBoolean();
							if (isDeleted && x.has("id")) {
								kieuSanPhamDAO.xoaKieuSanPham(x.get("id").asInt());
								continue;
							}
						}
						KieuSanPham kieuSanPham = null;
						if (x.has("id")) kieuSanPham = kieuSanPhamDAO.getKieuSanPham(x.get("id").asInt());
						else kieuSanPham = new KieuSanPham();
						if (x.has("tenKieu")) kieuSanPham.setTenKieu(x.get("tenKieu").asText());
						if (x.has("giaTien")) kieuSanPham.setGiaTien(x.get("giaTien").asLong());
						if (x.has("soLuong")) kieuSanPham.setSoLuong(x.get("soLuong").asInt());
						kieuSanPham.setSanPham(sanPham);
						danhSachKieuSanPham.add(kieuSanPham);
					}
					sanPham.setDanhSachKieuSanPham(danhSachKieuSanPham);
				}
				if (sanPhamDAO.suaSanPham(sanPham)) {
					if (!daThemTuongTac && nhanVien != null) {
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVien);
						tuongTac.setTruongTuongTac("san_pham");
						tuongTac.setIdTuongTac(sanPham.getId());
						tuongTac.setTenTuongTac(sanPham.getTenSanPham());
						tuongTac.setNoiDung("đã sửa sản phẩm ");
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Sửa sản phẩm thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "xoa_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String xoaSanPham(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			if (jsonNode.has("idSanPham")) {
				int idSanPham = jsonNode.get("idSanPham").asInt();
				SanPham sanPham = sanPhamDAO.getSanPham(idSanPham);
				if (sanPhamDAO.xoaSanPham(idSanPham)) {
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					tuongTac.setTruongTuongTac("san_pham");
					tuongTac.setIdTuongTac(sanPham.getId());
					tuongTac.setTenTuongTac(sanPham.getTenSanPham());
					tuongTac.setNoiDung("đã xóa vĩnh viễn sản phẩm ");
					tuongTacDAO.themTuongTac(tuongTac);
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Xóa sản phẩm thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "cap_nhat_trang_thai_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatTrangThaiSanPham(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			if (jsonNode.has("idSanPham")) {
				SanPham sanPham = sanPhamDAO.getSanPham(jsonNode.get("idSanPham").asInt());
				if (jsonNode.has("banRa")) {
					sanPham.setBanRa(!jsonNode.get("banRa").asBoolean());
					if (sanPhamDAO.suaSanPham(sanPham)) {
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVien);
						tuongTac.setTruongTuongTac("san_pham");
						tuongTac.setIdTuongTac(sanPham.getId());
						tuongTac.setTenTuongTac(sanPham.getTenSanPham());
						tuongTac.setNoiDung(sanPham.isBanRa()? "đã bán ra sản phẩm " : "đã hủy bán sản phẩm ");
						tuongTacDAO.themTuongTac(tuongTac);
						return "{\"notice\": \"success\"}";
					}
					else return "{\"notice\": \"Cập nhật thất bại\"}";
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "get_danh_sach_hoa_don", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachHoaDon() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(hoaDonDAO.getDanhSachHoaDon());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "doi_tinh_trang_hoa_don", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doiTinhTrangHoaDon(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idHoaDon") && jsonNode.has("tinhTrang")) {
				HoaDon hoaDon = hoaDonDAO.getHoaDon(jsonNode.get("idHoaDon").asInt());
				hoaDon.setTinhTrang(jsonNode.get("tinhTrang").asInt());
				if (jsonNode.has("lyDo")) hoaDon.setNguyenNhan(jsonNode.get("lyDo").asText());
				if (hoaDonDAO.capNhatHoaDon(hoaDon)) {
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					if (hoaDon.getTinhTrang() == 1) {
						tuongTac.setNoiDung("đã xác nhận và tiến hành giao hóa đơn " + hoaDon.getMaHoaDon());
					}
					else if (hoaDon.getTinhTrang() == 2) {
						tuongTac.setNoiDung("đã xác nhận đã giao cho khách hóa đơn " + hoaDon.getMaHoaDon());
					}
					else if (hoaDon.getTinhTrang() == -1) {
						tuongTac.setNoiDung("đã hủy hóa đơn " + hoaDon.getMaHoaDon());
					}
					tuongTacDAO.themTuongTac(tuongTac);
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Cập nhật thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "doi_trang_thai_hoa_don", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String doiTrangThaiHoaDon(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idHoaDon") && jsonNode.has("daXem")) {
				HoaDon hoaDon = hoaDonDAO.getHoaDon(jsonNode.get("idHoaDon").asInt());
				hoaDon.setDaXem(jsonNode.get("daXem").asBoolean());
				if (hoaDonDAO.capNhatHoaDon(hoaDon)) return "{\"notice\": \"success\"}";
				else return "{\"notice\": \"Cập nhật thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "thay_avatar_nhan_vien", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String thayAvatarNhanVien(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idNhanVien") && jsonNode.has("avatar")) {
				NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
				nhanVien.setAvatar(jsonNode.get("avatar").asText());
				if (nhanVienDAO.capNhatNhanVien(nhanVien)) return "{\"notice\": \"success\"}";
				else return "{\"notice\": \"Cập nhật thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "so_hoa_don_chua_doc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getSoHoaDonChuaDoc() {
		int soHoaDon = 0;
		try {
			soHoaDon = hoaDonDAO.getSoHoaDonChuaDoc();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"result\": " + soHoaDon + "}";
	}
	
	@PostMapping(path = "get_tat_ca_kieu_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getTatCaKieuSanPham() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(kieuSanPhamDAO.getDanhSachKieuSanPham());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "get_danh_sach_danh_muc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachDanhMuc() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(danhMucDAO.getDanhSachDanhMuc());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "them_khuyen_mai", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String themKhuyenMai(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			KhuyenMai khuyenMai = new KhuyenMai();
			if (jsonNode.has("tenKhuyenMai")) {
				khuyenMai.setTenKhuyenMai(jsonNode.get("tenKhuyenMai").asText());
			}
			if (jsonNode.has("moTa")) {
				khuyenMai.setMoTa(jsonNode.get("moTa").asText());
			}
			if (jsonNode.has("thoiGianBatDau")) {
				khuyenMai.setThoiGianBatDau(Timestamp.valueOf(jsonNode.get("thoiGianBatDau").asText().replace('T', ' ').replace('Z', ' ').trim()));
			}
			if (jsonNode.has("thoiGianKetThuc")) {
				khuyenMai.setThoiGianKetThuc(Timestamp.valueOf(jsonNode.get("thoiGianKetThuc").asText().replace('T', ' ').replace('Z', ' ').trim()));
			}
			if (jsonNode.has("phanTramGiam")) {
				khuyenMai.setPhanTramGiam(jsonNode.get("phanTramGiam").asInt());
			}
			if (jsonNode.has("giaGiamToiDa")) {
				khuyenMai.setGiaGiamToiDa(jsonNode.get("giaGiamToiDa").asLong());
			}
			if (jsonNode.has("anhKhuyenMai")) {
				khuyenMai.setHinhKhuyenMai(jsonNode.get("anhKhuyenMai").asText());
			}
			if (jsonNode.has("kieuSanPham")) {
				JsonNode jsonNodeKieuSanPham = jsonNode.get("kieuSanPham");
				List<KieuSanPham> danhSachKieuSanPham = new ArrayList<KieuSanPham>();
				for (JsonNode x : jsonNodeKieuSanPham) {
					KieuSanPham kieuSanPham = kieuSanPhamDAO.getKieuSanPham(x.asInt());
					danhSachKieuSanPham.add(kieuSanPham);
				}
				khuyenMai.setDanhSachKieuSanPham(danhSachKieuSanPham);
			}
			if (khuyenMaiDAO.themKhuyenMai(khuyenMai)) {
				TuongTac tuongTac = new TuongTac();
				tuongTac.setNhanVien(nhanVien);
				tuongTac.setTruongTuongTac("khuyen_mai");
				tuongTac.setIdTuongTac(khuyenMai.getId());
				tuongTac.setTenTuongTac(khuyenMai.getTenKhuyenMai());
				tuongTac.setNoiDung("đã thêm khuyến mãi ");
				tuongTacDAO.themTuongTac(tuongTac);
				return "{\"notice\": \"success\", \"id\": " + khuyenMai.getId() + "}";
			}
			else return "{\"notice\": \"Thêm thất bại\"}";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "sua_khuyen_mai", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String suaKhuyenMai(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			boolean daThemTuongTac = false;
			
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("id")) {
				KhuyenMai khuyenMai = khuyenMaiDAO.getKhuyenMai(jsonNode.get("id").asInt());
				if (jsonNode.has("tenKhuyenMai")) {
					khuyenMai.setTenKhuyenMai(jsonNode.get("tenKhuyenMai").asText());
				}
				if (jsonNode.has("moTa")) {
					khuyenMai.setMoTa(jsonNode.get("moTa").asText());
				}
				if (jsonNode.has("thoiGianBatDau")) {
					khuyenMai.setThoiGianBatDau(Timestamp.valueOf(jsonNode.get("thoiGianBatDau").asText().replace('T', ' ').replace('Z', ' ').trim()));
				}
				if (jsonNode.has("thoiGianKetThuc")) {
					khuyenMai.setThoiGianKetThuc(Timestamp.valueOf(jsonNode.get("thoiGianKetThuc").asText().replace('T', ' ').replace('Z', ' ').trim()));
				}
				if (jsonNode.has("phanTramGiam")) {
					khuyenMai.setPhanTramGiam(jsonNode.get("phanTramGiam").asInt());
				}
				if (jsonNode.has("giaGiamToiDa")) {
					khuyenMai.setGiaGiamToiDa(jsonNode.get("giaGiamToiDa").asLong());
				}
				if (jsonNode.has("hinhKhuyenMai")) {
					khuyenMai.setHinhKhuyenMai(jsonNode.get("hinhKhuyenMai").asText());
				}
				if (jsonNode.has("daXoa")) {
					khuyenMai.setDaXoa(jsonNode.get("daXoa").asBoolean());
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					tuongTac.setTruongTuongTac("khuyen_mai");
					tuongTac.setIdTuongTac(khuyenMai.getId());
					tuongTac.setTenTuongTac(khuyenMai.getTenKhuyenMai());
					tuongTac.setNoiDung(khuyenMai.isDaXoa()? "đã xóa khuyến mãi " : "đã khôi phục khuyến mãi ");
					tuongTacDAO.themTuongTac(tuongTac);
					daThemTuongTac = true;
				}
				if (jsonNode.has("danhSachKieuSanPham")) {
					khuyenMaiDAO.deleteSanPhamCoKhuyenMai(khuyenMai.getId());
					JsonNode jsonNodeKieuSanPham = jsonNode.get("danhSachKieuSanPham");
					List<KieuSanPham> danhSachKieuSanPham = new ArrayList<KieuSanPham>();
					for (JsonNode x : jsonNodeKieuSanPham) {
						KieuSanPham kieuSanPham = kieuSanPhamDAO.getKieuSanPham(x.asInt());
						danhSachKieuSanPham.add(kieuSanPham);
					}
					khuyenMai.setDanhSachKieuSanPham(danhSachKieuSanPham);
				}
				if (khuyenMaiDAO.updateKhuyenMai(khuyenMai)) {
					if (!daThemTuongTac && nhanVien != null) {
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVien);
						tuongTac.setTruongTuongTac("khuyen_mai");
						tuongTac.setIdTuongTac(khuyenMai.getId());
						tuongTac.setTenTuongTac(khuyenMai.getTenKhuyenMai());
						tuongTac.setNoiDung("đã cập nhật khuyến mãi ");
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Sửa thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "xoa_khuyen_mai", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String xoaKhuyenMai(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idKhuyenMai")) {
				int idKhuyenMai = jsonNode.get("idKhuyenMai").asInt();
				KhuyenMai khuyenMai = khuyenMaiDAO.getKhuyenMai(idKhuyenMai);
				if (khuyenMaiDAO.removeKhuyenMai(idKhuyenMai)) {
					if (nhanVien != null) {
						TuongTac tuongTac = new TuongTac();
						tuongTac.setNhanVien(nhanVien);
						tuongTac.setTruongTuongTac("khuyen_mai");
						tuongTac.setIdTuongTac(khuyenMai.getId());
						tuongTac.setTenTuongTac(khuyenMai.getTenKhuyenMai());
						tuongTac.setNoiDung("đã cập nhật khuyến mãi ");
						tuongTacDAO.themTuongTac(tuongTac);
					}
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Xóa thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "get_danh_sach_khuyen_mai", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachKhuyenMai() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(khuyenMaiDAO.getDanhSachKhuyenMai());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "get_khuyen_mai", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getKhuyenMai(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idKhuyenMai")) {
				return objectMapper.writeValueAsString(khuyenMaiDAO.getKhuyenMai(jsonNode.get("idKhuyenMai").asInt()));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	 
	@PostMapping(path = "upload_multiple_files")
	@ResponseBody
	public String uploadMultipleFiles(MultipartHttpServletRequest request, HttpServletResponse response) {
		try {
			String destinationPath = servletContext.getRealPath(request.getParameter("path").toString());

		    Iterator<String> iterator = request.getFileNames();
		    while (iterator.hasNext()) {
		    	MultipartFile multipartFile = request.getFile(iterator.next());
		    	multipartFile.transferTo(new File(destinationPath + multipartFile.getOriginalFilename()));
		    }
		    
			return "{\"notice\": \"success\"}";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Tải file lên thất bại\"}";
	}
	
	@PostMapping(path = "cap_nhat_trang_chu", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatTrangChu(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			boolean success = true;
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			if (jsonNode.has("banner")) {
				TrangChu trangChu = trangChuDAO.getTrangChu("banner");
				trangChu.setTenTruong("banner");
				trangChu.setNoiDung(jsonNode.get("banner").toString());
				if (!trangChuDAO.updateTrangChu(trangChu)) success = false;
			}
			
			if (jsonNode.has("noiDung")) {
				TrangChu trangChu = trangChuDAO.getTrangChu("noiDung");
				trangChu.setTenTruong("noiDung");
				trangChu.setNoiDung(jsonNode.get("noiDung").toString());
				if (!trangChuDAO.updateTrangChu(trangChu)) success = false;
			}
			
			if (jsonNode.has("sanPham")) {
				TrangChu trangChu = trangChuDAO.getTrangChu("sanPham");
				trangChu.setTenTruong("sanPham");
				trangChu.setNoiDung(jsonNode.get("sanPham").toString());
				if (!trangChuDAO.updateTrangChu(trangChu)) success = false;
			}
			
			if (jsonNode.has("nhungBanDo")) {
				TrangChu trangChu = trangChuDAO.getTrangChu("nhungBanDo");
				trangChu.setTenTruong("nhungBanDo");
				trangChu.setNoiDung(jsonNode.get("nhungBanDo").asText());
				if (!trangChuDAO.updateTrangChu(trangChu)) success = false;
			}
			
			if (jsonNode.has("chanTrang")) {
				TrangChu trangChu = trangChuDAO.getTrangChu("chanTrang");
				trangChu.setTenTruong("chanTrang");
				trangChu.setNoiDung(jsonNode.get("chanTrang").toString());
				if (!trangChuDAO.updateTrangChu(trangChu)) success = false;
			}
			
			if (success) {
				if (nhanVien != null) {
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					tuongTac.setNoiDung("đã cập nhật trang chủ ");
					tuongTacDAO.themTuongTac(tuongTac);
				}
				return "{\"notice\": \"Cập nhật thành công.\"}";
			}
			else return "{\"notice\": \"Cập nhật thất bại\"}";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "get_danh_sach_danh_gia", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachDanhGia() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(danhGiaDAO.getDanhSachDanhGia());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "tra_loi_danh_gia", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String traLoiDanhGia(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			if (jsonNode.has("idNhanVien")) {
				NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
				TraLoiDanhGia traLoiDanhGia = new TraLoiDanhGia();
				traLoiDanhGia.setNhanVien(nhanVien);
				if (jsonNode.has("noiDung") && jsonNode.has("idDanhGia")) {
					traLoiDanhGia.setNoiDung(jsonNode.get("noiDung").asText());
					DanhGia danhGia = danhGiaDAO.getDanhGia(jsonNode.get("idDanhGia").asInt());
					traLoiDanhGia.setDanhGia(danhGia);
					if (traLoiDanhGiaDAO.themTraLoiDanhGia(traLoiDanhGia)) return "{\"notice\": \"success\", \"traLoi\": " + objectMapper.writeValueAsString(traLoiDanhGiaDAO.getTraLoiDanhGia(traLoiDanhGia.getId())) + "}";
					else return "{\"notice\": \"Thêm thất bại\"}";
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "cap_nhat_danh_gia", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatDanhGia(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("id")) {
				DanhGia danhGia = danhGiaDAO.getDanhGia(jsonNode.get("id").asInt());
				if (jsonNode.has("daXem")) {
					danhGia.setDaXem(jsonNode.get("daXem").asBoolean());
				}
				if (jsonNode.has("daXoa")) {
					danhGia.setDaXoa(jsonNode.get("daXoa").asBoolean());
				}
				if (danhGiaDAO.capNhatDanhGia(danhGia)) return "{\"notice\": \"success\"}";
				else return "{\"notice\": \"Cập nhật thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "xoa_danh_gia", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String xoaDanhGia(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			if (jsonNode.has("id")) {
				int idDanhGia = jsonNode.get("id").asInt();
				DanhGia danhGia = danhGiaDAO.getDanhGia(idDanhGia);
				if (danhGiaDAO.xoaDanhGia(idDanhGia)) {
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					tuongTac.setTruongTuongTac("san_pham");
					tuongTac.setIdTuongTac(danhGia.getSanPham().getId());
					tuongTac.setTenTuongTac(danhGia.getSanPham().getTenSanPham());
					tuongTac.setNoiDung("đã xóa vĩnh viễn đánh giá sản phẩm ");
					tuongTacDAO.themTuongTac(tuongTac);
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Xóa thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "cap_nhat_tra_loi_danh_gia", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String capNhatTraLoiDanhGia(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			if (jsonNode.has("idTraLoi")) {
				TraLoiDanhGia traLoiDanhGia = traLoiDanhGiaDAO.getTraLoiDanhGia(jsonNode.get("idTraLoi").asInt());
				if (jsonNode.has("daXoa")) {
					traLoiDanhGia.setDaXoa(jsonNode.get("daXoa").asBoolean());
				}
				if (traLoiDanhGiaDAO.capNhatTraLoiDanhGia(traLoiDanhGia)) {
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					tuongTac.setTruongTuongTac("san_pham");
					tuongTac.setIdTuongTac(traLoiDanhGia.getDanhGia().getSanPham().getId());
					tuongTac.setTenTuongTac(traLoiDanhGia.getDanhGia().getSanPham().getTenSanPham());
					tuongTac.setNoiDung(traLoiDanhGia.isDaXoa()? "đã xóa trả lời đánh giá cho sản phẩm " : "đã khôi phục trả lời đánh giá cho sản phẩm ");
					tuongTacDAO.themTuongTac(tuongTac);
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Cập nhật thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "xoa_tra_loi_danh_gia", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String xoaTraLoiDanhGia(@RequestBody(required = false) String dataOfJson, HttpServletRequest request) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			
			NhanVien nhanVien = null;
			
			List<Cookie> cookies = Arrays.asList(request.getCookies());
			Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
			if (cookieOption.isPresent()) {
				Cookie cookie = cookieOption.get();
				nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			}
			
			if (jsonNode.has("idTraLoi")) {
				int idTraLoi = jsonNode.get("idTraLoi").asInt();
				TraLoiDanhGia traLoiDanhGia = traLoiDanhGiaDAO.getTraLoiDanhGia(idTraLoi);
				if (traLoiDanhGiaDAO.xoaTraLoiDanhGia(idTraLoi)) {
					TuongTac tuongTac = new TuongTac();
					tuongTac.setNhanVien(nhanVien);
					tuongTac.setTruongTuongTac("khuyen_mai");
					tuongTac.setIdTuongTac(traLoiDanhGia.getDanhGia().getSanPham().getId());
					tuongTac.setTenTuongTac(traLoiDanhGia.getDanhGia().getSanPham().getTenSanPham());
					tuongTac.setNoiDung("đã xóa vĩnh viễn trả lời đánh giá cho sản phẩm ");
					tuongTacDAO.themTuongTac(tuongTac);
					return "{\"notice\": \"success\"}";
				}
				else return "{\"notice\": \"Xóa thất bại\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình xử lý, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "so_danh_gia_chua_doc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getSoDanhGiaChuaDoc() {
		int count = 0;
		try {
			count = danhGiaDAO.getSoDanhGiaChuaDoc();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"result\": " + count + "}";
	}
	
	@PostMapping(path = "get_nhan_vien", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getNhanVien(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idNhanVien")) {
				NhanVien nhanVien = nhanVienDAO.getNhanVien(jsonNode.get("idNhanVien").asInt());
				return objectMapper.writeValueAsString(nhanVien);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "get_danh_sach_phan_hoi", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachPhanHoi() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			phanHoiDAO.danhDauDaDocTatCaPhanHoi();
			return objectMapper.writeValueAsString(phanHoiDAO.getDanhSachPhanHoi());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "so_phan_hoi_chua_doc", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getSoPhanHoiChuaDoc() {
		int count = 0;
		try {
			count = phanHoiDAO.getSoPhanHoiChuaDoc();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"result\": " + count + "}";
	}
	
	@PostMapping(path = "get_thong_tin_nhan_vien_hien_tai", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getThongTinTaiKhoanHienTai(@CookieValue(value = "nhanVienCookie", required = false) Integer idNhanVienCookie) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			if (idNhanVienCookie != null) {
				return objectMapper.writeValueAsString(nhanVienDAO.getNhanVien(idNhanVienCookie));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "kiem_tra_mat_khau", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String kiemTraMatKhau(@RequestBody(required = false) String dataOfJson, @CookieValue(value = "nhanVienCookie", required = false) Integer idNhanVienCookie) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("matKhauNhapVao")) {
				DangNhap dangNhap = dangNhapDAO.getDangNhapByNhanVien(idNhanVienCookie);
				String matKhauNhapVao = jsonNode.get("matKhauNhapVao").asText();
				if (dangNhap.getMatKhau().equals(matKhauNhapVao)) return "{\"notice\": \"true\"}";
				else return "{\"notice\": \"Mật khẩu nhập vào không chính xác.\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "get_du_lieu_trang_chu", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDuLieuTrangChu() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			return objectMapper.writeValueAsString(trangChuDAO.getDuLieuTrangChu());
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "get_danh_sach_san_pham", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getDanhSachSanPham() {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			TrangChu trangChu = trangChuDAO.getTrangChu("sanPham");
			JsonNode jsonNode = objectMapper.readTree(trangChu.getNoiDung());
			if (jsonNode.has("sanPhamHot") && jsonNode.get("sanPhamHot").asBoolean() && jsonNode.has("soLuongSanPham")) {
				List<SanPham> danhSachSanPham = new ArrayList<SanPham>();
				List<Object> danhSachIdSanPhamHot = sanPhamDAO.getDanhSachIdSanPhamHot(jsonNode.get("soLuongSanPham").asInt());
				for (Object object : danhSachIdSanPhamHot) {
					Integer integer = (Integer) object;
					SanPham sanPham = sanPhamDAO.getSanPham(integer.intValue());
					if (sanPham != null) danhSachSanPham.add(sanPham);
				}
				CollectionUtils.filter(danhSachSanPham, new Predicate() {
					
					@Override
					public boolean evaluate(Object object) {
						SanPham sp = (SanPham) object;
						return sp.isBanRa() && !sp.isDaXoa();
					}
				});
				return objectMapper.writeValueAsString(danhSachSanPham);
			}
			if (jsonNode.has("danhSachIdSanPham")) {
				List<SanPham> danhSachSanPham = new ArrayList<SanPham>();
				JsonNode jsonNodeSanPham = jsonNode.get("danhSachIdSanPham");
				for (JsonNode x : jsonNodeSanPham) {
					SanPham sanPham = sanPhamDAO.getSanPham(x.asInt());
					if (sanPham != null) danhSachSanPham.add(sanPham);
				}
				CollectionUtils.filter(danhSachSanPham, new Predicate() {
					
					@Override
					public boolean evaluate(Object object) {
						SanPham sp = (SanPham) object;
						return sp.isBanRa() && !sp.isDaXoa();
					}
				});
				return objectMapper.writeValueAsString(danhSachSanPham);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "get_hoa_don", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getHoaDon(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("idHoaDon")) {
				return objectMapper.writeValueAsString(hoaDonDAO.getHoaDon(jsonNode.get("idHoaDon").asInt()));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@PostMapping(path = "gui_phan_hoi", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String guiPhanHoi(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			PhanHoi phanHoi = new PhanHoi();
			if (jsonNode.has("soDienThoai")) {
				phanHoi.setSoDienThoai(jsonNode.get("soDienThoai").asText());
			}
			if (jsonNode.has("email")) {
				phanHoi.setEmail(jsonNode.get("email").asText());
			}
			if (jsonNode.has("tieuDe")) {
				phanHoi.setTieuDe(jsonNode.get("tieuDe").asText());
			}
			if (jsonNode.has("noiDung")) {
				phanHoi.setNoiDung(jsonNode.get("noiDung").asText());
			}
			if (phanHoiDAO.luuPhanHoi(phanHoi)) return "{\"notice\": \"Gửi phản hồi thành công.\"}";
			else return "{\"notice\": \"Gửi phản hồi thất bại.\"}";
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "kiem_tra_ton_tai_ma_hoa_don", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String kiemTraTonTaiMaHoaDon(@RequestBody(required = false) String dataOfJson) {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode jsonNode = objectMapper.readTree(dataOfJson.toString());
			if (jsonNode.has("maHoaDon")) {
				String maHoaDon = jsonNode.get("maHoaDon").asText();
				if (hoaDonDAO.tonTaiHoaDon(maHoaDon)) {
					HoaDon hoaDon = hoaDonDAO.getHoaDon(maHoaDon);
					return "{\"notice\": \"success\", \"idHoaDon\": " + hoaDon.getId() + "}";
				}
				else return "{\"notice\": \"Mã hóa đơn không tồn tại.\"}";
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "{\"notice\": \"Có lỗi trong quá trình kết nối, vui lòng thử lại sau.\"}";
	}
	
	@PostMapping(path = "thong_ke_tat_ca_san_pham", produces = "text/plain;charset=UTF-8")
    public void thongKeTatCaSanPham(HttpServletRequest request, HttpServletResponse response) {
		try {
			String fileName = servletContext.getRealPath("/resources/files/") + "tat_ca_san_pham.xls";
			@SuppressWarnings("resource")
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("firstSheet");

			HSSFRow rowhead = sheet.createRow(0);
			rowhead.createCell(0).setCellValue("ID");
			rowhead.createCell(1).setCellValue("Tên sản phẩm");
			rowhead.createCell(2).setCellValue("Tên kiểu sản phẩm");
			rowhead.createCell(3).setCellValue("Danh mục");
			rowhead.createCell(4).setCellValue("Giá tiền");
			rowhead.createCell(5).setCellValue("Số lượng");
			rowhead.createCell(6).setCellValue("Ngày nhập");

			List<KieuSanPham> danhSachKieuSanPham = kieuSanPhamDAO.getDanhSachKieuSanPham();
			
			Timestamp currrent = Timestamp.from(Instant.now());			
			int rowNum = 1;
			for (KieuSanPham kieuSanPham : danhSachKieuSanPham) {
				List<KhuyenMai> danhSachKhuyenMai = kieuSanPham.getDanhSachKhuyenMai();

				CollectionUtils.filter(danhSachKhuyenMai, new Predicate() {
					@Override
					public boolean evaluate(Object object) {
						KhuyenMai khuyenMai = (KhuyenMai) object;
						return khuyenMai.getThoiGianBatDau().before(currrent) && khuyenMai.getThoiGianKetThuc().after(currrent);
					}
				});
				
				for (KhuyenMai x : danhSachKhuyenMai) {
					double phanTramGiam = (double) x.getPhanTramGiam() / 100;
					long giaTienSauKhiGiamToiDa = kieuSanPham.getGiaTien() - x.getGiaGiamToiDa();
					kieuSanPham.setGiaTien((long) (kieuSanPham.getGiaTien() * (1 - phanTramGiam)));
					if (kieuSanPham.getGiaTien() < giaTienSauKhiGiamToiDa) kieuSanPham.setGiaTien(giaTienSauKhiGiamToiDa);
				}
				
				HSSFRow row = sheet.createRow(rowNum++);
				row.createCell(0).setCellValue(kieuSanPham.getId());
				row.createCell(1).setCellValue(kieuSanPham.getSanPham().getTenSanPham());
				row.createCell(2).setCellValue(kieuSanPham.getTenKieu());
				row.createCell(3).setCellValue(kieuSanPham.getSanPham().getDanhMuc().getTenDanhMuc());
				row.createCell(4).setCellValue(kieuSanPham.getGiaTien());
				row.createCell(5).setCellValue(kieuSanPham.getSoLuong());
				row.createCell(6).setCellValue(kieuSanPham.getNgayNhap());
			}

			FileOutputStream fileOut = new FileOutputStream(fileName);
			workbook.write(fileOut);
			fileOut.close();
			System.out.println("Your excel file has been generated!");

			//Code to download
			File fileToDownload = new File(fileName);
			InputStream in = new FileInputStream(fileToDownload);

			// Gets MIME type of the file
			String mimeType = new MimetypesFileTypeMap().getContentType(fileName);

			if (mimeType == null) {
				// Set to binary type if MIME mapping not found
				mimeType = "application/octet-stream";
			}
			System.out.println("MIME type: " + mimeType);

			// Modifies response
			response.setContentType(mimeType);
			response.setContentLength((int) fileToDownload.length());

			// Forces download
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", fileToDownload.getName());
			response.setHeader(headerKey, headerValue);

			// obtains response's output stream
			OutputStream outStream = response.getOutputStream();

			byte[] buffer = new byte[4096];
			int bytesRead = -1;

			while ((bytesRead = in.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			in.close();
			outStream.close();

			System.out.println("File downloaded at client successfully");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping(path = "thong_ke_nguoi_dung", produces = "text/plain;charset=UTF-8")
    public void thongKeNguoiDung(HttpServletRequest request, HttpServletResponse response) {
		try {
			String idLoaiNguoiDung = request.getParameter("loai_nguoi_dung");
			List<DangNhap> danhSachDangNhap = dangNhapDAO.getAllTaiKhoan();
			if (!idLoaiNguoiDung.equals("undefined")) {
				int id = Integer.parseInt(idLoaiNguoiDung);
				CollectionUtils.filter(danhSachDangNhap, new Predicate() {
					@Override
					public boolean evaluate(Object object) {
						DangNhap dangNhap = (DangNhap) object;
						return dangNhap.getNhanVien().getChucVu().getId() == id;
					}
				});
			}
			String fileName = servletContext.getRealPath("/resources/files/") + "nguoi_dung.xls";
			@SuppressWarnings("resource")
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("firstSheet");

			HSSFRow rowhead = sheet.createRow(0);
			rowhead.createCell(0).setCellValue("Thứ tự");
			rowhead.createCell(1).setCellValue("Tên nhân viên");
			rowhead.createCell(2).setCellValue("Tên tên đăng nhập");
			rowhead.createCell(3).setCellValue("Chức vụ");
			rowhead.createCell(4).setCellValue("Ngày tạo");
			rowhead.createCell(5).setCellValue("Số đơn đã duyệt");

			int rowNum = 1;
			for (DangNhap dangNhap : danhSachDangNhap) {				
				HSSFRow row = sheet.createRow(rowNum);
				row.createCell(0).setCellValue(rowNum);
				row.createCell(1).setCellValue(dangNhap.getNhanVien().getTenNhanVien());
				row.createCell(2).setCellValue(dangNhap.getTenDangNhap());
				row.createCell(3).setCellValue(dangNhap.getNhanVien().getChucVu().getTenChucVu());
				row.createCell(4).setCellValue(dangNhap.getNhanVien().getNgayThem());
				row.createCell(5).setCellValue(tuongTacDAO.getSoHoaDonDaChot(dangNhap.getNhanVien()));
				rowNum++;
			}

			FileOutputStream fileOut = new FileOutputStream(fileName);
			workbook.write(fileOut);
			fileOut.close();
			System.out.println("Your excel file has been generated!");

			//Code to download
			File fileToDownload = new File(fileName);
			InputStream in = new FileInputStream(fileToDownload);

			// Gets MIME type of the file
			String mimeType = new MimetypesFileTypeMap().getContentType(fileName);

			if (mimeType == null) {
				// Set to binary type if MIME mapping not found
				mimeType = "application/octet-stream";
			}
			System.out.println("MIME type: " + mimeType);

			// Modifies response
			response.setContentType(mimeType);
			response.setContentLength((int) fileToDownload.length());

			// Forces download
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", fileToDownload.getName());
			response.setHeader(headerKey, headerValue);

			// obtains response's output stream
			OutputStream outStream = response.getOutputStream();

			byte[] buffer = new byte[4096];
			int bytesRead = -1;

			while ((bytesRead = in.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			in.close();
			outStream.close();

			System.out.println("File downloaded at client successfully");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping(path = "thong_ke_san_pham", produces = "text/plain;charset=UTF-8")
    public void thongKeSanPham(HttpServletRequest request, HttpServletResponse response) {
		try {
			String idDanhMucString = request.getParameter("id_danh_muc");
			List<KieuSanPham> danhSachKieuSanPham = kieuSanPhamDAO.getDanhSachKieuSanPhamTheoDanhMuc(Integer.parseInt(idDanhMucString));
			
			String fileName = servletContext.getRealPath("/resources/files/") + "san_pham.xls";
			@SuppressWarnings("resource")
			HSSFWorkbook workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("firstSheet");

			HSSFRow rowhead = sheet.createRow(0);
			rowhead.createCell(0).setCellValue("ID");
			rowhead.createCell(1).setCellValue("Tên sản phẩm");
			rowhead.createCell(2).setCellValue("Tên kiểu sản phẩm");
			rowhead.createCell(3).setCellValue("Giá tiền");
			rowhead.createCell(4).setCellValue("Số lượng");
			rowhead.createCell(5).setCellValue("Ngày nhập");

			Timestamp currrent = Timestamp.from(Instant.now());			
			int rowNum = 1;
			for (KieuSanPham kieuSanPham : danhSachKieuSanPham) {
				List<KhuyenMai> danhSachKhuyenMai = kieuSanPham.getDanhSachKhuyenMai();

				CollectionUtils.filter(danhSachKhuyenMai, new Predicate() {
					@Override
					public boolean evaluate(Object object) {
						KhuyenMai khuyenMai = (KhuyenMai) object;
						return khuyenMai.getThoiGianBatDau().before(currrent) && khuyenMai.getThoiGianKetThuc().after(currrent);
					}
				});
				
				for (KhuyenMai x : danhSachKhuyenMai) {
					double phanTramGiam = (double) x.getPhanTramGiam() / 100;
					long giaTienSauKhiGiamToiDa = kieuSanPham.getGiaTien() - x.getGiaGiamToiDa();
					kieuSanPham.setGiaTien((long) (kieuSanPham.getGiaTien() * (1 - phanTramGiam)));
					if (kieuSanPham.getGiaTien() < giaTienSauKhiGiamToiDa) kieuSanPham.setGiaTien(giaTienSauKhiGiamToiDa);
				}
				
				HSSFRow row = sheet.createRow(rowNum++);
				row.createCell(0).setCellValue(kieuSanPham.getId());
				row.createCell(1).setCellValue(kieuSanPham.getSanPham().getTenSanPham());
				row.createCell(2).setCellValue(kieuSanPham.getTenKieu());
				row.createCell(3).setCellValue(kieuSanPham.getGiaTien());
				row.createCell(4).setCellValue(kieuSanPham.getSoLuong());
				row.createCell(5).setCellValue(kieuSanPham.getNgayNhap());
			}

			FileOutputStream fileOut = new FileOutputStream(fileName);
			workbook.write(fileOut);
			fileOut.close();
			System.out.println("Your excel file has been generated!");

			//Code to download
			File fileToDownload = new File(fileName);
			InputStream in = new FileInputStream(fileToDownload);

			// Gets MIME type of the file
			String mimeType = new MimetypesFileTypeMap().getContentType(fileName);

			if (mimeType == null) {
				// Set to binary type if MIME mapping not found
				mimeType = "application/octet-stream";
			}
			System.out.println("MIME type: " + mimeType);

			// Modifies response
			response.setContentType(mimeType);
			response.setContentLength((int) fileToDownload.length());

			// Forces download
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", fileToDownload.getName());
			response.setHeader(headerKey, headerValue);

			// obtains response's output stream
			OutputStream outStream = response.getOutputStream();

			byte[] buffer = new byte[4096];
			int bytesRead = -1;

			while ((bytesRead = in.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			in.close();
			outStream.close();

			System.out.println("File downloaded at client successfully");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping(path = "xuat_hoa_don", produces = "text/plain;charset=UTF-8")
    public void xuatHoaDon(HttpServletRequest request, HttpServletResponse response) {
		try {
			String idHoaDonString = request.getParameter("id_hoa_don");
			HoaDon hoaDon = hoaDonDAO.getHoaDon(Integer.parseInt(idHoaDonString));
			
			String fileName = servletContext.getRealPath("/resources/files/") + "hoa_don.doc";
			
			MSWordWriter writer = new MSWordWriter();
			writer.writeATitle("Hóa đơn " + hoaDon.getMaHoaDon());
			writer.writeAParagraph("Người đặt hàng: " + hoaDon.getHoTenNguoiNhan());
			writer.writeAParagraph("Số điện thoại: " + hoaDon.getSoDienThoai());
			writer.writeAParagraph("Địa chỉ: " + hoaDon.getDiaChiGiaoHang());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			writer.writeAParagraph("Thời gian đặt hàng: " + simpleDateFormat.format(hoaDon.getNgayLap()));
			
			String ghiChu = hoaDon.getGhiChu();
			if (ghiChu != null && ghiChu.trim().length() > 0) {
				writer.writeAParagraph("Ghi chú: " + ghiChu);
			}
			
			writer.writeATitle("Danh sách đơn hàng");
			
			String[] tableTitles = {"Số thứ tự", "Tên sản phẩm", "Đơn giá", "Số lượng", "Thành tiền"};

			List<String[]> tableBodies = new ArrayList<String[]>();
			
			int thuTu = 1;
			long tongTien = 0;
			DecimalFormat decimalFormat = new DecimalFormat("#,###");
			
			for (DonHang donHang : hoaDon.getDanhSachDonHang()) {
				List<KhuyenMai> danhSachKhuyenMai = donHang.getKieuSanPham().getDanhSachKhuyenMai();
				
				CollectionUtils.filter(danhSachKhuyenMai, new Predicate() {
					@Override
					public boolean evaluate(Object object) {
						KhuyenMai khuyenMai = (KhuyenMai) object;
						return !khuyenMai.isDaXoa() && khuyenMai.getThoiGianBatDau().before(hoaDon.getNgayLap()) && khuyenMai.getThoiGianKetThuc().after(hoaDon.getNgayLap());
					}
				});
				
				KieuSanPham kieuSanPham = donHang.getKieuSanPham();
				
				for (KhuyenMai x : danhSachKhuyenMai) {
					double phanTramGiam = (double) x.getPhanTramGiam() / 100;
					long giaTienSauKhiGiamToiDa = kieuSanPham.getGiaTien() - x.getGiaGiamToiDa();
					kieuSanPham.setGiaTien((long) (kieuSanPham.getGiaTien() * (1 - phanTramGiam)));
					if (kieuSanPham.getGiaTien() < giaTienSauKhiGiamToiDa) kieuSanPham.setGiaTien(giaTienSauKhiGiamToiDa);
				}
				
				long thanhTien = kieuSanPham.getGiaTien() * donHang.getSoLuong();
				
				String[] body = {
						"*" + thuTu, 
						kieuSanPham.getSanPham().getTenSanPham(),
						"VND " + decimalFormat.format(kieuSanPham.getGiaTien()),
						"*" + donHang.getSoLuong(),
						"VND " + decimalFormat.format(thanhTien)
				}; 
				
				tongTien += thanhTien;
				
				thuTu++;
				tableBodies.add(body);
			}
			
			writer.createTable(tableTitles, tableBodies);
			writer.writeAParagraph("Tổng tiền: VND " + decimalFormat.format(tongTien), ParagraphAlignment.RIGHT);
			
			XWPFDocument document = writer.getDocument();
			
			FileOutputStream fileOut = new FileOutputStream(fileName);
			document.write(fileOut);
			fileOut.close();
			System.out.println("Your word file has been generated!");
			
			//Code to download
			File fileToDownload = new File(fileName);
			InputStream in = new FileInputStream(fileToDownload);

			// Gets MIME type of the file
			String mimeType = new MimetypesFileTypeMap().getContentType(fileName);

			if (mimeType == null) {
				// Set to binary type if MIME mapping not found
				mimeType = "application/octet-stream";
			}
			System.out.println("MIME type: " + mimeType);

			// Modifies response
			response.setContentType(mimeType);
			response.setContentLength((int) fileToDownload.length());

			// Forces download
			String headerKey = "Content-Disposition";
			String headerValue = String.format("attachment; filename=\"%s\"", fileToDownload.getName());
			response.setHeader(headerKey, headerValue);

			// obtains response's output stream
			OutputStream outStream = response.getOutputStream();

			byte[] buffer = new byte[4096];
			int bytesRead = -1;

			while ((bytesRead = in.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}

			in.close();
			outStream.close();

			System.out.println("File downloaded at client successfully");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@PostMapping(path = "get_lich_su_tuong_tac", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getLichSuTuongTac () {
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			List<TuongTac> danhSachTuongTac = tuongTacDAO.getDanhSachTuongTac();
			return objectMapper.writeValueAsString(danhSachTuongTac);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
}