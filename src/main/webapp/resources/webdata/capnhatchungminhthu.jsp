<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<md-dialog aria-label="Đổi chứng minh thư nhân dân">
	<form ng-cloak name="formDoiChungMinh">
		<md-toolbar>
			<div class="md-toolbar-tools">
				<h2>Đổi chứng minh thư nhân dân</h2>
				<span flex></span>
				<md-button class="md-icon-button" ng-click="cancel()">
					<i class="fa fa-times"></i>
				</md-button>
			</div>
		</md-toolbar>

		<md-dialog-content>
			<div class="md-dialog-content">
				<fieldset class="form-group">
				    <label for="txtCurrentPassword">Chứng minh thư cũ:</label>
				    <input type="text" ng-maxlength="50" class="form-control" ng-model="item.chungMinhNhanDanHienTai" name="txtCurrentPassword" placeholder="Nhập chứng minh thư cũ" ng-required="true"/>
				</fieldset>
				<fieldset class="form-group">
				    <label for="txtNewPassword">Chứng minh thư mới:</label>
				    <input type="text" ng-maxlength="50" class="form-control" ng-model="item.chungMinhNhanDanMoi" name="txtNewPassword" placeholder="Nhập chứng minh thư mới" ng-required="true"/>
				</fieldset>
			</div>
		</md-dialog-content>

		<md-dialog-actions layout="row">
			<span flex></span>
			<md-button ng-click="cancel()">Hủy</md-button>
			<md-button ng-disabled="formDoiChungMinh.$invalid" ng-click="updateUser(item)">
				Xác nhận
			</md-button>
		</md-dialog-actions>
	</form>
</md-dialog>