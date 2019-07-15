<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<md-dialog aria-label="Đổi mật khẩu">
	<form ng-cloak name="userPasswordForm">
		<md-toolbar>
			<div class="md-toolbar-tools">
				<h2>Đổi mật khẩu</h2>
				<span flex></span>
				<md-button class="md-icon-button" ng-click="cancel()">
					<i class="fa fa-times"></i>
				</md-button>
			</div>
		</md-toolbar>

		<md-dialog-content>
			<div class="md-dialog-content">
				<fieldset class="form-group">
				    <label for="txtCurrentPassword">Mật khẩu hiện tại:</label>
				    <input type="password" ng-maxlength="50" class="form-control" ng-model="item.currentAccountPassword" name="txtCurrentPassword" placeholder="Nhập mật khẩu tài khoản hệ thống" ng-required="true"/>
				</fieldset>
				<fieldset class="form-group">
				    <label for="txtNewPassword">Mật khẩu mới:</label>
				    <input type="password" ng-maxlength="50" class="form-control" ng-model="item.newPassword" name="txtNewPassword" placeholder="Nhập mật khẩu mới" ng-required="true"/>
				</fieldset>
				<fieldset class="form-group">
				    <label for="txtConfirmPassword">Xác nhận mật khẩu mới:</label>
				    <input type="password" ng-maxlength="50" class="form-control" ng-model="item.confirmPassword" name="txtConfirmPassword" placeholder="Xác nhận mật khẩu mới" ng-required="true"/>
				</fieldset>
			</div>
		</md-dialog-content>

		<md-dialog-actions layout="row">
			<span flex></span>
			<md-button ng-click="cancel()">Hủy</md-button>
			<md-button ng-disabled="userPasswordForm.$invalid || (userPasswordForm.txtConfirmPassword.$dirty && userPasswordForm.txtConfirmPassword.$valid && !userPasswordForm.txtConfirmPassword.$invalid) && (userPasswordForm.txtNewPassword.$modelValue != userPasswordForm.txtConfirmPassword.$modelValue)" ng-click="updateUser(item)">
				Xác nhận
			</md-button>
		</md-dialog-actions>
	</form>
</md-dialog>