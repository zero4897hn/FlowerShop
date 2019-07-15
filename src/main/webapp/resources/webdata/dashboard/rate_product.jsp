<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="col-sm-9">
	<div class="row" style="padding: 0; margin: 0; background-color: #e5e5e5;" ng-if="listDanhGia.length <= 0">
        <div class="col-sm-12">
            <h5 class="text-xs-center" style="margin: 160px 0px;">Danh sách đánh giá trống</h5>
        </div>
    </div>
	<div class="row" ng-if="listDanhGia.length > 0">
		<div class="col-sm-12">
			<ul class="pagination" style="width: 100%; margin: 10px 0; padding: 0;" ng-hide="soTrang == 1">
				<li class="page-item">
					<button ng-click="trangTruoc()" ng-disabled="trangHienTai == 1" class="page-link" aria-label="Previous">
						<span aria-hidden="true">«</span>
						<span class="sr-only">Previous</span>
					</button>
				</li>
				<li ng-repeat="x in trang" ng-class="(x == trangHienTai)? 'page-item active' : 'page-item'" ng-click="xemDanhGiaTrang(x)"><a class="page-link" href="#">{{x}}</a></li>
				<li class="page-item">
					<button ng-click="trangTiepTheo()" ng-disabled="trangHienTai == soTrang" class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">»</span>
						<span class="sr-only">Next</span>
					</button>
				</li>
			</ul>
		</div>
	</div>
	<div class="row" ng-if="listDanhGia.length > 0">
		<div class="col-sm-12">
			<div class="card" ng-repeat="danhGia in listDanhGiaCon" ng-init="initiateDanhGia(danhGia)">
				<div class="card-header">
					<div ng-if="danhGia.daXem"><a href="user_info/{{danhGia.nhanVien.id}}">{{danhGia.nhanVien.tenNhanVien}}</a>: {{danhGia.tieuDe}} - <a href="product_info/{{danhGia.sanPham.id}}">{{danhGia.sanPham.tenSanPham}}</a></div>
					<div ng-if="!danhGia.daXem"><b><a href="user_info/{{danhGia.nhanVien.id}}">{{danhGia.nhanVien.tenNhanVien}}</a>: {{danhGia.tieuDe}} - <a href="product_info/{{danhGia.sanPham.id}}">{{danhGia.sanPham.tenSanPham}}</a></b></div>
					<div class="card-controls">
						<a href="javascript:;" ng-click="danhDauChuaDoc(danhGia)" ng-show="danhGia.daXem" ng-if="!danhGia.daXoa" title="Đánh dấu chưa đọc"><i class="material-icons" aria-hidden="true">markunread</i></a>
						<a href="javascript:;" ng-click="hienThiChiTietDanhGia(danhGia)" ng-if="!danhGia.daXoa" title="Ẩn hiện đánh giá"><i class="material-icons" aria-hidden="true">keyboard_arrow_down</i></a>
						<a href="javascript:;" ng-click="khoiPhucDanhGia(danhGia)" ng-if="$root.nhanVienHienTai.chucVu.id > 2 && danhGia.daXoa" title="Khôi phục đánh giá"><i class="material-icons" aria-hidden="true">restore</i></a>
						<a href="javascript:;" ng-click="xoaDanhGia(danhGia)" ng-if="!danhGia.daXoa" title="Xóa đánh giá"><i class="material-icons" aria-hidden="true">delete</i></a>
						<a href="javascript:;" ng-click="xoaVinhVienDanhGia(danhGia)" ng-if="$root.nhanVienHienTai.chucVu.id > 2" title="Xóa vĩnh viễn đánh giá"><i class="material-icons" aria-hidden="true">clear</i></a>
                    </div>
				</div>
				<div class="card-block" ng-show="danhGia.hienThi">
					<div class="col-xs-2">
                    	<a href="user_info/{{danhGia.nhanVien.id}}">
                    		<img ng-src="/FlowerShop/resources/images/avatars/{{danhGia.nhanVien.avatar}}" class="img-fluid img-thumbnail" onError="this.onerror=null;this.src='/FlowerShop/resources/images/avatars/anonymous_avatar.png';">
                    	</a>
                        <h6 class="text-xs-center">{{danhGia.nhanVien.tenNhanVien}}</h6>
                    </div>
                    <div class="col-xs-10">
                        <div class="row">
                            <div class="col-xs-12">
                                <div style="width: 100%">
                                    <h5 style="margin-top: 6px;">{{danhGia.tieuDe}}</h5>
                                    <div style="width: fit-content; float: right; top: 6px; position: absolute; right: 25px; padding: 0; margin: 0;">
                                    	<i ng-repeat="soSao in soSaoToiDa" ng-class="(soSao > danhGia.soSao)? 'material-icons' : 'material-icons text-warning'" aria-hidden="true">star</i>
                                    </div>
                                </div>
                                <hr style="margin: 0; padding: 0;">
                                <div style="margin-top: 6px; width: 100%;">
                                    <p style="text-align: justify; text-justify: inter-word;">
                                    	{{danhGia.noiDung}}
                                    </p>
                                    <a href="javascript:;" style="text-decoration: none;" ng-click="capNhatAnHienTraLoi(danhGia)">{{danhGia.anHienTraLoi}} ({{danhGia.danhSachTraLoiDanhGia.length}})</a>
                                    
                                    <span style="float: right;">Đánh giá lúc {{danhGia.thoiGianDanhGia}}</span>
                                </div>
                            </div>
                            <div class="col-xs-12" ng-if="danhGia.hienTraLoi">
                            	<a href="javascript:;" style="text-decoration: none;" ng-click="capNhatAnHienDanhSachDaXoa(danhGia)" ng-if="$root.nhanVienHienTai.chucVu.id > 2">{{danhGia.anHienTraLoiDaXoa}}</a>
                            	<div class="row" style="background: #efeeee; margin: 10px 2px; padding: 5px 0;" ng-repeat="traLoiDanhGia in danhGia.danhSachTraLoiDanhGia">
                            		<div class="col-xs-2">
				                    	<a href="user_info/{{traLoiDanhGia.nhanVien.id}}">
				                    		<img ng-src="/FlowerShop/resources/images/avatars/{{traLoiDanhGia.nhanVien.avatar}}" class="img-fluid img-thumbnail" onError="this.onerror=null;this.src='/FlowerShop/resources/images/avatars/anonymous_avatar.png';">
				                    	</a>
				                    </div>
				                    <div class="col-xs-10">
				                        <div class="row">
				                            <div class="col-xs-12">
				                                <div style="width: 100%">
				                                    <h5 style="margin-top: 6px;"><b>{{traLoiDanhGia.nhanVien.tenNhanVien}}</b></h5>
				                                    <div style="width: fit-content; float: right; top: 6px; position: absolute; right: 25px; padding: 0; margin: 0;">
				                                    	<a href="javascript:;" ng-click="hoiPhucTraLoi(traLoiDanhGia, danhGia)" ng-if="traLoiDanhGia.daXoa"><i class="material-icons" aria-hidden="true" title="Hồi phục trả lời">restore</i></a>
				                                    	<a href="javascript:;" ng-click="xoaTraLoi(traLoiDanhGia, danhGia)" ng-if="!traLoiDanhGia.daXoa" title="Xóa trả lời"><i class="material-icons" aria-hidden="true">delete</i></a>
				                                    	<a href="javascript:;" ng-click="xoaVinhVienTraLoi(traLoiDanhGia, danhGia)" ng-if="$root.nhanVienHienTai.chucVu.id > 2" title="Xóa vĩnh viễn trả lời"><i class="material-icons" aria-hidden="true">clear</i></a>
				                                    </div>
				                                </div>
				                                <hr style="margin: 0; padding: 0;">
				                                <div style="margin-top: 6px; width: 100%;">
				                                    <p style="text-align: justify; text-justify: inter-word;">
				                                    	{{traLoiDanhGia.noiDung}}
				                                    </p>
				                                    <span style="float: right;">Trả lời lúc {{traLoiDanhGia.thoiGianTraLoi}}</span>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
                            	</div>
                            	<div class="row">
                            		<div class="col-xs-12" style="margin-top: 10px;">
		                            	<textarea class="form-control" rows="2" placeholder="Trả lời đánh giá" ng-model="danhGia.noiDungTraLoi"></textarea>
		                            	<button class="btn btn-primary" style="float: right;" ng-click="traLoi(danhGia)">Trả lời</button>
		                            </div>
                            	</div>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-sm-3">
	<fieldset class="form-group">
		<label>Số đánh giá mỗi trang:</label>
		<input type="number" min="5" class="form-control" ng-model="soDanhGiaMoiTrang" ng-change="capNhatSoDanhGiaMoiTrang()">
	</fieldset>
	<fieldset class="form-group">
		<label>Đến trang:</label>
		<input type="number" min="1" max="{{soTrang}}" class="form-control" ng-model="trangHienTai" ng-change="denTrangThu()">
	</fieldset>
	<div class="radio">
		<label>Lọc đánh giá:</label>
		<label>
			<input type="radio" ng-model="danhGiaDaXem" checked="true" ng-change="locDanhSachDanhGia()">
			Tất cả
		</label>
		<label>
			<input type="radio" ng-model="danhGiaDaXem" ng-value="true" ng-change="locDanhSachDanhGia()">
			Đã xem
		</label>
		<label>
			<input type="radio" ng-model="danhGiaDaXem" ng-value="false" ng-change="locDanhSachDanhGia()">
			Chưa xem
		</label>
	</div>
	<fieldset class="form-group">
		<label>Tìm đánh giá:</label>
		<input type="text" minlength="0" maxlength="50" class="form-control" ng-model="danhGiaCanTim">
		<button class="btn btn-primary" style="float: right;" ng-click="timDanhGia()"><i class="material-icons" aria-hidden="true">search</i></button>
	</fieldset>
	<fieldset class="form-group" ng-if="$root.nhanVienHienTai.chucVu.id > 2">
		<label class="custom-control custom-checkbox m-b-1">
            <input type="checkbox" ng-model="boQuaDaXoa" class="custom-control-input" ng-change="capNhatBoQuaDaXoa(boQuaDaXoa)">
            <span class="custom-control-indicator"></span>
            <span class="custom-control-description">Bỏ qua những đánh giá đã xóa</span>
        </label>
	</fieldset>
</div>