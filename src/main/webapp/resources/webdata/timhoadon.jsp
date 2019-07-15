<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<md-dialog aria-label="Tìm hóa đơn">
	<form ng-cloak name="formTimHoaDon">
		<md-toolbar>
			<div class="md-toolbar-tools">
				<h2>Tìm hóa đơn</h2>
				<span flex></span>
				<md-button class="md-icon-button" ng-click="cancel()">
					<i class="fa fa-times"></i>
				</md-button>
			</div>
		</md-toolbar>

		<md-dialog-content>
			<div class="md-dialog-content">
				<fieldset class="form-group">
				    <label>Mã hóa đơn cần tìm:</label>
				    <input type="text" ng-maxlength="20" class="form-control" ng-model="maHoaDonCanTim" placeholder="Nhập mã hóa đơn cần tìm" ng-required="true"/>
				</fieldset>
			</div>
		</md-dialog-content>

		<md-dialog-actions layout="row">
			<span flex></span>
			<md-button ng-click="cancel()">Hủy</md-button>
			<md-button ng-disabled="formTimHoaDon.$invalid" ng-click="submit(maHoaDonCanTim)">
				Xác nhận
			</md-button>
		</md-dialog-actions>
	</form>
</md-dialog>