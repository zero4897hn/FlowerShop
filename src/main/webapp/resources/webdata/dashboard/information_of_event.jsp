<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="col-sm-12" ng-if="khuyenMai == 'null' || (khuyenMai.daXoa && $root.nhanVienHienTai.chucVu.id < 3)">
    <div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 300px 0px;">Chúng tôi không tìm thấy<br/>khuyến mãi bạn yêu cầu.</h5>
        </div>
    </div>
</div>
<div class="col-sm-10 push-sm-1" ng-if="khuyenMai != 'null' && ((khuyenMai.daXoa && $root.nhanVienHienTai.chucVu.id > 2) || !khuyenMai.daXoa)">
	<div class="row">
		<div class="col-sm-12">
			<img ng-src="/FlowerShop/resources/images/events/{{khuyenMai.hinhKhuyenMai}}" class="img-fluid">
		</div>
	</div>
	<div class="row" style="margin-top: 10px;">
		<div class="col-sm-12">
			<h4 class="text-xs-center">{{khuyenMai.tenKhuyenMai}}</h4>
			<br>
			<div style="width: 100%;" ng-if="khuyenMai.moTa != 'null'">
				{{khuyenMai.moTa}}
			</div>
			<br>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table table-bordered align-middle">
    			<tbody>
    				<tr>
    					<td class="card-text" style="width: 35%;">Thời gian bắt đầu:</td>
                        <td class="card-text" style="width: 65%;">{{khuyenMai.thoiGianBatDau | date: 'dd/MM/yyyy HH:mm'}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Thời gian kết thúc:</td>
                        <td class="card-text" style="width: 65%;">{{khuyenMai.thoiGianKetThuc | date: 'dd/MM/yyyy HH:mm'}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Phần trăm giảm:</td>
                        <td class="card-text" style="width: 65%;">{{khuyenMai.phanTramGiam}}</td>
    				</tr>
    				<tr>
    					<td class="card-text" style="width: 35%;">Giá giảm tối đa:</td>
                        <td class="card-text" style="width: 65%;">{{khuyenMai.giaGiamToiDa | currency : "VND " : 0}}</td>
    				</tr>
    			</tbody>
    		</table>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<div class="card">
				<div class="card-header">
					Các sản phẩm áp dụng giảm giá ({{khuyenMai.danhSachKieuSanPham.length}})
				</div>
				<div class="card-block">
					<table class="table table-striped">
				        <thead>
				            <tr>
				                <th style="width: 5%;">#</th>
				                <th style="width: 30%;">Tên sản phẩm</th>
				                <th style="width: 25%;">Tên kiểu sản phẩm</th>
				                <th style="width: 20%;">Giá tiền</th>
				                <th style="width: 20%;">Danh mục</th>
				            </tr>
				        </thead>
				        <tbody>
				            <tr ng-repeat="kieuSanPham in danhSachKieuSanPhamCon">
				                <th class="align-middle" scope="row" style="width: 5%;">{{$index + 1 + ((trangHienTai - 1) * soKieuSanPhamMoiTrang)}}</th>
				                <td class="align-middle" style="width: 30%;"><a href="product_info/{{kieuSanPham.sanPham.id}}">{{kieuSanPham.sanPham.tenSanPham}}</a></td>
				                <td class="align-middle" style="width: 25%;">{{kieuSanPham.tenKieu}}</td>
				                <td class="align-middle" style="width: 20%;">{{kieuSanPham.giaTien | currency : "VND " : 0}}</td>
				                <td class="align-middle" style="width: 20%;">{{kieuSanPham.sanPham.danhMuc.tenDanhMuc}}</td>
				            </tr>
				        </tbody>
				    </table>
				    <ul class="pagination">
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
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<button class="btn btn-primary" ng-if="!khuyenMai.daXoa" ng-click="suaKhuyenMai()">Sửa khuyến mãi</button>
			<button class="btn btn-danger" ng-if="!khuyenMai.daXoa" ng-click="xoaKhuyenMai()">Xóa khuyến mãi</button>
			<button class="btn btn-outline-primary" ng-if="khuyenMai.daXoa && $root.nhanVienHienTai.chucVu.id > 2" ng-click="khoiPhucKhuyenMai()">Khôi phục</button>
			<button class="btn btn-outline-danger" ng-if="$root.nhanVienHienTai.chucVu.id > 2" ng-click="xoaVinhVien()">Xóa vĩnh viễn</button>
		</div>
	</div>
</div>