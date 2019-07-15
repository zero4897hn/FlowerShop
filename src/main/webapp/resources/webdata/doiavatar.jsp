<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<md-dialog aria-label="Đổi Avatar">
	<form ng-cloak name="userAvatarForm">
		<md-toolbar>
			<div class="md-toolbar-tools">
				<h2>Đổi Avatar</h2>
				<span flex></span>
				<md-button class="md-icon-button" ng-click="cancel()">
					<i class="fa fa-times"></i>
				</md-button>
			</div>
		</md-toolbar>

		<md-dialog-content>
			<fieldset class="form-group">
				<label for="exampleInputFile">Chọn file Avatar</label>
				<input type="file" class="form-control-file" file-model="fileAvatar" accept=".gif,.jpg,.jpeg,.png">
			</fieldset>
		</md-dialog-content>

		<md-dialog-actions layout="row">
			<span flex></span>
			<md-button ng-click="cancel()">Hủy</md-button>
			<md-button ng-click="updateUser(fileAvatar)">
				Xác nhận
			</md-button>
		</md-dialog-actions>
	</form>
</md-dialog>