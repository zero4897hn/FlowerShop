<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<md-dialog aria-label="Thêm danh mục">
    <form ng-cloak name="addCategoryForm">
        <md-toolbar>
            <div class="md-toolbar-tools">
                <h2>Thêm danh mục</h2>
                <span flex></span>
                <md-button class="md-icon-button" ng-click="cancel()">
                    <i class="material-icons" aria-label="Close dialog" aria-hidden="true">close</i>
                </md-button>
            </div>
        </md-toolbar>

        <md-dialog-content>
            <div class="md-dialog-content">
				<fieldset class="form-group">
				    <label for="exampleInputEmail1">Tên danh mục:</label>
				    <input type="text" class="form-control" ng-model="tenDanhMuc" placeholder="Nhập tên danh mục" ng-required="true">
				</fieldset>
            </div>
        </md-dialog-content>

        <md-dialog-actions layout="row">
            <md-button ng-click="cancel()">
                Hủy
            </md-button>
            <md-button ng-disabled="!addCategoryForm.$valid" ng-click="themDanhMuc(tenDanhMuc)">
                Xác nhận
            </md-button>
        </md-dialog-actions>
    </form>
</md-dialog>

