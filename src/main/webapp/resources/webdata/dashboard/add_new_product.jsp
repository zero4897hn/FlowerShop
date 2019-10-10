<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="col-sm-8 push-sm-2">
	<form name="addProductForm">
		<fieldset class="form-group">
			<label for="txtTenSanPham">Tên sản phẩm:</label>
			<input type="text" class="form-control" id="txtTenSanPham" name="txtTenSanPham" ng-model="sanPham.tenSanPham" placeholder="Nhập tên sản phẩm" ng-required="true" ng-maxlength="50">
			<span ng-show="addProductForm.txtTenSanPham.$dirty && addProductForm.txtTenSanPham.$error.required">Đây là ô bắt buộc phải điền</span>
		</fieldset>
		<fieldset class="form-group">
			<label for="txtMoTaSanPham">Mô tả sản phẩm:</label>
			<div text-angular ng-model="sanPham.moTa"></div>
		</fieldset>
		<fieldset class="form-group">
			<label for="cboDanhMuc">Danh mục:</label>
			<select class="form-control" id="cboDanhMuc" ng-model="sanPham.danhMuc" ng-required="true">
				<option ng-repeat="danhMuc in listDanhMuc" value="{{danhMuc.id}}">{{danhMuc.tenDanhMuc}}</option>
			</select>
		</fieldset>
		<fieldset class="form-group">
			<label for="fileAnhSanPham">Ảnh sản phẩm:</label>
			<input type="file" class="form-control-file" id="fileAnhSanPham" file-model="sanPham.anhSanPham" accept=".gif,.jpg,.jpeg,.png">
		</fieldset>
		<div class="card">
			<div class="card-header">
				Các kiểu sản phẩm
				<div class="card-controls">
					<a href="javascript:;" ng-click="themKieuSanPham()"><i class="material-icons" aria-hidden="true">add</i></a>
				</div>
			</div>
			<div class="card-block">
				<div class="card" ng-repeat="x in sanPham.kieuSanPham">
					<div class="card-header">
						Kiểu sản phẩm {{$index + 1}}
						<div class="card-controls">
							<a href="javascript:;" ng-click="hienThiKieuDanhMuc(x)"><i class="material-icons" aria-hidden="true">keyboard_arrow_down</i></a>
							<a href="javascript:;" ng-click="xoaKieuSanPham(x)"><i class="material-icons" aria-hidden="true">clear</i></a>
						</div>
					</div>
					<div class="card-block" ng-show="x.hienThi">
						<fieldset class="form-group">
							<label>Tên kiểu sản phẩm:</label>
							<input type="text" class="form-control" ng-model="x.tenKieu" placeholder="Nhập kiểu sản phẩm"  ng-maxlength="50">
						</fieldset>
						<fieldset class="form-group">
							<label>Giá bán (đơn vị: VND):</label>
							<input type="number" class="form-control" ng-model="x.giaBan" min="0" placeholder="Nhập giá bán" ng-required="true">
						</fieldset>
						<fieldset class="form-group">
							<label>Số lượng:</label>
							<input type="number" class="form-control" ng-model="x.soLuong" min="0" placeholder="Nhập số lượng" ng-required="true">
						</fieldset>
					</div>
				</div>
			</div>
		</div>
		<button ng-disabled="!addProductForm.$valid" class="btn btn-primary" ng-click="themSanPham(sanPham)">Thêm sản phẩm</button>
	</form>
</div>