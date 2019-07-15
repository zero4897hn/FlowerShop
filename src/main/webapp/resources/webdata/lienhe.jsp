<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<div class="container">
	<div class="row mt-3 mb-3">
		<div class="col-12">
			<form name="formLienHe">
				<fieldset class="form-group">
					<label for="txtSoDienThoai">Số điện thoại:</label>
					<input type="text" class="form-control" id="txtSoDienThoai" placeholder="Nhập số điện thoại" ng-required="true" ng-model="phanHoi.soDienThoai">
				</fieldset>
				<fieldset class="form-group">
					<label for="txtEmail">Email:</label>
					<input type="email" class="form-control" id="txtEmail" placeholder="Nhập email" ng-required="true" ng-model="phanHoi.email">
				</fieldset>
				<fieldset class="form-group">
					<label for="txtTieuDe">Tiêu đề:</label>
					<input type="text" class="form-control" id="txtTieuDe" placeholder="Nhập tiêu đề" ng-required="true" ng-model="phanHoi.tieuDe">
				</fieldset>
				<fieldset class="form-group">
					<label for="exampleTextarea">Nội dung:</label>
					<textarea class="form-control" id="exampleTextarea" rows="5" placeholder="Nhập nội dung" ng-required="true" ng-model="phanHoi.noiDung"></textarea>
				</fieldset>
				<button type="button" ng-disabled="!formLienHe.$valid" class="btn btn-primary" ng-click="guiPhanHoi(phanHoi)">Phản hồi</button>
			</form>
		</div>
	</div>
</div>