<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="col-sm-9">
	<div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listKhuyenMaiCon.length <= 0">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 160px 0px;">Danh sách khuyến mãi trống</h5>
        </div>
    </div>
	<div class="row" ng-if="listKhuyenMaiCon.length > 0">
		<div class="col-sm-12">
			<ul class="pagination" style="width: 100%; margin: 10px 0; padding: 0;" ng-hide="soTrang == 1">
				<li class="page-item">
					<button ng-click="trangTruoc()" ng-disabled="trangHienTai == 1" class="page-link" aria-label="Previous">
						<span aria-hidden="true">«</span>
						<span class="sr-only">Previous</span>
					</button>
				</li>
				<li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemKhuyenMaiTrang(x)"><a class="page-link" href="#">{{x}}</a></li>
				<li class="page-item">
					<button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span>
						<span class="sr-only">Next</span>
					</button>
				</li>
			</ul>
		</div>
	</div>
	<div class="row" ng-if="listKhuyenMaiCon.length > 0">
		<div class="col-sm-12">
			<table class="table table-striped">
		        <thead>
		            <tr>
		                <th style="width: 5%;">#</th>
		                <th style="width: 30%;">Tên khuyến mãi</th>
		                <th style="width: 25%;">Bắt đầu</th>
		                <th style="width: 25%;">Kết thúc</th>
		                <th style="width: 15%;">Thao tác</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr ng-repeat="khuyenMai in listKhuyenMaiCon" ng-init="longToDate(khuyenMai)">
		                <th class="align-middle" scope="row" style="width: 5%;">{{$index + 1 + ((trangHienTai - 1) * soKhuyenMaiMoiTrang)}}</th>
		                <td class="align-middle" style="width: 30%;"><a href="event_info/{{khuyenMai.id}}">{{khuyenMai.tenKhuyenMai}}</a></td>
		                <td class="align-middle" style="width: 25%;">{{khuyenMai.thoiGianBatDau | date: 'dd/MM/yyyy HH:mm'}}</td>
		                <td class="align-middle" style="width: 25%;">{{khuyenMai.thoiGianKetThuc | date: 'dd/MM/yyyy HH:mm'}}</td>
		                <td class="align-middle" style="width: 15%;">
		                	<button style="border: 1px solid gray; background: none; border-radius: 5px;" ng-click="suaKhuyenMai(khuyenMai)" ng-if="!khuyenMai.daXoa"><i class="material-icons" aria-hidden="true">edit</i></button>
		                	<button style="border: 1px solid gray; background: none; border-radius: 5px;" ng-click="xoaKhuyenMai(khuyenMai)" ng-if="!khuyenMai.daXoa"><i class="material-icons" aria-hidden="true">delete</i></button>
		                	<div ng-if="khuyenMai.daXoa">Đã xóa</div>
						</td>
		            </tr>
		        </tbody>
		    </table>
		</div>
	</div>
</div>
<div class="col-sm-3">
	<fieldset class="form-group">
		<label>Số khuyến mãi mỗi trang:</label>
		<input type="number" min="5" class="form-control" ng-model="soKhuyenMaiMoiTrang" ng-change="capNhatSoKhuyenMaiMoiTrang()">
	</fieldset>
	<fieldset class="form-group">
		<label>Đến trang:</label>
		<input type="number" min="1" max="{{soTrang}}" class="form-control" ng-model="trangHienTai" ng-change="denTrangThu()">
	</fieldset>
	<fieldset class="form-group">
		<label class="col-xs-5 col-form-label" style="padding-left: 0;">Lọc sự kiện:</label>
        <div class="col-xs-5">
            <div class="row">
                <label class="col-form-label col-md-12 col-sm-6">
                    <input type="radio" ng-model="loaiSuKien" value="all" ng-change="locDanhSachKhuyenMai()">
                    Tất cả
                </label>
                <label class="col-form-label col-md-12 col-sm-6">
                    <input type="radio" ng-model="loaiSuKien" value="past" ng-change="locDanhSachKhuyenMai()">
                    Trước đây
                </label>
                <label class="col-form-label col-md-12 col-sm-6">
                    <input type="radio" ng-model="loaiSuKien" value="present" ng-change="locDanhSachKhuyenMai()">
                    Hiện tại
                </label>
                <label class="col-form-label col-md-12 col-sm-6">
                    <input type="radio" ng-model="loaiSuKien" value="future" ng-change="locDanhSachKhuyenMai()">
                    Sau này
                </label>
            </div>
        </div>
	</fieldset>
	<fieldset class="form-group">
		<label>Tìm tên khuyến mãi:</label>
		<input type="text" minlength="0" maxlength="50" class="form-control" ng-model="tenKhuyenMaiCanTim">
		<button class="btn btn-primary" style="float: right;" ng-click="timKhuyenMai()"><i class="material-icons" aria-hidden="true">search</i></button>
	</fieldset>
	<fieldset class="form-group" ng-if="$root.nhanVienHienTai.chucVu.id > 2" ng-if="$root.nhanVienHienTai.chucVu.id > 2">
		<label class="custom-control custom-checkbox m-b-1">
            <input type="checkbox" ng-model="boQuaDaXoa" class="custom-control-input" ng-change="capNhatBoQuaDaXoa(boQuaDaXoa)">
            <span class="custom-control-indicator"></span>
            <span class="custom-control-description">Bỏ qua những khuyến mãi đã xóa</span>
        </label>
	</fieldset>
</div>