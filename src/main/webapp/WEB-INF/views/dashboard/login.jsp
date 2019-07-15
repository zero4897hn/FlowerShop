<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1" />
    <meta name="msapplication-tap-highlight" content="no">

    <meta name="mobile-web-app-capable" content="yes">
    <meta name="application-name" content="FlowerShop">

    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="FlowerShop">

    <meta name="theme-color" content="#4C7FF0">

    <title>Đăng nhập hệ thống</title>

    <!-- page stylesheets -->
    <!-- end page stylesheets -->

    <!-- build:css({.tmp,app}) styles/app.min.css -->
    <link rel="stylesheet" href='<c:url value="/resources/vendor/animate.css/animate.css"/>' />
    <link rel="stylesheet" href='<c:url value="/resources/styles/app.css"/>' id="load_styles_before" />
    <link rel="stylesheet" href='<c:url value="/resources/styles/app.skins.css"/>' />
    <!-- endbuild -->
    <!-- angular -->    
    <link rel="stylesheet" href='<c:url value="/resources/vendor/bootstrap.css"/>'>
    <link rel="stylesheet" href='<c:url value="/resources/vendor/angular-material.min.css"/>'>
    <link rel="stylesheet" href='<c:url value="/resources/vendor/font-awesome.css"/>'>
    <!-- /angular -->
</head>

<body ng-app="myApp" ng-controller="MyController">
    <div class="app no-padding no-footer layout-static">
        <div class="session-panel">
            <div class="session">
                <div class="session-content">
                    <div class="card card-block form-layout">
                        <form name="loginForm">
                            <div class="text-xs-center m-b-3">
                                <img src='<c:url value="/resources/images/logo_flowers.png"/>' class="m-b-1">
                                <h5>Chào mừng đến với hệ thống FlowerShop</h5>
                                <p class="text-muted">Vui lòng đăng nhập để tiếp tục.</p>
                                <span style="color: red;" ng-if="notification != undefined">{{notification}}</span>
                            </div>
                            <fieldset class="form-group">
                                <label>Tên đăng nhập:</label>
                                <input type="text" class="form-control form-control-lg" placeholder="Nhập tên đăng nhập" ng-model="dangNhap.tenDangNhap" ng-required="true"/>
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Mật khẩu:</label>
                                <input type="password" class="form-control form-control-lg" placeholder="Nhập mật khẩu" ng-model="dangNhap.matKhau" ng-required="true"/>
                            </fieldset>
                            <label class="custom-control custom-checkbox m-b-1">
                                <input type="checkbox" ng-model="dangNhap.ghiNhoDangNhap" class="custom-control-input">
                                <span class="custom-control-indicator"></span>
                                <span class="custom-control-description">Lưu lại cho lần đăng nhập tới</span>
                            </label>
                            <button class="btn btn-primary btn-block btn-lg" type="button" ng-disabled="loginForm.$invalid" ng-click="dangNhapTaiKhoan(dangNhap)">Đăng nhập</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- build:js({.tmp,app}) scripts/app.min.js -->
    <script type="text/javascript" src='<c:url value="/resources/vendor/tether/dist/js/tether.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/fastclick/lib/fastclick.js"/>'></script>
    <!-- endbuild -->

    <!-- angular script -->
    <script type="text/javascript" src='<c:url value="/resources/vendor/bootstrap.js"/>'></script>  
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-1.5.min.js"/>'></script>  
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-animate.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-cookies.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-aria.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-messages.min.js"/>'></script>
    <script type="text/javascript" src='<c:url value="/resources/vendor/angular-material.min.js"/>'></script>  
    <!-- end angular script -->
    
    <script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_login.js"/>'></script>

</body>

</html>