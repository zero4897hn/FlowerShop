<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-sm-9">
	<div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listSanPhamCon.length <= 0">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 160px 0px;">Danh sách sản phẩm trống</h5>
        </div>
    </div>
	<div class="row" ng-if="listSanPhamCon.length > 0">
		<div class="col-sm-12">
			<ul class="pagination" style="width: 100%; margin: 10px 0; padding: 0;" ng-hide="soTrang <= 1">
				<li class="page-item">
					<button ng-click="trangTruoc()" ng-disabled="trangHienTai == 1" class="page-link" aria-label="Previous">
						<span aria-hidden="true">«</span>
						<span class="sr-only">Previous</span>
					</button>
				</li>
				<li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemSanPhamTrang(x)"><a class="page-link" href="#">{{x}}</a></li>
				<li class="page-item">
					<button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span>
						<span class="sr-only">Next</span>
					</button>
				</li>
			</ul>
		</div>
	</div>
	<div class="row" ng-if="listSanPhamCon.length > 0">
		<div class="col-sm-12">
			<table class="table table-striped">
		        <thead>
		            <tr>
		                <th style="width: 5%;">#</th>
		                <th style="width: 30%;">Tên sản phẩm</th>
		                <th style="width: 25%;">Giá bán</th>
		                <th style="width: 20%;">Danh mục</th>
		                <th style="width: 20%;">Thao tác</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr ng-repeat="sanPham in listSanPhamCon">
		                <th class="align-middle" scope="row" style="width: 5%;">{{$index + 1 + ((trangHienTai - 1) * soSanPhamMoiTrang)}}</th>
		                <td class="align-middle" style="width: 30%;"><a href="product_info/{{sanPham.id}}">{{sanPham.tenSanPham}}</a></td>
		                <td class="align-middle" style="width: 25%;" ng-switch on="sanPham.danhSachKieuSanPham.length">
							<div ng-switch-when="1">{{getGiaKhuyenMai(sanPham.danhSachKieuSanPham[0]) | currency : "VND " : 0}}</div>
							<div ng-switch-default ng-init="setMinAndMax(sanPham)">
								{{sanPham.giaThapNhat | currency : "VND " : 0}}
								~
								{{sanPham.giaCaoNhat | currency : "VND " : 0}}
							</div>
		                </td>
		                <td class="align-middle" style="width: 20%;">{{sanPham.danhMuc.tenDanhMuc}}</td>
		                <td class="align-middle" style="width: 20%;">
		                	<button style="border: 1px solid gray; background: none; border-radius: 5px;" ng-click="suaSanPham(sanPham)" ng-if="!sanPham.daXoa"><i class="material-icons" aria-hidden="true">edit</i></button>
		                	<button style="border: 1px solid gray; background: none; border-radius: 5px;" ng-click="xoaSanPham(sanPham)" ng-if="!sanPham.daXoa"><i class="material-icons" aria-hidden="true">delete</i></button>
		                	<div ng-if="sanPham.daXoa">Đã xóa</div>
						</td>
		            </tr>
		        </tbody>
		    </table>
		</div>
	</div>
</div>
<div class="col-sm-3">
	<fieldset class="form-group">
		<label>Số sản phẩm mỗi trang:</label>
		<input type="number" min="5" class="form-control" ng-model="soSanPhamMoiTrang" ng-change="capNhatSoSanPhamMoiTrang()">
	</fieldset>
	<fieldset class="form-group">
		<label>Đến trang:</label>
		<input type="number" min="1" max="{{soTrang}}" class="form-control" ng-model="trangHienTai" ng-change="denTrangThu()">
	</fieldset>
	<fieldset class="form-group">
		<label>Tìm sản phẩm:</label>
		<input type="text" minlength="0" maxlength="50" class="form-control" ng-model="sanPhamCanTim">
		<button class="btn btn-primary" style="float: right;" ng-click="timSanPham()"><i class="material-icons" aria-hidden="true">search</i></button>
	</fieldset>
	<fieldset class="form-group" ng-if="$root.nhanVienHienTai.chucVu.id > 2">
		<label class="custom-control custom-checkbox m-b-1">
            <input type="checkbox" ng-model="boQuaDaXoa" class="custom-control-input" ng-change="capNhatBoQuaDaXoa(boQuaDaXoa)">
            <span class="custom-control-indicator"></span>
            <span class="custom-control-description">Bỏ qua những sản phẩm đã xóa</span>
        </label>
	</fieldset>
	<button class="btn btn-toolbar" style="margin: auto;" ng-click="thongKeSanPham()">Thống kê tất cả sản phẩm</button>
</div>