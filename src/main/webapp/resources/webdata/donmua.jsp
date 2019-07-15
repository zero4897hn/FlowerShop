<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<div class="container mt-3" ng-if="nhanVien.danhSachHoaDon.length > 0">
	<div class="row">
		<div class="col-12">
			<h4 class="text-center">Danh sách đơn mua</h4>
		</div>
	</div>
</div>
<div class="container mt-3" style="min-height: 400px;" ng-if="nhanVien.danhSachHoaDon.length > 0">
	<div class="row">
		<div class="col-12">
			<table class="table table-striped">
		        <thead>
		            <tr>
		                <th style="width: 5%;">#</th>
		                <th style="width: 30%;">Mã hóa đơn</th>
		                <th style="width: 25%;">Thời gian đặt hàng</th>
		                <th style="width: 20%;">Tổng tiền</th>
		                <th style="width: 20%;">Tình trạng</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr ng-repeat="hoaDon in nhanVien.danhSachHoaDon" ng-init="intiateHoaDon(hoaDon)">
		                <th class="align-middle" scope="row" style="width: 5%;">{{$index + 1}}</th>
		                <td class="align-middle" style="width: 30%;"><a href="chi_tiet_don_mua/{{hoaDon.id}}" style="text-decoration: none;">{{hoaDon.maHoaDon}}</a></td>
		                <td class="align-middle" style="width: 25%;">{{hoaDon.ngayLapDate | date: 'dd/MM/yyyy HH:mm:ss'}}</td>
		                <td class="align-middle" style="width: 20%;">{{tongTien(hoaDon) | currency : "VND " : 0}}</td>
		                <td class="align-middle" style="width: 20%;">{{tinhTrangHoaDon[hoaDon.tinhTrang]}}</td>
		            </tr>
		        </tbody>
		    </table>
		</div>
	</div>
</div>
<div class="container mt-3" ng-if="nhanVien.danhSachHoaDon.length <= 0">
	<div class="row justify-content-center align-items-center" style="width: 100%; height: 500px; padding: 0; margin: 0; background-color: #e5e5e5;">
        <h5>Hiện tại bạn chưa có đơn hàng nào.</h5>
    </div>
</div>