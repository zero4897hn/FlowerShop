<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
    }
    
    .checked {
        color: orange;
    }
    
    .disable-element {
    	display: none;
    }
</style>
<div class="container mt-3 mb-3" ng-if="sanPham == 'null' || sanPham.daXoa">
    <div class="row justify-content-center align-items-center" style="width: 100%; height: 600px; padding: 0; margin: 0; background-color: #e5e5e5;">
        <h5>Xin lỗi, chúng tôi không tìm thấy <br/> sản phẩm bạn yêu cầu.</h5>
    </div>
</div>
<div style="width: 100%" ng-if="sanPham != 'null' && !sanPham.daXoa">
    <div class="container mt-3 mb-3" style="border: 3px solid #8dcc8d; border-radius: 20px;">
        <div class="row mt-3 mb-3">
            <div class="col-4">
                <img ng-src="/FlowerShop/resources/images/products/{{sanPham.hinhAnh}}" class="img-fluid img-thumbnail">
            </div>
            <div class="col-8 p-0">
                <h3>{{sanPham.tenSanPham}}</h3>
                <div class="form-group row">
                    <label class="col-2 col-form-label">Danh mục:</label>
                    <label class="col-10 col-form-label">{{sanPham.danhMuc.tenDanhMuc}}</label>
                </div>
                <div class="form-group row" ng-if="sanPham.danhSachKieuSanPham.length > 1">
                    <label class="col-2 col-form-label">Chọn kiểu:</label>
                    <div class="col-10">
                        <div class="radio" ng-repeat="kieuSanPham in sanPham.danhSachKieuSanPham">
                            <label class="col-form-label">
                                <input type="radio" ng-model="$parent.radioKieuSanPham" ng-value="kieuSanPham.id" ng-change="capNhatKieuSanPham($index)"> {{kieuSanPham.tenKieu}}
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-2 col-form-label">Giá tiền:</label>
                    <label class="col-10 col-form-label" ng-if="!coKhuyenMai()">{{sanPham.giaTien | currency : "VND " : 0}}</label>
                    <label class="col-10 col-form-label" ng-if="coKhuyenMai()"><strike>{{sanPham.giaTien | currency : "VND " : 0}}</strike> {{getGiaKhuyenMai() | currency : "VND " : 0}}</label>
                </div>
                <div class="form-group row" ng-if="coKhuyenMai()">
                    <label class="col-2 col-form-label">Khuyến mãi:</label>
                    <div class="col-10">
                        <ul style="list-style: none;">
                            <li ng-repeat="khuyenMai in danhSachKhuyenMai"><label class="col-form-label">{{khuyenMai.tenKhuyenMai}} - Giảm {{khuyenMai.phanTramGiam}}% - Giảm tối đa: {{khuyenMai.giaGiamToiDa | currency : "VND " : 0}}</label></li>
                        </ul>
                    </div>
                </div>
                <div class="form-group row" ng-if="soLuongToiDa > 0">
                    <label class="col-2 col-form-label">Số lượng:</label>
                    <div class="col-10">
                        <input type="number" min="1" class="form-control" style="width: fit-content; display: initial;" ng-model="soLuong" max="{{soLuongToiDa}}">
                    </div>
                </div>
                <button class="btn btn-primary" ng-click="themVaoGioHang()" ng-if="soLuongToiDa > 0"><i class="fa fa-cart-plus"></i> Thêm vào giỏ hàng</button>
            </div>
        </div>
    </div>

    <div class="container mt-3 mb-3" style="border: 3px solid #8dcc8d; border-radius: 20px;">
        <div id="title-of-tab" style="border-bottom: 1px solid green;">
            <h4>Mô tả</h4>
        </div>
        <div class="row">
            <div class="col-12">
                <p style="text-align: justify; text-justify: inter-word;">
                    {{sanPham.moTa}}
                </p>
            </div>
        </div>
    </div>

    <div class="container mt-3 mb-3" style="border: 3px solid #8dcc8d; border-radius: 20px;">
        <div id="title-of-tab" style="border-bottom: 1px solid green;">
            <h4>Đánh giá</h4>
        </div>
        <div id="all-of-feedback" class="p-3" ng-if="sanPham.danhSachDanhGia.length > 0">
            <div class="row mt-2 mb-2" ng-repeat="danhGia in sanPham.danhSachDanhGia" ng-init="initiateDanhGia(danhGia)">
                <div class="col-12">
                    <div class="border">
                        <div class="row">
                            <div class="col-2">
                                <img ng-src="/FlowerShop/resources/images/avatars/{{danhGia.nhanVien.avatar}}" class="img-fluid img-thumbnail" onError="this.onerror=null;this.src='/FlowerShop/resources/images/avatars/anonymous_avatar.png';">
                            </div>
                            <div class="col-10">
                                <div class="row">
                                    <div class="col-12">
                                        <div>
                                            <h5 style="margin-top: 6px;"><b>{{danhGia.nhanVien.tenNhanVien}}</b>: {{danhGia.tieuDe}}</h5>
                                            <div style="width: fit-content; float: right; top: 6px; position: absolute; right: 25px; padding: 0; margin: 0;">
                                                <span ng-repeat="soSao in soSaoToiDa" ng-class="(soSao > danhGia.soSao)? 'fa fa-star' : 'fa fa-star checked'"></span>
                                            </div>
                                        </div>
                                        <hr style="margin: 0; padding: 0;">
                                        <div style="margin-top: 6px;">
                                            <p style="text-align: justify; text-justify: inter-word;">
                                                {{danhGia.noiDung}}
                                            </p>
                                            <a href="javascript:;" style="text-decoration: none;" ng-click="capNhatAnHienTraLoi(danhGia)">{{danhGia.anHienTraLoi}} ({{danhGia.danhSachTraLoiDanhGia.length}})</a>
                                            <span class="float-right">Đánh giá lúc {{danhGia.thoiGianDanhGia}}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" ng-if="danhGia.hienTraLoi">
                                    <div class="col-12 mt-3" style="background: #efeeee; margin-left: -14px;" ng-repeat="traLoiDanhGia in danhGia.danhSachTraLoiDanhGia">
                                        <div class="row">
                                            <div class="col-2">
                                                <a href="javascript:;" ng-click="xemThongTinNhanVien(traLoiDanhGia.nhanVien)">
                                                    <img ng-src="/FlowerShop/resources/images/avatars/{{traLoiDanhGia.nhanVien.avatar}}" class="img-fluid img-thumbnail" onError="this.onerror=null;this.src='/FlowerShop/resources/images/avatars/anonymous_avatar.png';">
                                                </a>
                                            </div>
                                            <div class="col-10">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div style="width: 100%">
                                                            <h5 style="margin-top: 6px;"><b>{{traLoiDanhGia.nhanVien.tenNhanVien}}</b></h5>
                                                        </div>
                                                        <hr style="margin: 0; padding: 0;">
                                                        <div style="margin-top: 6px; width: 100%;">
                                                            <p style="text-align: justify; text-justify: inter-word;">
                                                                {{traLoiDanhGia.noiDung}}
                                                            </p>
                                                            <span style="float: right;">Trả lời lúc {{traLoiDanhGia.thoiGianTraLoi}}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12" style="margin-top: 10px;">
                                        <textarea class="form-control" rows="2" placeholder="Trả lời đánh giá" ng-model="danhGia.noiDungTraLoi"></textarea>
                                        <button class="btn btn-primary" style="float: right;" ng-click="traLoi(danhGia)">Trả lời</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row justify-content-center align-items-center" style="width: 100%; height: 200px; padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="sanPham.danhSachDanhGia.length <= 0">
            <h5>Hiện tại chưa có đánh giá gì.</h5>
        </div>
        <div class="row" ng-if="$root.idNhanVien != undefined">
            <div class="col-12">
                <form name="formDanhGia">
                    <fieldset class="form-group">
                        <label for="title-of-feedback">Tiêu đề:</label>
                        <input type="text" class="form-control" placeholder="Nhập tiêu đề" ng-model="danhGiaMoi.tieuDe" ng-required="true">
                    </fieldset>
                    <fieldset class="form-group">
                        <label for="content-of-feedback">Nội dung:</label>
                        <textarea class="form-control" rows="3" placeholder="Nhập Nội dung" ng-model="danhGiaMoi.noiDung" ng-required="true"></textarea>
                    </fieldset>
                    <div style="height: 51px;">
                        <div id="star-rating" style="position: absolute;">
                            Bình chọn:
                            <span ng-class="(danhGiaMoi.soSao >= 1)? 'fa fa-star checked' : 'fa fa-star'" ng-click="doiSoSao(1)"></span>
                            <span ng-class="(danhGiaMoi.soSao >= 2)? 'fa fa-star checked' : 'fa fa-star'" ng-click="doiSoSao(2)"></span>
                            <span ng-class="(danhGiaMoi.soSao >= 3)? 'fa fa-star checked' : 'fa fa-star'" ng-click="doiSoSao(3)"></span>
                            <span ng-class="(danhGiaMoi.soSao >= 4)? 'fa fa-star checked' : 'fa fa-star'" ng-click="doiSoSao(4)"></span>
                            <span ng-class="(danhGiaMoi.soSao >= 5)? 'fa fa-star checked' : 'fa fa-star'" ng-click="doiSoSao(5)"></span>
                            <span class="ml-2">{{danhGiaMoi.soSao}} sao</span>
                        </div>
                        <button style="float: right;" class="btn btn-primary" ng-click="themDanhGia()" ng-disabled="!formDanhGia.$valid">Đánh giá</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="row" ng-if="$root.idNhanVien == undefined">
            <div class="col-12">
                <h6>Vui lòng <a style="text-decoration: none;" href="javascript:;" ng-click="dangNhap()">đăng nhập</a> để đánh giá sản phẩm.</h6>
            </div>        
        </div>
    </div>
</div>