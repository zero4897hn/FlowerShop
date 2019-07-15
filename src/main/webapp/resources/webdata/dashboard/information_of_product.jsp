<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-sm-12" ng-if="sanPham == 'null' || (sanPham.daXoa && $root.nhanVienHienTai.chucVu.id < 3)">
    <div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 300px 0px;">Chúng tôi không tìm thấy<br/>sản phẩm bạn yêu cầu.</h5>
        </div>
    </div>
</div>
<div class="col-sm-10 push-sm-1" ng-if="sanPham != 'null' && ((sanPham.daXoa && $root.nhanVienHienTai.chucVu.id > 2) || !sanPham.daXoa)">
	<div class="row" style="margin-top: 20px; margin-bottom: 20px">
		<div class="col-sm-12 text-xs-center">
			<h3 class="">Thông tin sản phẩm</h3>
		</div>
	</div>
	<div class="row" style="margin-top: 20px; margin-bottom: 20px">
		<div class="col-sm-4">
			<img ng-src="/FlowerShop/resources/images/products/{{sanPham.hinhAnh}}" class="img-fluid img-thumbnail">
		</div>
		<div class="col-sm-8">
			<table class="table table-bordered align-middle">
    			<tbody>
    				<tr>
    					<td class="card-text" style="width: 35%;">Tên sản phẩm:</td>
                        <td class="card-text" style="width: 65%;">{{sanPham.tenSanPham}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Thuộc danh mục:</td>
                        <td class="card-text" style="width: 65%;">{{sanPham.danhMuc.tenDanhMuc}}</td>
    				</tr>
    			</tbody>
    		</table>
		</div>
	</div>
	<div class="row" style="margin-top: 20px; margin-bottom: 20px">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					Các kiểu sản phẩm
				</div>
				<div class="card-block">
					<div ng-repeat="kieuSanPham in sanPham.danhSachKieuSanPham" class="card">
						<div class="card-header" ng-init="kieuSanPham.hienThi = true">
							{{kieuSanPham.tenKieu}}
							<div class="card-controls">
								<a href="javascript:;" ng-click="hienThiKieuSanPham(kieuSanPham)"><i class="material-icons" aria-hidden="true">keyboard_arrow_down</i></a>
							</div>
						</div>
						<div class="card-block">
							<table class="table table-bordered align-middle" ng-show="kieuSanPham.hienThi">
				    			<tbody>
				    				<tr>
				    					<td class="card-text" style="width: 35%;">Giá bán:</td>
				                        <td class="card-text" style="width: 65%;">
				                        	<div ng-if="!coKhuyenMai(kieuSanPham)">
					                        	{{kieuSanPham.giaTien | currency : "VND " : 0}}
					                        </div>
					                        <div ng-if="coKhuyenMai(kieuSanPham)">
					                        	<strike>{{kieuSanPham.giaTien | currency : "VND " : 0}}</strike>
					                        	{{getGiaKhuyenMai(kieuSanPham) | currency : "VND " : 0}}
					                        </div>
				                        </td>
				    				</tr>
				    				<tr>
				    					<td class="card-text" style="width: 35%;">Số lượng:</td>
				                        <td class="card-text" style="width: 65%;">{{kieuSanPham.soLuong}}</td>
				    				</tr>
				    				<tr>
				    					<td class="card-text" style="width: 35%;">Ngày nhập:</td>
				                        <td class="card-text" style="width: 65%;">{{kieuSanPham.ngayNhap}}</td>
				    				</tr>
				    				<tr>
				    					<td class="card-text" style="width: 35%;">Lượng mua:</td>
				                        <td class="card-text" style="width: 65%;">{{kieuSanPham.luongMua}}</td>
				    				</tr>
				    				<tr>
				    					<td class="card-text" style="width: 35%;">Khuyến mãi:</td>
				                        <td class="card-text" style="width: 65%;">
				                        	<ul style="margin: 0; padding: 0; list-style: none;">
				                        		<li ng-repeat="khuyenMai in kieuSanPham.danhSachKhuyenMai | filter: khuyenMaiHienTai">
				                        			<a href="event_info/{{khuyenMai.id}}">{{khuyenMai.tenKhuyenMai}} - giảm {{khuyenMai.phanTramGiam}}% - giảm tối đa {{khuyenMai.giaGiamToiDa | currency : "VND " : 0}}</a>
				                        		</li>
				                        	</ul>
				                        </td>
				    				</tr>
				    			</tbody>
				    		</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin-top: 20px; margin-bottom: 20px">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					Mô tả sản phẩm:
				</div>
				<div class="card-block">
					{{sanPham.moTa}}
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin-top: 20px; margin-bottom: 20px">
		<button class="btn btn-outline-primary" ng-click="raoBanSanPham()" ng-disabled="sanPham.banRa" ng-if="!sanPham.daXoa">Rao bán</button>
		<button class="btn btn-outline-warning" ng-click="huyBanSanPham()" ng-disabled="!sanPham.banRa" ng-if="!sanPham.daXoa">Hủy bán</button>
		<button class="btn btn-primary" ng-click="suaSanPham()" ng-if="!sanPham.daXoa">Sửa sản phẩm</button>
		<button class="btn btn-danger" ng-click="xoaSanPham(sanPham)" ng-if="!sanPham.daXoa">Xóa sản phẩm</button>
		<button class="btn btn-primary" ng-click="khoiPhucSanPham(sanPham)" ng-if="sanPham.daXoa && $root.nhanVienHienTai.chucVu.id > 2">Khôi phục sản phẩm</button>
		<button class="btn btn-outline-danger" ng-click="xoaVinhVien(sanPham)" ng-if="$root.nhanVienHienTai.chucVu.id > 2">Xóa vĩnh viễn</button>
	</div>
</div>