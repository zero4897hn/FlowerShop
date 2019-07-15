<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<style type="text/css">
	form[name="formThongTin"] fieldset span {
		color: red;
	}
</style>
<div class="container mt-3 mb-3" ng-if="danhSachDonHang.length > 0">
    <div class="row">
        <div class="col-sm-6">
            <div class="row">
                <div class="col-12">
                    <table class="table table-striped table-hover" style="width: 100%;">
                        <thead>
                            <tr>
                                <th class="align-middle" scope="col">#</th>
                                <th class="align-middle" scope="col" style="width: 10%;">Hình ảnh</th>
                                <th class="align-middle" scope="col" style="width: 30%;">Sản phẩm</th>
                                <th class="align-middle" scope="col">Đơn giá</th>
                                <th class="align-middle" scope="col" style="width: 10%;">Số lượng</th>
                                <th class="align-middle" scope="col">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
							<tr ng-repeat="donHang in danhSachDonHang">
								<th class="align-middle" scope="row">{{$index + 1}}</th>
								<td class="align-middle"><img class="img-fluid" ng-src="/FlowerShop/resources/images/products/{{donHang.kieuSanPham.sanPham.hinhAnh}}"></td>
								<td class="align-middle">{{donHang.kieuSanPham.sanPham.tenSanPham}}</td>
								<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham) | currency : "VND " : 0}}</td>
								<td class="align-middle">{{donHang.soLuong}}</td>
								<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham) * donHang.soLuong | currency : "VND " : 0}}</td>
							</tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-9">
                    <fieldset>
                        <label>Tổng tiền:</label>
						<h5 style="width: fit-content; padding: 0; margin: 0; display: inline-block;">{{tongTien() | currency : "VND " : 0}}</h5>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <fieldset class="form-group">
                        <label for="comboThanhToan">Hình thức thanh toán:</label>
                        <select class="form-control">
                            <option>Thanh toán khi nhận hàng</option>
                        </select>
                    </fieldset>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
        	<div class="row" ng-show="$root.idNhanVien != undefined">
                <div class="col-12">
                    <div class="radio">
                    	<label>
			                <input type="radio" ng-disabled="yeuCauCapNhatThongTin" ng-model="radioThongTinTaiKhoan" value="true"> Chuyển đến thông tin trong tài khoản
			            </label>
                    </div>
                </div>
        		<div class="col-12">
        			<span style="color: red;" ng-show="yeuCauCapNhatThongTin">Tài khoản của bạn chưa đủ thông tin nên chưa thể dùng tính năng này.</span>
        		</div>
        		<div class="col-12" ng-if="!yeuCauCapNhatThongTin && radioThongTinTaiKhoan == 'true'">
        			<fieldset class="form-group">
                        <label for="txtGhiChu">Ghi chú cho đơn hàng:</label>
                        <input type="text" class="form-control" ng-model="thongTin.ghiChu" placeholder="Nhập lưu ý cho đơn hàng">
                    </fieldset>
                	<button id="order-button" type="submit" class="btn btn-primary" ng-click="datHang(true, thongTin)">Đặt hàng</button>
        		</div>
            </div>
            <div class="row">
                <div class="col-12">
                	<div class="radio">
                		<label>
			                <input type="radio" ng-model="radioThongTinTaiKhoan" value="false"> Chuyển đến thông tin khác
			            </label>
                    </div>
                </div>
                <div class="col-12" ng-if="radioThongTinTaiKhoan == 'false'">
                    <form name="formThongTin">
                    	<fieldset class="form-group">
	                        <label for="txtHoVaTen">Họ và tên:</label>
	                        <input type="text" class="form-control" name="txtHoVaTen" ng-model="thongTin.hoVaTen" placeholder="Nhập họ và tên" ng-required="true">
	                        <span ng-show="formThongTin.txtHoVaTen.$dirty && formThongTin.txtHoVaTen.$error.required">Đây là ô bắt buộc phải điền</span>
	                    </fieldset>
	                    <fieldset class="form-group">
	                        <label for="txtSoDienThoai">Số điện thoại:</label>
	                        <input type="text" class="form-control" name="txtSoDienThoai" ng-model="thongTin.soDienThoai" placeholder="Nhập số điện thoại" ng-required="true">
	                        <span ng-show="formThongTin.txtSoDienThoai.$dirty && formThongTin.txtSoDienThoai.$error.required">Đây là ô bắt buộc phải điền</span>
	                    </fieldset>
	                    <fieldset class="form-group">
	                        <label for="txtDiaChi">Địa chỉ:</label>
	                        <input type="text" class="form-control" name="txtDiaChi" ng-model="thongTin.diaChi" placeholder="Nhập địa chỉ" ng-required="true">
	                        <span ng-show="formThongTin.txtDiaChi.$dirty && formThongTin.txtDiaChi.$error.required">Đây là ô bắt buộc phải điền</span>
	                    </fieldset>
	                    <fieldset class="form-group">
	                        <label for="txtGhiChu">Ghi chú cho đơn hàng:</label>
	                        <input type="text" class="form-control" ng-model="thongTin.ghiChu" placeholder="Nhập lưu ý cho đơn hàng">
	                    </fieldset>
                    </form>
                    <button type="submit" class="btn btn-primary" ng-click="datHang(false, thongTin)" ng-disabled="!formThongTin.$valid">Đặt hàng</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container mt-3 mb-3" ng-if="danhSachDonHang.length <= 0 || !danhSachDonHang">
	<div class="row justify-content-center align-items-center" style="width: 100%; height: 500px; padding: 0; margin: 0; background-color: #e5e5e5;">
        <h5>Trong giỏ hàng của bạn không có sản phẩm nào<br>nên không thể thanh toán.</h5>
    </div>
</div>