<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<div class="cart-info container mt-3 mb-3" ng-if="danhSachDonHang.length > 0">
	<div class="row">
		<div class="col-12">
			<table class="table table-striped table-hover" style="width: 100%;">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col" style="width: 10%;">Hình ảnh</th>
						<th scope="col" style="width: 40%;">Sản phẩm</th>
						<th scope="col">Đơn giá</th>
						<th scope="col" style="width: 10%;">Số lượng</th>
						<th scope="col">Thành tiền</th>
						<th scope="col">Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="donHang in danhSachDonHang">
						<td class="align-middle" scope="row">{{$index + 1}}</td>
						<td class="align-middle"><img class="img-fluid" ng-src="/FlowerShop/resources/images/products/{{donHang.kieuSanPham.sanPham.hinhAnh}}"></td>
						<td class="align-middle"><a href="chi_tiet_san_pham/{{donHang.kieuSanPham.sanPham.id}}" style="text-decoration: none;">{{donHang.kieuSanPham.sanPham.tenSanPham}}</a></td>
						<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham) | currency : "VND " : 0}}</td>
						<td class="align-middle"><input type="number" min="1" class="form-control" ng-model="donHang.soLuong" ng-change="capNhatSoLuongDonHang(donHang)"></td>
						<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham) * donHang.soLuong | currency : "VND " : 0}}</td>
						<td class="align-middle">
							<button style="border: 1px solid gray; background: none; border-radius: 5px; width: 35px; height: 35px;" ng-click="xoaDonHang(donHang)"><i class="fa fa-trash"></i></button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="cart-info container mt-3 mb-3" ng-if="danhSachDonHang.length > 0">
	<div class="row">
		<div class="col-9">
			<fieldset class="float-right">
				<label>Tổng tiền:</label>
				<h5 style="width: fit-content; padding: 0; margin: 0; display: inline-block;">{{tongTien() | currency : "VND " : 0}}</h5>
			</fieldset>
		</div>
		<div class="col-3">
			<button class="btn btn-primary" style="width: 100%;" ng-click="thanhToanGioHang()">Thanh toán</button>
		</div>
	</div>
</div>
<div class="container mt-3 mb-3" ng-if="danhSachDonHang.length <= 0 || !danhSachDonHang">
	<div class="row justify-content-center align-items-center" style="width: 100%; height: 400px; padding: 0; margin: 0; background-color: #e5e5e5;">
        <h5>Trong giỏ hàng chưa có gì. Mua sắm ngay thôi!</h5>
    </div>
</div>