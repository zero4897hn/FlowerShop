<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<div class="container mt-3 mb-3" ng-if="hoaDon == 'null'">
    <div class="row justify-content-center align-items-center" style="width: 100%; height: 600px; padding: 0; margin: 0; background-color: #e5e5e5;">
        <h5>Xin lỗi, chúng tôi không tìm thấy <br/> hóa đơn bạn yêu cầu.</h5>
    </div>
</div>
<div class="container" ng-if="hoaDon != 'null'">
	<div class="row mt-3">
		<div class="col-12">
			<h4 class="text-center">Hóa đơn {{hoaDon.maHoaDon}}</h4>
		</div>
	</div>
	<div class="row mt-3">
		<div class="col-12">
			<table class="table table-bordered align-middle" ng-show="!x.enabledEdit">
    			<tbody>
    				<tr>
    					<td class="card-text" style="width: 35%;">Tên người đặt:</td>
                        <td class="card-text" style="width: 65%;">{{hoaDon.hoTenNguoiNhan}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Địa chỉ:</td>
                        <td class="card-text" style="width: 65%;">{{hoaDon.diaChiGiaoHang}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Số điện thoại:</td>
                        <td class="card-text" style="width: 65%;">{{hoaDon.soDienThoai}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Ngày lập hóa đơn:</td>
                        <td class="card-text" style="width: 65%;">{{hoaDon.ngayLapDate | date: 'dd/MM/yyyy HH:mm:ss'}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Tình trạng:</td>
                        <td class="card-text" style="width: 65%;">{{tinhTrangHoaDon[hoaDon.tinhTrang]}}</td>
    				</tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Ghi chú:</td>
                        <td class="card-text" style="width: 65%;">{{hoaDon.ghiChu}}</td>
                    </tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Tổng tiền:</td>
                        <td class="card-text" style="width: 65%;">{{tongTien() | currency : "VND " : 0}}</td>
    				</tr>
    			</tbody>
    		</table>
    		<div class="card">
    			<div class="card-header">
    				Các đơn hàng đã đặt
    			</div>
    			<div class="card-block">
    				<table class="table table-striped table-hover" style="width: 100%;">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col" style="width: 10%;">Hình ảnh</th>
								<th scope="col" style="width: 40%;">Sản phẩm</th>
								<th scope="col">Đơn giá</th>
								<th scope="col" style="width: 10%;">Số lượng</th>
								<th scope="col">Thành tiền</th>
							</tr>
						</thead>
						<tbody>
							<tr ng-repeat="donHang in hoaDon.danhSachDonHang">
								<th class="align-middle" scope="row">{{$index + 1}}</th>
								<td class="align-middle">
									<img ng-src="/FlowerShop/resources/images/products/{{donHang.kieuSanPham.sanPham.hinhAnh}}" class="img img-fluid">
								</td>
								<td class="align-middle"><a href="chi_tiet_san_pham/{{donHang.kieuSanPham.sanPham.id}}" style="text-decoration: none;">{{donHang.kieuSanPham.sanPham.tenSanPham}}</a></td>
								<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham) | currency : "VND " : 0}}</td>
								<td class="align-middle">{{donHang.soLuong}}</td>
								<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham) * donHang.soLuong | currency : "VND " : 0}}</td>
							</tr>
						</tbody>
					</table>
				</div>
    		</div>
		</div>
	</div>
</div>