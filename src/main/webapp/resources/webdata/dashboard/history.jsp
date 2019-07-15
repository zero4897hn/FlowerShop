<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-xs-9">
	<ul class="pagination" ng-if="soTrang > 1">
		<li class="page-item">
			<a class="page-link" href="javascript:;" aria-label="Previous" ng-click="trangTruoc()">
				<span aria-hidden="true">«</span>
				<span class="sr-only">Previous</span>
			</a>
		</li>
		<li class="page-item"><a href="javascript:;" class="page-link">{{trangHienTai}} / {{soTrang}}</a></li>
		<li class="page-item">
			<a class="page-link" href="javascript:;" aria-label="Next" ng-click="trangTiepTheo()">
				<span aria-hidden="true">»</span>
				<span class="sr-only">Next</span>
			</a>
		</li>
	</ul>
	<ul class="sortable-list connectedSortable ui-sortable">
		<li class="ui-sortable-handle" style="position: relative; left: 0px; top: 0px; cursor: auto;" ng-repeat="tuongTac in listTuongTacCon">
			<span class="pull-right">{{tuongTac.thoiGianTuongTac}}</span>
			<a href="user_info/{{tuongTac.nhanVien.id}}" style="color: blue;">{{tuongTac.nhanVien.tenNhanVien}}</a> {{tuongTac.noiDung}} <a ng-if="tuongTac.idTuongTac != undefined" href="{{linkDenTruong(tuongTac)}}" style="color: orange;">{{tuongTac.tenTuongTac}}</a>
		</li>
	</ul>
</div>
<div class="col-sm-3">
	<fieldset class="form-group">
		<label>Lọc tương tác theo ngày:</label>
		<input type="date" class="form-control" ng-model="tuongTacTheoNgay">
		<button class="btn btn-primary" style="float: right;" ng-click="locTuongTacTheoNgay(tuongTacTheoNgay)"><i class="material-icons" aria-hidden="true">search</i></button>
	</fieldset>
</div>