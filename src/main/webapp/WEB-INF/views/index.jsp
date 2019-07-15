<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <base href="/FlowerShop/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <jsp:include page="headerlibs.jsp"/>
    <title>Trang chủ Flower Shop</title>
</head>
<style>
    .carousel-inner img {
        width: 100%;
        height: 100%;
    }
    .sticky {
        position: fixed;
        top: 0;
        width: 100%;
    }
    #social-network-list {
        display: inline;
        padding: 0;
    }
    
    #social-network-list li {
        float: none;
        list-style: none;
        display: inline;
        text-decoration: none;
    }
    
    #social-network-list a {
        display: inline-block;
        border: 1px solid blue;
        width: 40px;
        height: 40px;
        line-height: 37px;
        border-radius: 55%;
        transition: 1s;
    }
    
    #social-network-list a:hover {
        background: blue;
        color: white;
    }

    .navbar-collapse.show.collapse {
        display: contents;
    }
</style>
<body ng-app="myApp" ng-controller="MyController">
    <!-- Ảnh logo -->
    <div class="container mt-1 mb-1">
        <a href=""><img src='<c:url value="/resources/images/logo_flowers.png"/>'></a>
    </div>
    <!-- End Ảnh logo -->

    <!-- Thanh menu -->
    <nav id="menu-bar" class="navbar navbar-expand-lg navbar-light bg-light" role="navigation" style="z-index: 999;">
        <div class="container">
            <div class="collapse navbar-collapse" uib-collapse="isNavCollapsed">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="trang_chu">Trang chủ<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Danh mục
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="javascript:;" ng-repeat="danhMuc in danhSachDanhMuc" ng-click="xemDanhSachSanPham(danhMuc[0])">{{danhMuc[1]}}</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="javascript:;" ng-click="xemDanhSachSanPham(0)">Tất cả các sản phẩm</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="thong_tin">Thông tin</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="lien_he">Liên hệ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="javascript:;" ng-click="timHoaDon()">Tìm hóa đơn</a>
                    </li>
                </ul>
            </div>

            <div style="display: flex; flex-direction: row;">
                <div class="mr-1 my-2 my-lg-0" style="flex: 0 1 auto;">
                    <div class="nav-item dropdown">
                        <div ng-if="$root.idNhanVien != undefined">
                            <a class="nav-link dropdown-toggle" href="javascript:;" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-user"></i> {{nhanVien.tenNhanVien}}
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown1">
                                <a class="dropdown-item" href="thong_tin_nguoi_dung">Thông tin</a>
                                <a class="dropdown-item" href="don_mua">Đơn mua</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="javascript:;" ng-click="dangXuat()">Đăng xuất</a>
                            </div>
                        </div>
                        <a ng-if="$root.idNhanVien == undefined" class="nav-link" href="javascript:;" ng-click="dangNhap()">Đăng nhập</a>
                    </div>
                </div>

                <div class="mr-1 my-2 my-lg-0" style="flex: 0 1 auto;">
                    <button class="navbar-toggler" type="button" ng-click="isNavCollapsed = !isNavCollapsed" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>

                <div class="mr-1 my-2 my-lg-0" style="flex: 0 1 auto;">
                    <a class="btn btn-outline-info" href="gio_hang" title="Giỏ hàng" style="position: relative;">
                        <i class="fa fa-shopping-cart"></i>
                        <span class="badge badge-primary badge-pill" style="position: absolute; margin: -5px 10px 12px 4px;" ng-if="$root.soLuongSanPhamTrongGioHang > 0">{{$root.soLuongSanPhamTrongGioHang}}</span>
                    </a>
                </div>

                <div class="my-2 my-lg-0" style="flex: 1 1 auto;">
                    <div style="display: flex; flex-direction: row;">
                        <input class="form-control mr-1" style="flex: 1 1 auto; height: fit-content;" type="search" placeholder="Tìm kiếm" aria-label="Tìm kiếm" ng-model="sanPhamCanTim">
                        <button class="btn btn-outline-primary" style="flex: 0 1 auto;" title="Tìm kiếm" type="submit" ng-click="timKiemSanPham(sanPhamCanTim)"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    <!-- End Thanh menu -->

    <!-- Thanh router -->
    <div style="width: 100%;" ng-view>
    </div>
    <!-- End Thanh router -->
    
    <!-- Footer -->
    <div class="footer">
        <div class="container pb-3">
            <div class="row">
                <div class="col-lg-3 text-center">
                    <h4>{{chanTrang.benTrai.tieuDe}}</h4>
                    <ul style="list-style: none; padding: 0; margin: 0;">
                        <li ng-repeat="noiDungChanTrang in chanTrang.benTrai.noiDung">{{noiDungChanTrang}}</li>
                    </ul>
                </div>
                <div class="col-lg-4 text-center">
                    <h4>Tham quan chúng tôi</h4>
                    <ul id="social-network-list">
                        <li ng-repeat="xaHoi in chanTrang.xaHoi"><a href="{{xaHoi.duongDan}}"><i class="fa fa-{{xaHoi.kiHieu}}"></i></a></li>
                    </ul>
                </div>
                <div class="col-lg-5 text-center">
                    <h4>{{chanTrang.benPhai.tieuDe}}</h4>
                    <ul style="list-style: none; padding: 0; margin: 0;">
                        <li ng-repeat="noiDungChanTrang in chanTrang.benPhai.noiDung">{{noiDungChanTrang}}</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row pt-1 pb-1">
                <div class="col-12 text-center">
                    Copyright &copy; by Kobayashi Zero. All rights reserved.
                </div>
            </div>
        </div>
    </div>
    <!-- End Footer -->

    <script type="text/javascript">
        window.onscroll = function () {
            var header = document.getElementById("menu-bar");
            if (window.pageYOffset > header.offsetTop) {
                header.classList.add('sticky');
                header.nextElementSibling.style.marginTop = header.scrollHeight;
            } else {
                header.classList.remove('sticky');
                header.nextElementSibling.style.marginTop = 0;
            }
        }
    </script>

    <jsp:include page="footerlibs.jsp"/>
</body>
</html>