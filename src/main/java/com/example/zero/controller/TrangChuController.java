package com.example.zero.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class TrangChuController {
	@GetMapping
	public String Default() {
		return "index";
	}
	
	@RequestMapping(value = "/{[path:[^\\.]*}")
	public String redirect() {
		return "forward:/";
	}
	
	@RequestMapping(value = "/{[path:[^\\.]*}/{pathVariable}")
	public String redirect(@PathVariable(name = "pathVariable") String pathVariable) {
		return "forward:/";
	}
}
