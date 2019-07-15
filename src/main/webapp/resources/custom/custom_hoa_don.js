app.controller('HoaDonController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $location, $cookies, $filter) {
	var last = {
		bottom: false,
		top: true,
		left: false,
		right: true
	};

	$scope.toastPosition = angular.extend({},last);

	$scope.getToastPosition = function() {
		sanitizePosition();

		return Object.keys($scope.toastPosition)
		.filter(function(pos) { return $scope.toastPosition[pos]; })
		.join(' ');
	};

	function sanitizePosition() {
		var current = $scope.toastPosition;

		if (current.bottom && last.top) current.top = false;
		if (current.top && last.bottom) current.bottom = false;
		if (current.right && last.left) current.left = false;
		if (current.left && last.right) current.right = false;

		last = angular.extend({},current);
	}
	
	$scope.showSimpleToast = function(text) {
		var pinTo = $scope.getToastPosition();

		$mdToast.show(
			$mdToast.simple()
			.textContent(text)
			.position(pinTo)
			.hideDelay(3000)
		);
	};

	var gioHangCookie = $cookies.get('gio_hang_cookie');

	if (gioHangCookie == undefined || !gioHangCookie) {
		var listGioHang = [];
	} else {
		var listGioHang = angular.fromJson(gioHangCookie);
	}

	$http.post('/FlowerShop/api/get_danh_sach_gio_hang', angular.toJson(listGioHang), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.danhSachDonHang = response.data;
	}, function(error) {
		console.log(error);
	});

	if ($rootScope.idNhanVien != undefined) {
		$http.post('/FlowerShop/api/get_nhan_vien', angular.toJson({
			idNhanVien: $rootScope.idNhanVien
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.nhanVien = response.data;
			$scope.yeuCauCapNhatThongTin = (($scope.nhanVien.tenNhanVien == null || !$scope.nhanVien.tenNhanVien) || 
				($scope.nhanVien.soDienThoai == null || !$scope.nhanVien.soDienThoai) || 
				($scope.nhanVien.diaChi == null || !$scope.nhanVien.diaChi));
			if ($scope.yeuCauCapNhatThongTin) {
				$scope.radioThongTinTaiKhoan = 'false';
			}
			else {
				$scope.radioThongTinTaiKhoan = 'true';
			}
		}, function(error) {
			console.log(error);
		});
	}
	else {
		$scope.radioThongTinTaiKhoan = 'false';
	}

	$scope.datHang = function(isThongTinTaiKhoan, thongTin) {
		if (isThongTinTaiKhoan) {
			var textContent = 'Xác nhận đặt hàng theo thông tin tài khoản?';
		}
		else {
			var textContent = 'Xác nhận đặt hàng theo thông tin đã nhập?';
		}
		var confirm = $mdDialog.confirm()
			.title('Xác nhận đặt hàng')
			.textContent(textContent)
			.ok('Chắc chắn')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
      		$http.post('/FlowerShop/api/dat_hang', angular.toJson({
      			idNhanVien: $rootScope.idNhanVien,
      			thongTin: thongTin,
      			gioHang: listGioHang,
      			dungTaiKhoanHienTai: isThongTinTaiKhoan
      		}), {
      			headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
      		}).then(function(response) {
      			var notification = response.data.notice;
      			if (notification == 'success') {
      				$cookies.remove('gio_hang_cookie', {
						path: '/FlowerShop'
					});
					$rootScope.soLuongSanPhamTrongGioHang = 0;
					$mdDialog.show(
						$mdDialog.alert()
						.title('Thành công')
						.textContent('Đặt hàng thành công. Mã đơn hàng: ' + response.data.id_hoa_don)
						.ariaLabel('Thành công')
						.ok('Trở về trang chủ')
					).then(function() {
						$location.path('');
					});
      			}
      			else {
      				$scope.showSimpleToast(notification);
      			}
      		}, function(error) {
      			console.log(error);
      		});
		}, function() {

		});
	}

	$scope.khuyenMaiHienTai = function(khuyenMai) {
		var current = new Date().getTime();
		return (!khuyenMai.daXoa && current > khuyenMai.thoiGianBatDau && current < khuyenMai.thoiGianKetThuc)
	}

	$scope.getGiaKhuyenMai = function(kieuSanPham) {
		var dsKhuyenMai = $filter('filter')(kieuSanPham.danhSachKhuyenMai, $scope.khuyenMaiHienTai);
		var giaKhuyenMai = kieuSanPham.giaTien;
		dsKhuyenMai.forEach(function(value) {
			var phanTramGiam = value.phanTramGiam / 100;
			var giaTienSauKhiGiamToiDa = giaKhuyenMai - value.giaGiamToiDa;
			giaKhuyenMai = giaKhuyenMai * (1 - phanTramGiam);
			if (giaKhuyenMai < giaTienSauKhiGiamToiDa) giaKhuyenMai = giaTienSauKhiGiamToiDa;
		});
		return giaKhuyenMai;
	}

	$scope.tongTien = function() {
		var sum = 0;
		$scope.danhSachDonHang.forEach(function(value) {
			sum = sum + ($scope.getGiaKhuyenMai(value.kieuSanPham) * value.soLuong);
		});
		return sum;
	}
});