<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
	form fieldset span {
		color: red;
	}
</style>
<div class="col-sm-8 push-sm-2">
	<form name="addEventForm">
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Tên khuyến mãi:</label>
			<div class="col-xs-10">
				<input type="text" class="form-control" placeholder="Nhập tên khuyến mãi" name="txtTenKhuyenMai" ng-model="khuyenMai.tenKhuyenMai" ng-maxlength="50" ng-required="true">
			</div>
			<span ng-show="addEventForm.txtTenKhuyenMai.$dirty && addEventForm.txtTenKhuyenMai.$error.required">Đây là ô bắt buộc phải điền</span>
		</fieldset>
		<fieldset class="form-group">
			<label for="txtMoTa">Mô tả:</label>
			<textarea class="form-control" id="txtMoTa" rows="5" ng-model="khuyenMai.moTa"></textarea>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Thời gian bắt đầu:</label>
			<div class="col-xs-10">
				<input class="form-control" type="datetime-local" ng-model="khuyenMai.thoiGianBatDau" ng-required="true">
			</div>
        </fieldset>
        <fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Thời gian kết thúc:</label>
			<div class="col-xs-10">
				<input class="form-control" type="datetime-local" ng-model="khuyenMai.thoiGianKetThuc" ng-required="true">
			</div>
        </fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Phần trăm giảm:</label>
			<div class="col-xs-10">
				<input type="number" class="form-control" placeholder="Nhập phần trăm giảm" min="0" max="100" ng-model="khuyenMai.phanTramGiam" ng-required="true">
			</div>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Giá giảm tối đa:</label>
			<div class="col-xs-10">
				<input type="number" class="form-control" placeholder="Nhập giá giảm tối đa" min="0" ng-model="khuyenMai.giaGiamToiDa" ng-required="true">
			</div>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2" style="padding-left: 0;">Hình khuyến mãi:</label>
			<div class="col-xs-10">
				<input type="file" class="form-control-file" file-model="khuyenMai.fileKhuyenMai" accept=".gif,.jpg,.jpeg,.png">
			</div>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Sản phẩm:</label>
			<div class="col-xs-5">
				<select class="form-control" ng-change="doiDanhMucSanPham(danhMucSanPham)" ng-model="danhMucSanPham">
					<option value="0">Tất cả sản phẩm</option>
					<option ng-repeat="danhMuc in danhSachDanhMuc" value="{{danhMuc[0]}}">{{danhMuc[1]}}</option>
				</select>
				<select class="form-control" size="6" style="overflow: scroll;">
					<option ng-repeat="kieuSanPham in listKieuSanPham" ng-click="chonKieuSanPham(kieuSanPham)">
						{{kieuSanPham.sanPham.tenSanPham}} ({{kieuSanPham.tenKieu}}) - {{kieuSanPham.giaTien | currency : "VND " : 0}}
					</option>
				</select>
				<a class="btn btn-outline-light" style="width: 100%;" ng-click="chonHetKieuSanPham()" href="javascript:;">Chọn hết</a>
			</div>
			<div class="col-xs-5">
				<select class="form-control" size="8" style="overflow: scroll;">
					<option ng-repeat="kieuSanPham in khuyenMai.listKieuSanPham" ng-click="huyChonKieuSanPham(kieuSanPham)">
						{{kieuSanPham.sanPham.tenSanPham}} ({{kieuSanPham.tenKieu}}) - {{kieuSanPham.giaTien | currency : "VND " : 0}}
					</option>
				</select>
				<a class="btn btn-outline-light" style="width: 100%;" ng-click="huyChonHetKieuSanPham()" href="javascript:;">Bỏ chọn hết</a>
			</div>
		</fieldset>
		<button type="submit" class="btn btn-primary" ng-disabled="!addEventForm.$valid" ng-click="themKhuyenMai(khuyenMai)">Thêm khuyến mãi</button>
	</form>
</div>