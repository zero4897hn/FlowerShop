<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-sm-10 push-sm-1">
	<form>
		<fieldset class="form-group">
			<div class="card">
				<div class="card-header">
					Banner chuyển động:
					<div class="card-controls">
						<a href="javascript:;"><i class="material-icons" aria-hidden="true" ng-click="addNewBanner()">add</i></a>
					</div>
				</div>
				<div class="card-block">
					<div class="card" ng-repeat="banner in listBanner" ng-init="banner.hienThi = true;">
						<div class="card-header">
							Banner thứ {{$index + 1}}
							<div class="card-controls">
								<a href="javascript:;" class="card-collapse" data-toggle="card-collapse" ng-click="collapseBanner(banner)"></a>
								<a href="javascript:;" class="card-remove" data-toggle="card-remove" ng-click="removeBanner(banner)"></a>
							</div>
						</div>
						<div class="card-block" ng-show="banner.hienThi">
							<fieldset class="form-group">
								<label class="col-xs-2 col-form-label" style="padding-left: 0;">Tiêu đề</label>
								<div class="col-xs-10">
									<input type="text" class="form-control" placeholder="Nhập tiêu đề" ng-maxlength="50" ng-model="banner.tieuDe">
								</div>
							</fieldset>
							<fieldset class="form-group">
								<label class="col-xs-2 col-form-label" style="padding-left: 0;">Nội dung</label>
								<div class="col-xs-10">
									<textarea class="form-control" rows="3" placeholder="Nhập nội dung" ng-model="banner.noiDung"></textarea>
								</div>
							</fieldset>
							<fieldset class="form-group">
								<label class="col-xs-2" style="padding-left: 0;">Ảnh:</label>
								<div class="col-xs-6">
									<input type="file" class="form-control-file" accept=".gif,.jpg,.jpeg,.png" file-model="banner.fileAnh">
								</div>
								<div class="col-xs-4">
									<img ng-src="/FlowerShop/resources/images/events/{{banner.hinhAnh}}" class="img-fluid">
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Khung nội dung:</label>
			<div class="col-xs-10">
				<div class="row">
					<div class="col-xs-2">
						<select class="form-control" ng-model="noiDung[0].kiHieu">
							<option ng-repeat="fontawesome in listFontawesome" value="{{fontawesome}}">
								{{fontawesome}}
							</option>
						</select>
					</div>
					<div class="col-xs-4">
						<input type="text" class="form-control" placeholder="Nhập tiêu đề" ng-maxlength="255" ng-model="noiDung[0].tieuDe">
					</div>
					<div class="col-xs-6">
						<input type="text" class="form-control" placeholder="Nhập nội dung" ng-maxlength="255" ng-model="noiDung[0].noiDung">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-2">
						<select class="form-control" ng-model="noiDung[1].kiHieu">
							<option ng-repeat="fontawesome in listFontawesome" value="{{fontawesome}}">
								{{fontawesome}}
							</option>
						</select>
					</div>
					<div class="col-xs-4">
						<input type="text" class="form-control" placeholder="Nhập tiêu đề" ng-maxlength="255" ng-model="noiDung[1].tieuDe">
					</div>
					<div class="col-xs-6">
						<input type="text" class="form-control" placeholder="Nhập nội dung" ng-maxlength="255" ng-model="noiDung[1].noiDung">
					</div>
				</div>
				<div class="row">
					<div class="col-xs-2">
						<select class="form-control" ng-model="noiDung[2].kiHieu">
							<option ng-repeat="fontawesome in listFontawesome" value="{{fontawesome}}">
								{{fontawesome}}
							</option>
						</select>
					</div>
					<div class="col-xs-4">
						<input type="text" class="form-control" placeholder="Nhập tiêu đề" ng-maxlength="255" ng-model="noiDung[2].tieuDe">
					</div>
					<div class="col-xs-6">
						<input type="text" class="form-control" placeholder="Nhập nội dung" ng-maxlength="255" ng-model="noiDung[2].noiDung">
					</div>
				</div>
			</div>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Khung sản phẩm:</label>
			<div class="col-xs-10">
				<div class="row">
					<div class="col-xs-8">
						<div class="checkbox">
							<label class="col-form-label">
								<input type="checkbox" ng-model="isSanPhamHotChecked" ng-change="chonDanhSachHot()"> Lấy danh sách sản phẩm theo lượng mua với số lượng:
							</label>
						</div>
					</div>
					<div class="col-xs-4">
						<select class="form-control" ng-model="soLuongSanPham" ng-disabled="!isSanPhamHotChecked">
							<option value="4">4</option>
							<option value="8">8</option>
							<option value="12">12</option>
						</select>
					</div>
				</div>
				<div class="row" style="margin-top: 10px;" ng-if="!isSanPhamHotChecked">
					<div class="col-xs-6">
						<input type="text" class="form-control" placeholder="Nhập sản phầm cần tìm" ng-maxlength="255" ng-model="sanPhamCanTim">
						<select class="form-control" size="6" style="overflow: scroll;">
							<option ng-repeat="sanPham in listSanPham | filter: sanPhamCanTim" ng-click="chonSanPham(sanPham)">
								{{sanPham.tenSanPham}}
							</option>
						</select>
					</div>
					<div class="col-xs-6">
						<select class="form-control" size="8" style="overflow: scroll;">
							<option ng-repeat="sanPham in listSelectedSanPham" ng-click="huyChonSanPham(sanPham)">
								{{sanPham.tenSanPham}}
							</option>
						</select>
					</div>
				</div>
			</div>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Nhúng bản đồ:</label>
			<div class="col-xs-10">
				<input type="text" class="form-control" ng-model="nhungBanDo">
			</div>
		</fieldset>
		<fieldset class="form-group">
			<label class="col-xs-2 col-form-label" style="padding-left: 0;">Chân trang:</label>
			<div class="col-xs-10">
				<div class="row">
					<div class="col-xs-5">
						<input type="text" class="form-control" ng-model="chanTrang.benTrai.tieuDe" placeholder="Nhập tiêu đề">
					</div>
					<div class="col-xs-6">
						<div class="row" ng-repeat="noiDungChanTrang in chanTrang.benTrai.noiDung track by $index">
							<div class="col-xs-9">
								<input type="text" class="form-control" ng-model="chanTrang.benTrai.noiDung[$index]" placeholder="Nhập nội dung">
							</div>
							<div class="col-xs-3">
								<button class="btn btn-light" ng-click="xoaNoiDungChanTrangBenTrai($index)" style="height: 38px;"><i class="material-icons" aria-hidden="true">delete</i></button>
							</div>
						</div>
					</div>
					<div class="col-xs-1">
						<button class="btn btn-outline-info" ng-click="themNoiDungChanTrangBenTrai()"><i class="material-icons" aria-hidden="true">add</i></button>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-xs-10">
						<div class="row" ng-repeat="xaHoi in chanTrang.xaHoi track by $index">
							<div class="col-xs-5">
								<input type="text" class="form-control" ng-model="chanTrang.xaHoi[$index].kiHieu" placeholder="Nhập ký hiệu">
							</div>
							<div class="col-xs-5">
								<input type="text" class="form-control" ng-model="chanTrang.xaHoi[$index].duongDan" placeholder="Nhập đường dẫn">
							</div>
							<div class="col-xs-2">
								<button class="btn btn-light" ng-click="xoaXaHoi($index)" style="height: 38px;"><i class="material-icons" aria-hidden="true">delete</i></button>
							</div>
						</div>
					</div>
					<div class="col-xs-2">
						<button class="btn btn-outline-info" ng-click="themXaHoi()"><i class="material-icons" aria-hidden="true">add</i></button>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-xs-5">
						<input type="text" class="form-control" ng-model="chanTrang.benPhai.tieuDe" placeholder="Nhập tiêu đề">
					</div>
					<div class="col-xs-6">
						<div class="row" ng-repeat="noiDungChanTrang in chanTrang.benPhai.noiDung track by $index">
							<div class="col-xs-9">
								<input type="text" class="form-control" ng-model="chanTrang.benPhai.noiDung[$index]" placeholder="Nhập nội dung">
							</div>
							<div class="col-xs-3">
								<button class="btn btn-light" ng-click="xoaNoiDungChanTrangBenPhai($index)" style="height: 38px;"><i class="material-icons" aria-hidden="true">delete</i></button>
							</div>
						</div>
					</div>
					<div class="col-xs-1">
						<button class="btn btn-outline-info" ng-click="themNoiDungChanTrangBenPhai()"><i class="material-icons" aria-hidden="true">add</i></button>
					</div>
				</div>
			</div>
		</fieldset>
		<button class="btn btn-primary" ng-click="capNhatTrangChu()">Cập nhật trang chủ</button>
	</form>
</div>