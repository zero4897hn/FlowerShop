package com.example.zero.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dangnhap")
public class DangNhapController {
	@GetMapping
	public String Default() {
		return "dangnhap";
	}
	
	@RequestMapping(value = "/{[path:[^\\.]*}")
	public String redirect() {
		return "forward:/dangnhap";
	}
}
