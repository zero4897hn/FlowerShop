<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<md-dialog aria-label="Đổi email">
	<form ng-cloak name="formDoiEmail">
		<md-toolbar>
			<div class="md-toolbar-tools">
				<h2>Đổi email</h2>
				<span flex></span>
				<md-button class="md-icon-button" ng-click="cancel()">
					<i class="fa fa-times"></i>
				</md-button>
			</div>
		</md-toolbar>

		<md-dialog-content>
			<div class="md-dialog-content">
				<fieldset class="form-group">
				    <label for="txtCurrentPassword">Email cũ:</label>
				    <input type="email" ng-maxlength="50" class="form-control" ng-model="item.emailHienTai" name="txtCurrentPassword" placeholder="Nhập email cũ" ng-required="true"/>
				</fieldset>
				<fieldset class="form-group">
				    <label for="txtNewPassword">Email mới:</label>
				    <input type="email" ng-maxlength="50" class="form-control" ng-model="item.emailMoi" name="txtNewPassword" placeholder="Nhập email mới" ng-required="true"/>
				</fieldset>
			</div>
		</md-dialog-content>

		<md-dialog-actions layout="row">
			<span flex></span>
			<md-button ng-click="cancel()">Hủy</md-button>
			<md-button ng-disabled="formDoiEmail.$invalid" ng-click="updateUser(item)">
				Xác nhận
			</md-button>
		</md-dialog-actions>
	</form>
</md-dialog>