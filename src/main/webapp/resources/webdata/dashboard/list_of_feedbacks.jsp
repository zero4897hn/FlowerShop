<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-sm-9">
	<div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listPhanHoiCon.length <= 0">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 160px 0px;">Danh sách phản hồi trống</h5>
        </div>
    </div>
	<div class="row" ng-if="listPhanHoiCon.length > 0">
		<div class="col-sm-12">
			<ul class="pagination" style="width: 100%; margin: 10px 0; padding: 0;" ng-hide="soTrang == 1">
				<li class="page-item">
					<button ng-click="trangTruoc()" ng-disabled="trangHienTai == 1" class="page-link" aria-label="Previous">
						<span aria-hidden="true">«</span>
						<span class="sr-only">Previous</span>
					</button>
				</li>
				<li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemPhanHoiTrang(x)"><a class="page-link" href="#">{{x}}</a></li>
				<li class="page-item">
					<button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span>
						<span class="sr-only">Next</span>
					</button>
				</li>
			</ul>
		</div>
	</div>
	<div class="row" ng-if="listPhanHoiCon.length > 0">
		<div class="col-sm-12">
			<table class="table table-striped">
		        <thead>
		            <tr>
		                <th style="width: 5%;">#</th>
		                <th style="width: 30%;">Tiêu đề phản hồi</th>
		                <th style="width: 25%;">Email</th>
		                <th style="width: 20%;">Số điện thoại</th>
		                <th style="width: 20%;">Thời gian phản hồi</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr ng-repeat="phanHoi in listPhanHoiCon">
		                <th class="align-middle" scope="row">{{$index + 1 + ((trangHienTai - 1) * soPhanHoiMoiTrang)}}</th>
		                <td class="align-middle"><a href="javascript:;" ng-click="xemPhanHoi(phanHoi)">{{phanHoi.tieuDe}}</a></td>
		                <td class="align-middle">{{phanHoi.email}}</td>
		                <td class="align-middle">{{phanHoi.soDienThoai}}</td>
		                <td class="align-middle">{{phanHoi.thoiGianPhanHoi}}</td>
		            </tr>
		        </tbody>
		    </table>
		</div>
	</div>
</div>
<div class="col-sm-3">
	<fieldset>
		<label>Số phản hồi mỗi trang:</label>
		<input type="number" min="5" class="form-control" ng-model="soPhanHoiMoiTrang" ng-change="capNhatSoPhanHoiMoiTrang()">
	</fieldset>
	<fieldset>
		<label>Đến trang:</label>
		<input type="number" min="1" max="{{soTrang}}" class="form-control" ng-model="trangHienTai" ng-change="denTrangThu()">
	</fieldset>
	<fieldset>
		<label>Tìm phản hồi:</label>
		<input type="text" minlength="0" maxlength="50" class="form-control" ng-model="phanHoiCanTim">
		<button class="btn btn-primary" style="float: right;" ng-click="timPhanHoi()"><i class="material-icons" aria-hidden="true">search</i></button>
	</fieldset>
</div>