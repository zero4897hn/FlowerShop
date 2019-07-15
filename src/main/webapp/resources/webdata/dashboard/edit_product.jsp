<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-sm-12" ng-if="sanPham == 'null' || sanPham.daXoa">
    <div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 300px 0px;">Chúng tôi không tìm thấy<br/>sản phẩm cần sửa mà bạn yêu cầu.</h5>
        </div>
    </div>
</div>
<div class="col-sm-8 push-sm-2" ng-if="sanPham != 'null' && !sanPham.daXoa">
	<form name="editProductForm">
		<fieldset class="form-group">
			<label for="txtTenSanPham">Tên sản phẩm:</label>
			<input type="text" class="form-control" id="txtTenSanPham" name="txtTenSanPham" ng-model="sanPham.tenSanPham" placeholder="Nhập tên sản phẩm" ng-required="true" ng-maxlength="50">
			<span ng-show="editProductForm.txtTenSanPham.$dirty && editProductForm.txtTenSanPham.$error.required">Đây là ô bắt buộc phải điền</span>
		</fieldset>
		<fieldset class="form-group">
			<label for="txtMoTaSanPham">Mô tả sản phẩm:</label>
			<textarea class="form-control" id="txtMoTaSanPham" rows="3" ng-model="sanPham.moTa" placeholder="Nhập mô tả sản phẩm"></textarea>
		</fieldset>
		<fieldset class="form-group">
			<label for="cboDanhMuc">Danh mục:</label>
			<select class="form-control" id="cboDanhMuc" ng-model="sanPham.danhMuc.id" ng-required="true" ng-options="+(danhMuc.id) as danhMuc.tenDanhMuc for danhMuc in listDanhMuc">
				
			</select>
		</fieldset>
		<fieldset class="form-group">
			<label for="fileAnhSanPham">Ảnh sản phẩm:</label>
			<input type="file" class="form-control-file" id="fileAnhSanPham" file-model="anhSanPham" accept=".gif,.jpg,.jpeg,.png">
		</fieldset>
		<div class="card">
			<div class="card-header">
				Các kiểu sản phẩm
				<div class="card-controls">
					<a href="javascript:;" ng-click="themKieuSanPham()"><i class="material-icons" aria-hidden="true">add</i></a>
				</div>
			</div>
			<div class="card-block">
				<div class="card" ng-repeat="x in sanPham.danhSachKieuSanPham" ng-init="x.hienThi = true; x.isDeleted = false" ng-show="!x.isDeleted">
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
							<input type="number" class="form-control" ng-model="x.giaTien" min="0" placeholder="Nhập giá bán" ng-required="true">
						</fieldset>
						<fieldset class="form-group">
							<label>Số lượng:</label>
							<input type="number" class="form-control" ng-model="x.soLuong" min="0" placeholder="Nhập số lượng" ng-required="true">
						</fieldset>
					</div>
				</div>
			</div>
		</div>
		<button ng-disabled="!editProductForm.$valid" class="btn btn-primary" ng-click="suaSanPham(sanPham)">Sửa sản phẩm</button>
	</form>
</div>