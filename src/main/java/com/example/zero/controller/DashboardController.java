package com.example.zero.controller;


import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.zero.dao.NhanVienDAO;
import com.example.zero.model.NhanVien;

@Controller
@RequestMapping("/admin")
public class DashboardController {
	@Autowired
	NhanVienDAO nhanVienDAO;
	
	@GetMapping
	public String Default(HttpServletRequest request) {
		List<Cookie> cookies = Arrays.asList(request.getCookies());
		Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
		if (cookieOption.isPresent()) {
			Cookie cookie = cookieOption.get();
			NhanVien nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			if (nhanVien.getChucVu().getId() < 2) {
				return "redirect:/admin/login";
			}
			return "dashboard/index";
		}
		else {
			return "redirect:/admin/login";
		}
	}
	
	@RequestMapping(value = "/{[path:[^\\.]*}")
	public String redirect(HttpServletRequest request) {
		List<Cookie> cookies = Arrays.asList(request.getCookies());
		Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
		if (cookieOption.isPresent()) {
			Cookie cookie = cookieOption.get();
			NhanVien nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			if (nhanVien.getChucVu().getId() < 2) {
				return "redirect:/admin/login";
			}
			return "forward:/admin";
		}
		else {
			return "redirect:/admin/login";
		}
	}
	
	@RequestMapping(value = "/{[path:[^\\.]*}/{pathVariable}")
	public String redirect(HttpServletRequest request, @PathVariable(name = "pathVariable") String pathVariable) {
		List<Cookie> cookies = Arrays.asList(request.getCookies());
		Optional<Cookie> cookieOption = cookies.stream().filter(x -> x.getName().equals("id_nhan_vien_hien_tai")).findFirst();
		if (cookieOption.isPresent()) {
			Cookie cookie = cookieOption.get();
			NhanVien nhanVien = nhanVienDAO.getNhanVien(Integer.parseInt(cookie.getValue().toString()));
			if (nhanVien.getChucVu().getId() < 2) {
				return "redirect:/admin/login";
			}
			return "forward:/admin";
		}
		else {
			return "redirect:/admin/login";
		}
	}
	
	@GetMapping("/login")
	public String login() {
		return "dashboard/login";
	}
}
