<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>

<head>
    <base href="/FlowerShop/dangnhap/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" type="text/css" href='<c:url value="/resources/vendor/bootstrap.min.css"/>'>
    <link rel="stylesheet" type="text/css" href='<c:url value="/resources/vendor/font-awesome.css"/>'>
    <link rel="stylesheet" type="text/css" href='<c:url value="/resources/vendor/angular-material.min.css"/>'>
    <title>Đăng nhập Flower Shop</title>
</head>
<style type="text/css">
    body, html {
        height: 100%;
    }
    body {
        background: url(<c:url value="/resources/images/login_background.jpeg" />) no-repeat center center fixed;
        background-size: cover;
        }
    #login-form {
        background-color: #5d913d94;
        width: fit-content;
        padding: 20px;
        border-radius: 15px;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: white;
    }
    #login-form fieldset input {
        width: 400px;
    }
    span.go-direct {
        text-decoration: none;
        color: #272768 !important;
    }
    span.go-direct:hover {
        cursor: pointer;
    }
    #register-form {
        background-color: #5d913d94;
        width: fit-content;
        padding: 20px;
        border-radius: 15px;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        color: white;
    }
    #register-form fieldset input {
        width: 400px;
    }
</style>
<body ng-app="myApp" ng-controller="MyController">
    <div id="login-form" ng-if="!isDangKy">
        <form name="formDangNhap" style="width: fit-content">
            <h1 class="text-center">Đăng nhập</h1>
            <h5 class="text-center" style="color: red;">{{notification}}</h5>
            <fieldset class="form-group">
                <label>Tên đăng nhập:</label>
                <input type="text" class="form-control" ng-model="dangNhap.tenDangNhap" placeholder="Nhập tài khoản" ng-required="true">
            </fieldset>
            <fieldset class="form-group">
                <label>Mật khẩu</label>
                <input type="password" class="form-control" ng-model="dangNhap.matKhau" placeholder="Nhập mật khẩu" ng-required="true">
            </fieldset>
            <div style="width: 100%;">
                <button type="button" ng-disabled="formDangNhap.$invalid" class="btn btn-primary" ng-click="dangNhapTaiKhoan(dangNhap)">Đăng nhập</button>
                <span style="float: right;">Chưa có tài khoản? <span class="go-direct" ng-click="chuyenTrangThai()">Đăng ký</span> ngay!</span>
            </div>
        </form>
    </div>
    <div id="register-form" ng-if="isDangKy">
        <form name="formDangKy">
            <h1 class="text-center">Đăng ký</h1>
            <fieldset class="form-group">
                <label>Họ và tên:</label>
                <input type="text" maxlength="50" class="form-control" name="txtHoVaTen" ng-model="dangKy.tenNhanVien" placeholder="Nhập họ và tên" ng-required="true">
                <span ng-show="formDangKy.txtHoVaTen.$dirty && formDangKy.txtHoVaTen.$error.required">Đây là ô bắt buộc phải điền</span>
            </fieldset>
            <div class="radio row">
                <label class="col-form-label col-4">Giới tính:</label>
                <label class="col-form-label col-4">
                    <input type="radio" ng-model="dangKy.gioiTinh" ng-value="true"> Nam
                </label>
                <label class="col-form-label col-4">
                    <input type="radio" ng-model="dangKy.gioiTinh" ng-value="false"> Nữ
                </label>
            </div>
            <fieldset class="form-group">
                <label>Số điện thoại:</label>
                <input maxlength="15" type="text" class="form-control" ng-model="dangKy.soDienThoai" placeholder="Nhập số điện thoại" ng-required="true" ng-pattern="/^[0-9]{1,15}$/" name="txtSoDienThoai">
                <span ng-show="formDangKy.txtSoDienThoai.$dirty && formDangKy.txtSoDienThoai.$error.required">Đây là ô bắt buộc phải điền</span>
                <span ng-show="formDangKy.txtSoDienThoai.$dirty && formDangKy.txtSoDienThoai.$error.pattern">Số điện thoại chỉ được nhập số, không quá 15 ký tự</span>
            </fieldset>
            <fieldset class="form-group">
                <label>Tên đăng nhập:</label>
                <input maxlength="50" type="text" class="form-control" ng-model="dangKy.tenDangNhap" placeholder="Nhập tên đăng nhập" ng-required="true" name="txtTenDangNhap">
                <span ng-show="formDangKy.txtTenDangNhap.$dirty && formDangKy.txtTenDangNhap.$error.required">Đây là ô bắt buộc phải điền</span>
            </fieldset>
            <fieldset class="form-group">
                <label>Mật khẩu:</label>
                <input maxlength="50" type="password" class="form-control" name="txtNewPassword" ng-model="dangKy.matKhau" placeholder="Nhập mật khẩu" ng-required="true">
                <span ng-show="formDangKy.txtNewPassword.$dirty && formDangKy.txtNewPassword.$error.required">Đây là ô bắt buộc phải điền</span>
            </fieldset>
            <fieldset class="form-group">
                <label>Xác nhận mật khẩu:</label>
                <input maxlength="50" type="password" class="form-control" name="txtConfirmPassword" ng-model="dangKy.xacNhanMatKhau" placeholder="Nhập lại mật khẩu" ng-required="true">
            </fieldset>
            <div style="width: 100%;">
                <button class="btn btn-primary" ng-disabled="formDangKy.$invalid || (formDangKy.txtConfirmPassword.$dirty && formDangKy.txtConfirmPassword.$valid && !formDangKy.txtConfirmPassword.$invalid) && (formDangKy.txtNewPassword.$modelValue != formDangKy.txtConfirmPassword.$modelValue)" ng-click="dangKyTaiKhoan(dangKy)">Đăng ký</button>
                <span style="float: right;">Đã có tài khoản? <span class="go-direct" ng-click="chuyenTrangThai()">Đăng nhập</span> ngay!</span>
            </div>
        </form>
    </div>

	
	<script type="text/javascript" src='<c:url value="/resources/vendor/angular-1.5.min.js"/>'></script>
 
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-route.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-animate.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-cookies.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-aria.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-messages.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-material.min.js"/>'></script>

    <script type="text/javascript" src='<c:url value="/resources/custom/custom_dang_nhap.js"/>'></script>
</body>

</html>