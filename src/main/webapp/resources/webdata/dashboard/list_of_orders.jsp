<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="col-sm-9">
	<div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listHoaDonCon.length <= 0">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 160px 0px;">Danh sách đơn hàng trống</h5>
        </div>
    </div>
	<div class="row" ng-if="listHoaDonCon.length > 0">
		<div class="col-sm-12" style="height: 100%">
			<ul class="pagination" style="width: 100%; margin: 10px 0; padding: 0;" ng-hide="soTrang < 2">
				<li class="page-item">
					<button ng-click="trangTruoc()" ng-disabled="trangHienTai == 1" class="page-link" aria-label="Previous">
						<span aria-hidden="true">«</span>
						<span class="sr-only">Previous</span>
					</button>
				</li>
				<li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemHoaDonTrang(x)"><a class="page-link" href="#">{{x}}</a></li>
				<li class="page-item">
					<button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span>
						<span class="sr-only">Next</span>
					</button>
				</li>
			</ul>
		</div>
	</div>
	<div class="row" ng-if="listHoaDonCon.length > 0">
		<div class="col-sm-12">
			<div class="card" ng-repeat="hoaDon in listHoaDonCon" ng-init="initiateHoaDon(hoaDon)">
				<div class="card-header">
					<div>
						<h5 ng-if="hoaDon.daXem">Hóa đơn {{hoaDon.maHoaDon}}</h5>
						<h5 ng-if="!hoaDon.daXem"><b>Hóa đơn {{hoaDon.maHoaDon}}</b></h5>
						<span style="font-size: 10px; font-style: italic;">Ngày lập: {{hoaDon.ngayLapDate | date: 'dd/MM/yyyy HH:mm:ss'}}</span>
					</div>
					<div class="card-controls">
						<a href="javascript:;" ng-click="danhDauChuaDoc(hoaDon)" ng-show="hoaDon.daXem"><i class="material-icons" aria-hidden="true" title="Đánh dấu chưa đọc">markunread</i></a>
						<a href="javascript:;" ng-click="hienThiChiTietHoaDon(hoaDon)"><i class="material-icons" aria-hidden="true">keyboard_arrow_down</i></a>
					</div>
				</div>
				<div class="card-block" ng-show="hoaDon.hienThi">
					<table class="table table-bordered align-middle" ng-show="!x.enabledEdit">
		    			<tbody>
		    				<tr>
		    					<td class="card-text" style="width: 35%;">Tên người đặt:</td>
		                        <td class="card-text" style="width: 65%;">{{hoaDon.hoTenNguoiNhan}}</td>
		    				</tr>
		    				<tr>
		    					<td class="card-text" style="width: 35%;">Địa chỉ:</td>
		                        <td class="card-text" style="width: 65%;">{{hoaDon.diaChiGiaoHang}}</td>
		    				</tr>
		    				<tr>
		    					<td class="card-text" style="width: 35%;">Số điện thoại:</td>
		                        <td class="card-text" style="width: 65%;">{{hoaDon.soDienThoai}}</td>
		    				</tr>
		    				<tr>
		    					<td class="card-text" style="width: 35%;">Ngày lập hóa đơn:</td>
		                        <td class="card-text" style="width: 65%;">{{hoaDon.ngayLapDate | date: 'dd/MM/yyyy HH:mm:ss'}}</td>
		    				</tr>
		    				<tr>
		    					<td class="card-text" style="width: 35%;">Ghi chú:</td>
		                        <td class="card-text" style="width: 65%;">{{hoaDon.ghiChu}}</td>
		    				</tr>
		    				<tr>
		    					<td class="card-text" style="width: 35%;">Tổng tiền:</td>
		                        <td class="card-text" style="width: 65%;">{{tongTien(hoaDon) | currency : "VND " : 0}}</td>
		    				</tr>
		    			</tbody>
		    		</table>
		    		<div class="card">
		                <div class="card-header">
		                    Quá trình vận chuyển
		                </div>
		                <div class="card-block">
		                    <ul class="list-group">
		                        <li class="list-group-item" ng-repeat="quaTrinh in hoaDon.danhSachQuaTrinh | orderBy: ngayDienRa : reverse">
		                            <div class="d-flex w-100 justify-content-between">
		                                {{ quaTrinh.ngayDienRa | date: 'dd/MM/yyyy HH:mm:ss' }} - 
		                                {{ quaTrinh.tinhTrangHoaDon.tenTinhTrang }}
		                            </div>
		                            <p class="mb-1" ng-if="quaTrinh.ghiChu != null">{{quaTrinh.ghiChu}}</p>
		                        </li>
		                    </ul>
		                </div>
		            </div>
		    		<div class="card">
		    			<div class="card-header">
		    				Các đơn hàng đã đặt
		    			</div>
		    			<div class="card-block">
		    				<table class="table table-striped table-hover" style="width: 100%;">
								<thead>
									<tr>
										<th scope="col">#</th>
										<th scope="col" style="width: 10%;">Hình ảnh</th>
										<th scope="col" style="width: 40%;">Sản phẩm</th>
										<th scope="col">Đơn giá</th>
										<th scope="col" style="width: 10%;">Số lượng</th>
										<th scope="col">Thành tiền</th>
									</tr>
								</thead>
								<tbody>
									<tr ng-repeat="donHang in hoaDon.danhSachDonHang">
										<th class="align-middle" scope="row">{{$index + 1}}</th>
										<td class="align-middle">
											<img ng-src="/FlowerShop/resources/images/products/{{donHang.kieuSanPham.sanPham.hinhAnh}}" class="img img-fluid">
										</td>
										<td class="align-middle"><a href="product_info/{{donHang.kieuSanPham.sanPham.id}}">{{donHang.kieuSanPham.sanPham.tenSanPham}}</a></td>
										<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham, hoaDon) | currency : "VND " : 0}}</td>
										<td class="align-middle">{{donHang.soLuong}}</td>
										<td class="align-middle">{{getGiaKhuyenMai(donHang.kieuSanPham, hoaDon) * donHang.soLuong | currency : "VND " : 0}}</td>
									</tr>
								</tbody>
							</table>
						</div>
		    		</div>
		    		<div class="row">
		    			<div class="col-xs-8" ng-if="hoaDon.quaTrinhGanNhat.tinhTrangHoaDon.id != 5 && hoaDon.quaTrinhGanNhat.tinhTrangHoaDon.id != 6">
							<div class="input-group">
								<select class="form-control" ng-model="hoaDon.tinhTrangCanChuyen" style="width: 50%">
									<option ng-repeat="tinhTrang in listTinhTrang" ng-value="tinhTrang.id">{{tinhTrang.tenTinhTrang}}</option>
								</select>
								<input type="text" class="form-control" style="width: 50%" ng-model="hoaDon.ghiChu" placeholder="Nhập ghi chú">
								<span class="input-group-btn">
									<button class="btn btn-default" type="button" ng-click="doiTrangThai(hoaDon)">Đổi trạng thái</button>
								</span>
							</div>
		    			</div>
		    			<div class="col-xs-4">
		    				<button class="btn btn-toolbar" ng-click="xuatHoaDon(hoaDon)" style="margin: auto;">Xuất hóa đơn</button>
		    			</div>
		    		</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12" style="height: 100%">
			<ul class="pagination" style="width: 100%; margin: 10px 0; padding: 0;" ng-hide="soTrang < 2">
				<li class="page-item">
					<button ng-click="trangTruoc()" ng-disabled="trangHienTai == 1" class="page-link" aria-label="Previous">
						<span aria-hidden="true">«</span>
						<span class="sr-only">Previous</span>
					</button>
				</li>
				<li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemHoaDonTrang(x)"><a class="page-link" href="#">{{x}}</a></li>
				<li class="page-item">
					<button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span>
						<span class="sr-only">Next</span>
					</button>
				</li>
			</ul>
		</div>
	</div>
</div>
<div class="col-sm-3">
	<fieldset>
		<label>Số hóa đơn mỗi trang:</label>
		<input type="number" min="5" class="form-control" ng-model="soHoaDonMoiTrang" ng-change="capNhatSoHoaDonMoiTrang()">
	</fieldset>
	<fieldset style="padding: 0; margin: 10px 0;">
		<label>Đi đến trang:</label>
		<input type="number" min="1" max="{{soTrang}}" class="form-control" ng-model="trangHienTai" ng-change="denTrangThu()">
	</fieldset>
	<div class="radio">
		<label>Lọc hóa đơn:</label>
		<label>
			<input type="radio" ng-model="hoaDonDaXem" checked="true" ng-change="locDanhSachHoaDon()">
			Tất cả
		</label>
		<label>
			<input type="radio" ng-model="hoaDonDaXem" ng-value="true" ng-change="locDanhSachHoaDon()">
			Đã xem
		</label>
		<label>
			<input type="radio" ng-model="hoaDonDaXem" ng-value="false" ng-change="locDanhSachHoaDon()">
			Chưa xem
		</label>
	</div>
	<fieldset>
		<label>Tìm mã hóa đơn:</label>
		<input type="text" minlength="0" maxlength="50" class="form-control" ng-model="maHoaDonCanTim">
		<button class="btn btn-primary" style="float: right;" ng-click="timMaHoaDon()"><i class="material-icons" aria-hidden="true">search</i></button>
	</fieldset>
</div>