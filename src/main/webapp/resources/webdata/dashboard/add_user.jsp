<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style type="text/css">
	#add-user-form fieldset span {
		color: red;
	}
</style>
<div class="col-xs-12" ng-if="$root.nhanVienHienTai.chucVu.id < 3">
    <div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 300px 0px;">Bạn không thể thêm người dùng<br/>khi bạn là nhân viên</h5>
        </div>
    </div>
</div>
<div id="add-user-form" class="col-sm-8 push-sm-2" ng-form="addUserForm" ng-if="$root.nhanVienHienTai.chucVu.id > 2">
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Họ và tên:</label>
	    <input type="text" ng-maxlength="50" class="form-control" placeholder="Nhập họ tên" name="txtHoVaTen" ng-model="txtHoVaTen" ng-required="true"/>
	    <span ng-show="addUserForm.txtHoVaTen.$dirty && addUserForm.txtHoVaTen.$error.required">Đây là ô bắt buộc phải điền</span>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Ngày sinh:</label>
	    <input type="date" class="form-control" ng-model="dateNgaySinh"/>
	</fieldset>
	<div class="radio">
	    <label>Giới tính:</label>
	    <label>
	        <input type="radio" ng-model="radGioiTinh" ng-value="true" ng-checked="radGioiTinh"/> Nam
	    </label>
	    <label>
	        <input type="radio" ng-model="radGioiTinh" ng-value="false"/> Nữ
	    </label>
	</div>
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Địa chỉ:</label>
	    <input type="text" ng-maxlength="255" class="form-control" placeholder="Nhập địa chỉ" ng-model="txtDiaChi"/>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Chứng minh nhân dân:</label>
	    <input type="text" ng-maxlength="15" class="form-control" placeholder="Nhập chứng minh nhân dân" name="txtChungMinhNhanDan" ng-model="txtChungMinhNhanDan" ng-pattern="/^[0-9]{1,15}$/"/>
	    <span ng-show="addUserForm.txtChungMinhNhanDan.$dirty && addUserForm.txtChungMinhNhanDan.$error.pattern">Chứng minh nhân dân chỉ được nhập số, không quá 15 ký tự</span>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Số điện thoại:</label>
	    <input type="text" ng-maxlength="15" class="form-control" placeholder="Nhập số điện thoại" name="txtSoDienThoai" ng-model="txtSoDienThoai" ng-pattern="/^[0-9]{1,15}$/" ng-required="true"/>
	    <span ng-show="addUserForm.txtSoDienThoai.$dirty && addUserForm.txtSoDienThoai.$error.required">Đây là ô bắt buộc phải điền</span>
	    <span ng-show="addUserForm.txtSoDienThoai.$dirty && addUserForm.txtSoDienThoai.$error.pattern">Số điện thoại chỉ được nhập số, không quá 15 ký tự</span>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Email:</label>
	    <input type="email" ng-maxlength="50" class="form-control" placeholder="Nhập email" name="txtEmail" ng-model="txtEmail" ng-required="true"/>
	    <span ng-show="addUserForm.txtEmail.$dirty && addUserForm.txtEmail.$error.required">Đây là ô bắt buộc phải điền</span>
	    <span ng-show="addUserForm.txtEmail.$dirty && addUserForm.txtEmail.$error.email">Xin hãy nhập đúng định dạng email</span>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleSelect2">Chức vụ:</label>
	    <select class="form-control" ng-model="cbChucVu">
	        <option ng-repeat="x in listChucVu" value="{{x.id}}">{{x.tenChucVu}}</option>
	    </select>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleInputFile">Avatar:</label>
	    <input type="file" accept=".gif,.jpg,.jpeg,.png" class="form-control-file" file-model="fileAvatar"/>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Tên đăng nhập:</label>
	    <input type="text" ng-maxlength="50" class="form-control" placeholder="Nhập tên đăng nhập" ng-model="txtTenDangNhap" name="txtTenDangNhap" ng-required="true"/>
	    <span ng-show="addUserForm.txtTenDangNhap.$dirty && addUserForm.txtTenDangNhap.$error.required">Đây là ô bắt buộc phải điền</span>
	</fieldset>
	<fieldset class="form-group">
	    <label for="exampleInputEmail1">Mật khẩu:</label>
	    <input type="password" ng-maxlength="50" class="form-control" placeholder="Nhập mật khẩu" ng-model="txtMatKhau" name="txtMatKhau" ng-required="true"/>
	    <span ng-show="addUserForm.txtMatKhau.$dirty && addUserForm.txtMatKhau.$error.required">Đây là ô bắt buộc phải điền</span>
	</fieldset>
	<button type="button" ng-disabled="!addUserForm.$valid" class="btn btn-primary" ng-click="xuLyDangKy()">Thêm người dùng</button>
</div>