<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-xs-12" ng-if="$root.nhanVienHienTai.chucVu.id < 3">
    <div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 300px 0px;">Bạn không thể quản lý người dùng<br/>khi bạn là nhân viên</h5>
        </div>
    </div>
</div>
<div class="col-md-9" ng-if="$root.nhanVienHienTai.chucVu.id > 2">
    <div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listTaiKhoanCon.length <= 0">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 160px 0px;">Danh sách tài khoản trống</h5>
        </div>
    </div>
    <div class="row" ng-if="listTaiKhoanCon.length > 0">
        <div class="col-sm-12" style="height: 100%">
            <ul class="pagination" style="width: 100%; margin: 10px 0; padding: 0;" ng-hide="soTrang < 2">
                <li class="page-item">
                    <button ng-click="trangTruoc()" ng-disabled="trangHienTai == 1" class="page-link" aria-label="Previous">
                        <span aria-hidden="true">«</span>
                        <span class="sr-only">Previous</span>
                    </button>
                </li>
                <li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemTaiKhoanTrang(x)"><a class="page-link" href="#">{{x}}</a></li>
                <li class="page-item">
                    <button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link" href="#" aria-label="Next">
                        <span aria-hidden="true">»</span>
                        <span class="sr-only">Next</span>
                    </button>
                </li>
            </ul>
        </div>
    </div>
    <div class="row" ng-if="listTaiKhoanCon.length > 0">
        <div class="col-sm-12">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th style="width: 5%;">#</th>
                        <th style="width: 20%;">Tên nhân viên</th>
                        <th style="width: 20%;">Tên tài khoản</th>
                        <th style="width: 20%;">Chức vụ</th>
                        <th style="width: 20%;">Ngày tạo</th>
                        <th style="width: 15%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="taiKhoan in listTaiKhoanCon">
                        <td class="align-middle" scope="row">{{$index + 1 + ((trangHienTai - 1) * soTaiKhoanMoiTrang)}}</td>
                        <td class="align-middle"><a href="user_info/{{taiKhoan.nhanVien.id}}">{{taiKhoan.nhanVien.tenNhanVien}}</a></td>
                        <td class="align-middle"><a href="user_info/{{taiKhoan.nhanVien.id}}">{{taiKhoan.tenDangNhap}}</a></td>
                        <td class="align-middle">{{taiKhoan.nhanVien.chucVu.tenChucVu}}</td>
                        <td class="align-middle">{{taiKhoan.nhanVien.ngayThem}}</td>
                        <td class="align-middle"><button ng-click="removeNhanVien(taiKhoan.nhanVien)" style="border: 1px solid gray; background: none; border-radius: 5px;"><i class="material-icons" aria-hidden="true">delete</i></button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div class="col-md-3" ng-show="$root.nhanVienHienTai.chucVu.id > 2">
    <fieldset class="form-group">
        <label>Số tài khoản mỗi trang:</label>
        <input type="number" min="5" class="form-control" ng-model="soTaiKhoanMoiTrang" ng-change="capNhatSoTaiKhoanMoiTrang()">
    </fieldset>
    <fieldset class="form-group" style="padding: 0; margin: 10px 0;">
        <label>Đi đến trang:</label>
        <input type="number" min="1" max="{{soTrang}}" class="form-control" ng-model="trangHienTai" ng-change="denTrangThu()">
    </fieldset>
    <div class="radio row">
        <label class="col-xs-5 col-form-label">Lọc tài khoản:</label>
        <div class="col-xs-5">
            <div class="row">
                <label class="col-form-label col-md-12 col-sm-6">
                    <input type="radio" ng-model="loaiTaiKhoan" checked="true" ng-change="locDanhSachTaiKhoan()">
                    Tất cả
                </label>
                <label class="col-form-label col-md-12 col-sm-6">
                    <input type="radio" ng-model="loaiTaiKhoan" ng-value="1" ng-change="locDanhSachTaiKhoan()">
                    Khách hàng
                </label>
                <label class="col-form-label col-md-12 col-sm-6">
                    <input type="radio" ng-model="loaiTaiKhoan" ng-value="2" ng-change="locDanhSachTaiKhoan()">
                    Nhân viên
                </label>
            </div>
        </div>
    </div>
    <fieldset class="form-group">
        <label class="col-xs-12 col-form-label" style="padding-left: 0;">Tìm tài khoản:</label>
        <input type="text" minlength="0" maxlength="50" class="form-control" ng-model="taiKhoanCanTim">
        <button class="btn btn-primary" style="float: right;"><i class="material-icons" aria-hidden="true" ng-click="timTaiKhoan()">search</i></button>
    </fieldset>
    <fieldset class="form-group">
        <button class="btn btn-toolbar" style="margin: auto;" ng-click="thongKeDanhSachNguoiDung()">Thống kê người dùng</button>
    </fieldset>
</div>