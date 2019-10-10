<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="col-sm-8 push-sm-2">
	<form>
		<fieldset class="form-group">
			<label for="txtMoTaSanPham">Thông tin trang Web</label>
			<div text-angular ng-model="thongTinTrangWeb"></div>
		</fieldset>
		<button class="btn btn-primary" ng-click="chinhSuaThongTin(thongTinTrangWeb)">Chỉnh sửa</button>
	</form>
</div>