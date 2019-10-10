<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<div style="height: fit-content;">
    <div uib-carousel active="active" interval="myInterval" no-wrap="noWrapSlides">
        <div uib-slide ng-repeat="slide in slides track by slide.id" index="slide.id">
            <img ng-src="{{slide.image}}" style="margin:auto; width: 100%">
            <div class="carousel-caption">
                <h4>{{slide.title}}</h4>
                <p>{{slide.text}}</p>
            </div>
        </div>
    </div>
</div>

<div class="container mt-5 mb-5">
    <div class="row">
        <div class="col-lg-4 text-center">
            <h1><i class="fa fa-{{noiDung[0].kiHieu}}"></i></h1>
            <h3>{{noiDung[0].tieuDe}}</h3>
            <p ng-bind-html="noiDung[0].noiDung"></p>
        </div>
        <div class="col-lg-4 text-center">
            <h1><i class="fa fa-{{noiDung[1].kiHieu}}"></i></h1>
            <h3>{{noiDung[1].tieuDe}}</h3>
            <p ng-bind-html="noiDung[1].noiDung"></p>
        </div>
        <div class="col-lg-4 text-center">
            <h1><i class="fa fa-{{noiDung[2].kiHieu}}"></i></h1>
            <h3>{{noiDung[2].tieuDe}}</h3>
            <p ng-bind-html="noiDung[2].noiDung"></p>
        </div>
    </div>
</div>

<hr>

<div class="container">
    <div class="row">
        <div class="col-12 text-center">
            <h3>Các sản phẩm nổi bật</h3>
        </div>
    </div>
    
    <div class="row" ng-if="listSanPham.length > 0">
        <div class="col-6 col-lg-3" ng-repeat="sanPham in listSanPham" ng-init="checkConHang(sanPham)">
            <div class="row">
                <div class="col-12">
                    <div class="flower-product-image">
                        <img src="/FlowerShop/resources/images/sold_out.png" width="100%" style="position: absolute; top: 25%;" ng-if="sanPham.isSoldOut">
                        <img ng-src="/FlowerShop/resources/images/products/{{sanPham.hinhAnh}}" width="100%" class="img-fluid square-image">
                        <div class="menu-of-product">
                            <a class="btn btn-outline-warning" href="javascript:;" ng-click="themVaoGioHang(sanPham)" ng-if="!sanPham.isSoldOut">Thêm vào giỏ hàng</a>
                            <a class="btn btn-outline-primary" href="chi_tiet_san_pham/{{sanPham.id}}">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 text-center">
                    <h4 style="height: 60px; overflow: hidden;" title="{{sanPham.tenSanPham}}">{{sanPham.tenSanPham}}</h4>
                    <h5 style="height: 45px; overflow: hidden;" ng-switch on="sanPham.danhSachKieuSanPham.length">
                        <div ng-switch-when="1">{{getGiaKhuyenMai(sanPham.danhSachKieuSanPham[0]) | currency : "VND " : 0}}</div>
                        <div ng-switch-default ng-init="setMinAndMax(sanPham)">
                            {{sanPham.giaThapNhat | currency : "VND " : 0}}
                            ~
                            {{sanPham.giaCaoNhat | currency : "VND " : 0}}
                        </div>
                    </h5>
                </div>
            </div>
        </div>
    </div>
    <div class="row justify-content-center align-items-center" style="width: 100%; height: 500px; padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listSanPham.length <= 0">
        Hiện tại chưa có sản phẩm nào hot.
    </div>
</div>

<hr>

<div class="container-fluid" render-iframely ng-bind-html="nhungBanDo">
    
</div>

<hr>