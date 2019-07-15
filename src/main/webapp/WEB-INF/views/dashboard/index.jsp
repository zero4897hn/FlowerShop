<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<!DOCTYPE html>
<html>
<head>
	<base href="/FlowerShop/admin/">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1" />
    <meta name="msapplication-tap-highlight" content="no">

    <meta name="mobile-web-app-capable" content="yes">
    <meta name="application-name" content="Milestone">

    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Milestone">

    <meta name="theme-color" content="#4C7FF0">
	<jsp:include page="headerlibs.jsp"/>
	<title>Trang quản lý FlowerShop</title>
</head>
<body ng-app="myApp" ng-controller="MyController">
	<div class="app">
        <!--sidebar panel-->
        <div class="off-canvas-overlay" data-toggle="sidebar"></div>
        <div class="sidebar-panel">
            <div class="brand">
                <!-- toggle offscreen menu -->
                <a href="javascript:;" data-toggle="sidebar" class="toggle-offscreen hidden-lg-up">
                    <i class="material-icons">menu</i>
                </a>
                <!-- /toggle offscreen menu -->
                <!-- logo -->
                <a class="brand-logo">
                    <img class="expanding-hidden" src='<c:url value="/resources/images/logo_flowers.png"/>' alt="" />
                </a>
                <!-- /logo -->
            </div>
            <div class="nav-profile dropdown">
                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
                    <div class="user-image">
                        <img ng-src="/FlowerShop/resources/images/avatars/{{$root.nhanVienHienTai.avatar}}" class="avatar img-circle" alt="user" title="user" onError="this.onerror=null;this.src='/FlowerShop/resources/images/avatars/anonymous_avatar.png';" />
                    </div>
                    <div class="user-info expanding-hidden">
                        {{$root.nhanVienHienTai.tenNhanVien}}
                        <small class="bold">{{$root.nhanVienHienTai.chucVu.tenChucVu}}</small>
                    </div>
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="/FlowerShop">Trở về trang chủ</a>
                    <a class="dropdown-item" href="user_info/{{$root.nhanVienHienTai.id}}">Thông tin cá nhân</a>
<!--                     <a class="dropdown-item" href="javascript:;">
                        <span>Notifications</span>
                        <span class="tag bg-primary">34</span>
                    </a> -->
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="javascript:;" ng-click="dangXuatKhoiTaiKhoan()">Đăng xuất</a>
                </div>
            </div>
            <!-- main navigation -->
            <nav>
                <p class="nav-title">MỤC QUẢN LÝ</p>
                <ul class="nav">
                    <!-- Trang chủ -->
                    <li>
                        <a href="home_page">
                            <i class="material-icons text-primary">home</i>
                            <span>Trang chủ</span>
                        </a>
                    </li>
                    <!-- /Trang chủ -->
                    <!-- Quản lý người dùng -->
                    <li ng-show="$root.nhanVienHienTai.chucVu.id > 2">
                        <a href="javascript:;">
                            <span class="menu-caret">
                  				<i class="material-icons">arrow_drop_down</i>
                			</span>
                            <i class="material-icons text-danger" aria-hidden="true">person</i>
                            
                            <span>Quản lý người dùng</span>
                        </a>
                        <ul class="sub-menu">
                            <li>
                                <a href="user_list">
                                    <span>Danh sách người dùng</span>
                                </a>
                            </li>
                            <li>
                                <a href="user_add">
                                    <span>Thêm người dùng</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- /Quản lý người dùng -->
                    <!-- Quản lý danh mục -->
                    <li>
                        <a href="javascript:;">
                            <span class="menu-caret">
								<i class="material-icons">arrow_drop_down</i>
                			</span>
                            <i class="material-icons text-success" aria-hidden="true">local_florist</i>
                            <span>Quản lý sản phẩm</span>
                        </a>
                        <ul class="sub-menu">
                            <li>
                                <a href="product_list_by_category"><span>Danh sách sản phẩm theo danh mục</span></a>
                            </li>
                            <li>
                                <a href="product_list"><span>Danh sách tất cả sản phẩm</span></a>
                            </li>
                            <li>
                                <a href="product_add"><span>Thêm sản phẩm</span></a>
                            </li>
                        </ul>
                    </li>
                    <!-- /Quản lý danh mục -->
                    <!-- Quản lý chương trình khuyến mãi -->
                    <li>
                        <a href="javascript:;">
                            <span class="menu-caret">
                                <i class="material-icons">arrow_drop_down</i>
                            </span>
                            <i class="material-icons text-warning" aria-hidden="true">event</i>
                            <span>Chương trình khuyến mãi</span>
                        </a>
                        <ul class="sub-menu">
                            <li>
                                <a href="event_list">
                                    <span>Danh sách khuyến mãi</span>
                                </a>
                            </li>
                            <li>
                                <a href="event_add">
                                    <span>Thêm chương trình khuyến mãi</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- /Quản lý chương trình khuyến mãi -->
                </ul>
                <p class="nav-title">PHẦN THÊM</p>
                <ul class="nav">
                    <!-- Quản lý đơn hàng -->
                    <li>
                        <a href="order_list">
                            <i class="material-icons" aria-hidden="true">local_grocery_store</i>
                            <span class="badge bg-primary pull-right" ng-if="$root.soHoaDonChuaDoc > 0">{{$root.soHoaDonChuaDoc}}</span>
                            <span>Tất cả hóa đơn</span>
                        </a>
                    </li>
                    <!-- /Quản lý đơn hàng -->
                    <!-- Thư góp ý -->
                    <li>
                        <a href="feedback_list">
                            <i class="material-icons" aria-hidden="true">contact_mail</i>
                            <span class="badge bg-primary pull-right" ng-if="$root.soPhanHoiChuaDoc > 0">{{$root.soPhanHoiChuaDoc}}</span>
                            <span>Thư góp ý</span>
                        </a>
                    </li>
                    <!-- /Thư góp ý -->
                    <!-- Quản lý trang chủ -->
                    <li>
                        <a href="homepage_edit">
                            <i class="material-icons" aria-hidden="true">home</i>
                            <span>Quản lý trang chủ</span>
                        </a>
                    </li>
                    <!-- /Quản lý trang chủ -->
                    <!-- Quản lý đánh giá -->
                    <li>
                        <a href="product_rate">
                            <i class="material-icons" aria-hidden="true">rate_review</i>
                            <span class="badge bg-primary pull-right" ng-if="$root.soDanhGiaChuaDoc > 0">{{$root.soDanhGiaChuaDoc}}</span>
                            <span>Đánh giá sản phẩm</span>
                        </a>
                    </li>
                    <!-- /Quản lý đánh giá -->
                    <!-- Lịch sử tương tác -->
                    <li>
                        <a href="history">
                            <i class="material-icons" aria-hidden="true">access_time</i>
                            <span>Lịch sử tương tác</span>
                        </a>
                    </li>
                    <!-- /Lịch sử tương tác -->
                </ul>
            </nav>
            <!-- /main navigation -->
        </div>
        <!-- /sidebar panel -->
        <!-- content panel -->
        <div class="main-panel">
            <!-- top header -->
            <nav class="header navbar">
                <div class="header-inner">
                    <div class="navbar-item navbar-spacer-right brand hidden-lg-up">
                        <!-- toggle offscreen menu -->
                        <a href="javascript:;" data-toggle="sidebar" class="toggle-offscreen">
                            <i class="material-icons">menu</i>
                        </a>
                        <!-- /toggle offscreen menu -->
                        <!-- logo -->
                        <a class="brand-logo hidden-xs-down">
                            <img src='<c:url value="/resources/images/logo_flowers.png"/>' alt="logo" />
                        </a>
                        <!-- /logo -->
                    </div>
                    <a class="navbar-item navbar-spacer-right navbar-heading hidden-md-down" href="javascript:;">
                        <span>{{Page.title()}}</span>
                    </a>
                </div>
            </nav>
            <!-- /top header -->

            <!-- main area -->
            <div class="main-content">
				<div class="content-view">
					<div class="row">
						<div ng-view>
						</div>
					</div>
                </div> 
                
                <!-- bottom footer -->
				<div class="content-footer">
					<nav class="footer-right">
						<ul class="nav">
							<li>
								<a href="javascript:;">Phản hồi</a>
							</li>
						</ul>
					</nav>
					<nav class="footer-left">
						<ul class="nav">
							<li>
								<a href="javascript:;">
									<span>Bản quyền</span> &copy; 2019 Kobayashi Zero
								</a>
							</li>
							<li class="hidden-md-down">
								<a href="javascript:;">Chính sách</a>
							</li>
							<li class="hidden-md-down">
								<a href="javascript:;">Điều khoản</a>
							</li>
							<li class="hidden-md-down">
								<a href="javascript:;">Hỗ trợ</a>
							</li>
						</ul>
					</nav>
          		</div>
          		<!-- /bottom footer -->
            </div>
            <!-- /main area -->
        </div>
        <!-- /content panel -->
        
		<jsp:include page="footerlibs.jsp"/>
    </div>
</body>
</html>