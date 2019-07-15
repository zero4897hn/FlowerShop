<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<div class="container mb-3 mt-3" ng-if="!loginRequire">
	<div class="row">
		<div class="col-3">
			<img onError="this.onerror=null;this.src='/FlowerShop/resources/images/avatars/anonymous_avatar.png';" ng-src="/FlowerShop/resources/images/avatars/{{nhanVien.avatar}}" class="img-fluid img-thumbnail">
			<div style="width: 100%" class="mt-3 d-flex justify-content-center">
				<button class="btn btn-primary" ng-click="thayAvatar()">Đổi Avatar</button>
			</div>
		</div>
		<div class="col-9">
			<div class="row">
				<div class="col-12 p-3 mb-3" style="border: 3px solid #8dcc8d; border-radius: 20px;" ng-show="!enabledEdit">
					<h4>Thông tin người dùng</h4>
					<hr>
					<a class="float-right" href="javascript:;" ng-click="batDauChinhSua()">Sửa</a>
					<table style="width: 80%">
						<tr>
							<td><b>Họ và tên: </b></td>
							<td>{{nhanVien.tenNhanVien}}</td>
						</tr>
						<tr>
							<td><b>Ngày sinh: </b></td>
							<td>{{nhanVien.ngaySinh | date: 'dd/MM/yyyy'}}</td>
						</tr>
						<tr>
							<td><b>Giới tính: </b></td>
							<td>{{nhanVien.gioiTinh}}</td>
						</tr>
						<tr>
							<td><b>Địa chỉ: </b></td>
							<td>{{nhanVien.diaChi}}</td>
						</tr>
						<tr>
							<td><b>Số điện thoại: </b></td>
							<td>{{nhanVien.soDienThoai}}</td>
						</tr>
						<tr>
							<td><b>Ngày tạo:</b></td>
							<td>{{nhanVien.ngayThem}}</td>
						</tr>
					</table>
				</div>
				<div class="col-12 p-3 mb-3" style="border: 3px solid #8dcc8d; border-radius: 20px;" ng-show="enabledEdit">
					<h4>Thông tin người dùng</h4>
					<hr>
					<button class="btn btn-primary float-right" ng-disabled="!formNguoiDung.$valid" ng-click="ketThucChinhSua()">Cập nhật</button>
					<form name="formNguoiDung">
						<table id="user-info-table" style="width: 80%">
							<tr>
								<td><b>Họ và tên: </b></td>
								<td>
									<input type="text" class="form-control" ng-model="nhanVien.tenNhanVien" ng-required="true">
								</td>
							</tr>
							<tr>
								<td><b>Ngày sinh: </b></td>
								<td>
									<input type="date" class="form-control" ng-model="nhanVien.ngaySinh" ng-required="true">
								</td>
							</tr>
							<tr>
								<td><b>Giới tính: </b></td>
								<td>
									<label>
	                                    <input type="radio" ng-model="nhanVien.gioiTinh" value="Nam" ng-checked="nhanVien.gioiTinh == 'Nam'"/> Nam
	                                </label>
	                                <label>
	                                    <input type="radio" ng-model="nhanVien.gioiTinh" value="Nữ" ng-checked="nhanVien.gioiTinh == 'Nữ'"/> Nữ
	                                </label>
								</td>
							</tr>
							<tr>
								<td><b>Địa chỉ: </b></td>
								<td>
									<input type="text" class="form-control" ng-model="nhanVien.diaChi" ng-maxlength="255" ng-required="true">
								</td>
							</tr>
							<tr>
								<td><b>Số điện thoại: </b></td>
								<td>
									<input type="text" class="form-control" ng-model="nhanVien.soDienThoai" ng-maxlength="15" ng-required="true">
								</td>
							</tr>
							<tr>
								<td><b>Ngày tạo:</b></td>
								<td>{{nhanVien.ngayThem}}</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="col-12 p-3 mt-3 mb-3" style="border: 3px solid #8dcc8d; border-radius: 20px;">
					<h4>Thông tin bảo mật</h4>
					<hr>
					<table style="width: 100%">
						<tr>
							<td><b>Email:</b></td>
							<td>
								<a href="javascript:;" ng-click="capNhatEmail()" ng-show="!enabledEditEmail">Cập nhật email</a>
								<form name="emailForm">
									<fieldset class="form-group" ng-show="enabledEditEmail">
										<input type="email" class="form-control" ng-model="nhanVien.email" placeholder="Nhập email mới" ng-required="true">
										<button class="btn btn-primary float-right" ng-click="xacNhanCapNhatEmail()" ng-disabled="!emailForm.$valid">Xác nhận</button>
									</fieldset>
								</form>
							</td>
						</tr>
						<tr>
							<td><b>Chứng minh nhân dân:</b></td>
							<td>
								<a href="javascript:;" ng-show="!enabledEditChungMinh" ng-click="capNhatChungMinh()">Cập nhật chứng minh thư</a>
								<form name="cmndForm">
									<fieldset class="form-group" ng-show="enabledEditChungMinh">
										<input type="text" class="form-control" ng-model="nhanVien.chungMinhNhanDan" placeholder="Nhập chứng minh nhân dân mới" ng-required="true">
										<button class="btn btn-primary float-right" ng-click="xacNhanCapNhatChungMinhNhanDan()" ng-disabled="!cmndForm.$valid">Xác nhận</button>
									</fieldset>
								</form>
							</td>
						</tr>
						<tr>
							<td><b>Mật khẩu:</b></td>
							<td><a href="javascript:;" ng-click="capNhatMatKhau()">Đổi mật khẩu</a></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>