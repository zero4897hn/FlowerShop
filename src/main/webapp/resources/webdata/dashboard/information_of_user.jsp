<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-sm-12" ng-if="nhanVien == 'null'">
    <div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 300px 0px;">Chúng tôi không tìm thấy<br/>người dùng bạn yêu cầu.</h5>
        </div>
    </div>
</div>
<div class="col-sm-10 push-sm-1" ng-if="nhanVien != 'null'">
	<a href="javascript:;" ng-click="thayAvatar()"><img ng-src="/FlowerShop/resources/images/avatars/{{nhanVien.avatar}}" class="img-fluid img-thumbnail" onError="this.onerror=null;this.src='/FlowerShop/resources/images/avatars/anonymous_avatar.png';" style="width: 100px; height: 100px; margin-bottom: 10px;"></a>
    <h5 class="card-text" style="display: inline-block; margin-left: 10px;">{{nhanVien.tenNhanVien}}</h5>
    <div class="card">
        <div class="card-header">
            Thông tin cơ bản
            <a href="#" ng-click="startEdit()" ng-show="!enabledEdit" style="float: right;" ng-if="$root.nhanVienHienTai.chucVu.id > 2 || $root.nhanVienHienTai.id == nhanVien.id"><i class="material-icons" aria-hidden="true">mode_edit</i></a>
            <button href="#" ng-click="endEdit()" ng-disabled="!editUserForm.$valid" ng-show="enabledEdit" style="float: right; background: none; border: none;"><i class="material-icons" aria-hidden="true">done</i></button>
        </div>
        <div class="card-block">
            <table id="user" class="table table-bordered align-middle" ng-show="!enabledEdit">
                <tbody>
                    <tr>
                        <td class="card-text" style="width: 35%;">Tên người dùng:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.tenNhanVien}}</td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Loại tài khoản:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.chucVu.tenChucVu}}</td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Giới tính:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.gioiTinh}}</td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Ngày sinh:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.ngaySinh | date: 'dd/MM/yyyy'}}</td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Số chứng minh nhân dân:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.chungMinhNhanDan}}</td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Số điện thoại:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.soDienThoai}}</td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Địa chỉ:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.diaChi}}</td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Email:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.email}}</td>
                    </tr>
                </tbody>
            </table>
            <form name="editUserForm">
                <table id="user" class="table table-bordered align-middle" ng-show="enabledEdit">
                    <tbody>
                        <tr>
                            <td class="card-text" style="width: 35%;">Tên người dùng:</td>
                            <td class="card-text" style="width: 65%;">
                                <input type="text" class="form-control" ng-model="nhanVien.tenNhanVien" ng-required="true">
                            </td>
                        </tr>
                        <tr>
                            <td class="card-text" style="width: 35%;">Loại tài khoản:</td>
                            <td class="card-text" style="width: 65%;">
                                <select class="form-control" ng-if="$root.nhanVienHienTai.chucVu.id > 2" ng-model="nhanVien.chucVu" ng-options="item.tenChucVu for item in listChucVu track by item.id">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="card-text" style="width: 35%;">Giới tính:</td>
                            <td class="card-text" style="width: 65%;">
                                <label>
                                    <input type="radio" ng-model="nhanVien.gioiTinh" value="Nam" ng-checked="nhanVien.gioiTinh == 'Nam'"/> Nam
                                </label>
                                <label>
                                    <input type="radio" ng-model="nhanVien.gioiTinh" value="Nữ" ng-checked="nhanVien.gioiTinh == 'Nữ'"/> Nữ
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="card-text" style="width: 35%;">Ngày sinh:</td>
                            <td class="card-text" style="width: 65%;">
                                <input type="date" class="form-control" ng-model="nhanVien.ngaySinh">
                            </td>
                        </tr>
                        <tr>
                            <td class="card-text" style="width: 35%;">Số chứng minh nhân dân:</td>
                            <td class="card-text" style="width: 65%;">
                                <input type="text" class="form-control" ng-model="nhanVien.chungMinhNhanDan" ng-maxlength="15">
                            </td>
                        </tr>
                        <tr>
                            <td class="card-text" style="width: 35%;">Số điện thoại:</td>
                            <td class="card-text" style="width: 65%;">
                                <input type="text" class="form-control" ng-model="nhanVien.soDienThoai" ng-maxlength="15" ng-required="true">
                            </td>
                        </tr>
                        <tr>
                            <td class="card-text" style="width: 35%;">Địa chỉ:</td>
                            <td class="card-text" style="width: 65%;">
                                <input type="text" class="form-control" ng-model="nhanVien.diaChi" ng-maxlength="255" ng-required="true">
                            </td>
                        </tr>
                        <tr>
                            <td class="card-text" style="width: 35%;">Email:</td>
                            <td class="card-text" style="width: 65%;">
                                <input type="email" class="form-control" ng-model="nhanVien.email" ng-maxlength="50" ng-required="true">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <div class="card">
        <div class="card-header">
            Thông tin khác
        </div>
        <div class="card-block">
            <table id="user" class="table table-bordered align-middle">
                <tbody>
                    <tr>
                        <td class="card-text" style="width: 35%;">Mật khẩu:</td>
                        <td class="card-text" style="width: 65%;"><button style="background: none; border: none; font-size: 0.8125rem; padding: 0; margin: 0;" ng-click="changePassword()" ng-if="$root.nhanVienHienTai.chucVu.id > 2 || $root.nhanVienHienTai.id == nhanVien.id">Đổi mật khẩu</button></td>
                    </tr>
                    <tr>
                        <td class="card-text" style="width: 35%;">Ngày tạo:</td>
                        <td class="card-text" style="width: 65%;">{{nhanVien.ngayThem}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <button class="btn btn-danger" ng-click="xoaTaiKhoan()" ng-if="$root.nhanVienHienTai.chucVu.id > 2">Xóa tài khoản</button>
</div>