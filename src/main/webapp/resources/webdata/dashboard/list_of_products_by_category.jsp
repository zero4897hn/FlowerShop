<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="col-sm-10 push-sm-1">
	<div class="row">
		<div class="col-12">
			<button ng-click="themDanhMuc()" style="margin-bottom: 22px;" class="btn btn-outline-primary"><i class="material-icons" aria-hidden="true">add</i> Thêm danh mục</button>
		</div>
	</div>
	<div class="row">
		<div id='category-field' class="col-12">
			<div class="card" ng-repeat="danhMuc in listDanhMuc" ng-init="initiateDanhMuc(danhMuc)">
		        <div class="card-header">
		            <div style="width: 70%;">
		            	<h6 ng-show="!danhMuc.chinhSuaDanhMuc">{{danhMuc.tenDanhMuc}}</h6>
		            	<input ng-show="danhMuc.chinhSuaDanhMuc" type="text" class="form-control" ng-model="danhMuc.tenDanhMuc">
		            </div>
		            <div class="card-controls">
		            	<a href="javascript:;" ng-click="batDauSuaDanhMuc(danhMuc)" ng-show="!danhMuc.chinhSuaDanhMuc"><i class="material-icons" aria-hidden="true">edit</i></a>
		            	<a href="javascript:;" ng-click="ketThucSuaDanhMuc(danhMuc)" ng-show="danhMuc.chinhSuaDanhMuc"><i class="material-icons" aria-hidden="true">done</i></a>
		                <a href="javascript:;" ng-click="hienThiSanPham(danhMuc)"><i class="material-icons" aria-hidden="true">keyboard_arrow_down</i></a>
		                <a href="javascript:;" ng-click="xoaDanhMuc(danhMuc)"><i class="material-icons" aria-hidden="true">delete</i></a>
		            </div>
		        </div>
		        <div class="card-block" ng-show="danhMuc.hienThiDanhSachSanPham">
		        	<fieldset class="form-group" ng-if="$root.nhanVienHienTai.chucVu.id > 2 && danhMuc.danhSachSanPham.length > 0">
						<label class="custom-control custom-checkbox m-b-1" style="float: right;">
				            <input type="checkbox" ng-model="danhMuc.boQuaDaXoa" class="custom-control-input" ng-change="capNhatBoQuaDaXoa(danhMuc)">
				            <span class="custom-control-indicator"></span>
				            <span class="custom-control-description">Bỏ qua những sản phẩm đã xóa</span>
				        </label>
					</fieldset>
			        <div class="col-sm-12" style="padding: 0; margin: 0; background-color: #e5e5e5; width: 100%" ng-if="danhMuc.danhSachSanPham.length <= 0 || danhMuc.danhSachSanPham == undefined">
			            <h5 class="text-xs-center" style="margin: 160px 0px;">Danh sách sản phẩm trống</h5>
			        </div>
		            <table class="table table-striped" ng-if="danhMuc.danhSachSanPham.length > 0">
		                <thead>
		                    <tr>
		                        <th style="width: 5%;">#</th>
		                        <th style="width: 45%;">Tên sản phẩm</th>
		                        <th style="width: 30%;">Giá bán</th>
		                        <th style="width: 20%;">Thao tác</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr ng-repeat="sanPham in danhMuc.danhSachSanPham">
		                        <th class="align-middle" scope="row" style="width: 5%;">{{$index + 1}}</th>
		                        <td class="align-middle" style="width: 45%;"><a href="product_info/{{sanPham.id}}">{{sanPham.tenSanPham}}</a></td>
		                        <td class="align-middle" style="width: 30%;" ng-switch on="sanPham.danhSachKieuSanPham.length">
									<div ng-switch-when="1">{{getGiaKhuyenMai(sanPham.danhSachKieuSanPham[0]) | currency : "VND " : 0}}</div>
									<div ng-switch-default ng-init="setMinAndMax(sanPham)">
										{{sanPham.giaThapNhat | currency : "VND " : 0}}
										~
										{{sanPham.giaCaoNhat | currency : "VND " : 0}}
									</div>
				                </td>
		                        <td class="align-middle" style="width: 20%;">
		                        	<button style="border: 1px solid gray; background: none; border-radius: 5px;" ng-click="suaSanPham(sanPham)" ng-if="!sanPham.daXoa"><i class="material-icons" aria-hidden="true">edit</i></button>
		                        	<button style="border: 1px solid gray; background: none; border-radius: 5px;" ng-click="xoaSanPham(sanPham, danhMuc)" ng-if="!sanPham.daXoa"><i class="material-icons" aria-hidden="true">delete</i></button>
		                        	<div ng-if="sanPham.daXoa">Đã xóa</div>
								</td>
		                    </tr>
		                </tbody>
		            </table>
		            <button class="btn btn-toolbar" style="margin: auto;" ng-click="thongKeDanhSachSanPham(danhMuc)" ng-if="danhMuc.danhSachSanPham.length > 0">Thống kê danh sách sản phẩm</button>
		        </div>
		    </div>
		</div>
	</div>
</div>