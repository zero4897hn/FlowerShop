<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<md-dialog aria-label="Xác nhận mật khẩu">
	<form ng-cloak name="userPasswordForm">
		<md-toolbar>
			<div class="md-toolbar-tools">
				<h2>Xác nhận mật khẩu</h2>
				<span flex></span>
				<md-button class="md-icon-button" ng-click="cancel()">
					<i class="material-icons" aria-label="Close dialog" aria-hidden="true">close</i>
				</md-button>
			</div>
		</md-toolbar>

		<md-dialog-content>
			<div class="md-dialog-content">
				<fieldset class="form-group">
				    <label for="txtCurrentPassword">Mật khẩu tài khoản hệ thống:</label>
				    <input type="password" ng-maxlength="50" class="form-control" ng-model="currentAccountPassword" name="txtCurrentPassword" placeholder="Nhập mật khẩu tài khoản hệ thống" ng-required="true"/>
				</fieldset>
			</div>
		</md-dialog-content>

		<md-dialog-actions layout="row">
			<span flex></span>
			<md-button ng-click="cancel()">Hủy</md-button>
			<md-button ng-click="updateUser(currentAccountPassword)">
				Xác nhận
			</md-button>
		</md-dialog-actions>
	</form>
</md-dialog>