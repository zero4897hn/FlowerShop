<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    #list-category-side-bar a {
        display: block;
        background-color: inherit;
        color: black;
        padding: 22px 16px;
        width: 100%;
        border: none;
        outline: none;
        text-align: left;
        cursor: pointer;
        transition: 0.3s;
        font-size: 17px;
    }

    #list-category-side-bar a:hover {
        background-color: #ddd;
        text-decoration: none;
    }
    
    #list-category-side-bar a.activated-category {
    	background-color: #ccc;
    }

    #list-category-side-bar {
        background-color: #f1f1f1; 
        padding: 0;
    }

    @media (max-width: 576px) {
        #list-category-side-bar {
            display: none !important;
        }
    }
</style>

<div class="container mt-4 mb-4 p-0" ng-if="soTrang > 1">
    <ul class="pagination">
        <li class="page-item">
            <button ng-click="trangTruoc()" class="page-link" ng-disabled="trangHienTai == 1"><i class="fa fa-arrow-left"></i> Trang trước</button>
        </li>
        <li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemSanPhamTrang(x)"><a href="javascript:;" class="page-link">{{x}}</a></li>
        <!-- <li class="page-item active"><a class="page-link" href="#">2</a></li> -->
        <li class="page-item">
            <button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link">Trang sau <i class="fa fa-arrow-right"></i></button>
        </li>
    </ul>
</div>

<div class="container mt-4 mb-4">
    <div class="row">
        <div class="col-3" id="list-category-side-bar">
            <a ng-repeat="danhMuc in listDanhMuc" ng-class="(idDanhMucHienTai == danhMuc.id)? 'activated-category' : ''" href="javascript:;" ng-click="xemSanPhamTheoDanhMuc(danhMuc.id)">{{danhMuc.tenDanhMuc}}</a>
            <hr>
            <a ng-class="(idDanhMucHienTai == 0)? 'activated-category':''" href="javascript:;" ng-click="xemTatCaSanPham()">Tất cả sản phẩm</a>
            <a ng-class="(idDanhMucHienTai == -1)? 'activated-category':''" href="javascript:;" ng-click="timKiemSanPham()">Tìm kiếm</a> 
        </div>
        <div class="col-sm-9">
			<div class="row" ng-if="listSanPham.length > 0">
        		<div class="col-6 col-lg-4 img-thumbnail" ng-repeat="sanPham in listSanPhamCon">
                    <div class="row">
	                    <div class="col-12">
	                        <div class="flower-product-image">
	                            <img ng-src="/FlowerShop/resources/images/products/{{sanPham.hinhAnh}}" width="100%" class="img-fluid">
	                            <div class="menu-of-product">
	                                <a class="btn btn-outline-warning" href="javascript:;" ng-click="themVaoGioHang(sanPham)">Thêm vào giỏ hàng</a>
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
			<div class="row justify-content-center align-items-center" style="width: 100%; height: 100%; padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listSanPham.length <= 0">
				Hiện tại chưa có sản phẩm cho danh mục này.
			</div>
        </div>
    </div>
</div>