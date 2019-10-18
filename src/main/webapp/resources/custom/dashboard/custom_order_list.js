app.controller('OrderListController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $filter, $cookies, $location, $window, Page) {
	Page.setTitle('Danh sách đơn hàng');

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

	$scope.thaoTacVoiHoaDon = ['Xác nhận và tiến hành giao', 'Xác nhận đã giao cho khách'];
	$scope.tinhTrangHoaDon = ['Mới đặt', 'Đang giao', 'Đã giao'];
	$scope.tinhTrangHoaDon[-1] = 'Đã hủy';

	$http.post('/FlowerShop/api/get_danh_sach_hoa_don', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listHoaDonGoc = response.data;
		$scope.listHoaDon = $scope.listHoaDonGoc;
		var orderListCookie = $cookies.getObject('dashboard_order_list');
		if (orderListCookie == undefined) {
			$scope.trangHienTai = 1;
			$scope.soHoaDonMoiTrang = 10;
		}
		else {
			if (orderListCookie.trangHienTai == undefined) {
				$scope.trangHienTai = 1;
			}
			else {
				$scope.trangHienTai = orderListCookie.trangHienTai;
			}
			if (orderListCookie.soHoaDonMoiTrang == undefined) {
				$scope.soHoaDonMoiTrang = 10;
			}
			else {
				$scope.soHoaDonMoiTrang = orderListCookie.soHoaDonMoiTrang;
			}
			if (orderListCookie.locHoaDon != undefined) {
				$scope.hoaDonDaXem = orderListCookie.locHoaDon;
				$scope.listHoaDon = $filter('filter')($scope.listHoaDonGoc, {daXem: $scope.hoaDonDaXem});
			}
			if (orderListCookie.maHoaDonCanTim != undefined) {
				$scope.maHoaDonCanTim = orderListCookie.maHoaDonCanTim;
				$scope.listHoaDon = $filter('filter')($scope.listHoaDonGoc, {maHoaDon: $scope.maHoaDonCanTim});
			}
		}
		$scope.capNhatDanhSachHoaDon();
	}, function(error) {
		console.log(error);
	});

	$scope.doiTrangThai = function(hoaDon) {
		if (hoaDon.tinhTrangCanChuyen == undefined) return;
		var confirmText = (hoaDon.tinhTrangCanChuyen == 5 || hoaDon.tinhTrangCanChuyen == 6)?
			'Xác nhận chuyển trạng thái đơn hàng? Khi chuyển trạng thái này sẽ không thể chuyển lần nữa.' : 'Xác nhận chuyển trạng thái đơn hàng?';
		var confirm = $mdDialog.confirm()
			.title('Thông báo')
			.textContent(confirmText)
			.ok('Xác nhận')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/doi_tinh_trang_hoa_don', angular.toJson({
				idHoaDon: hoaDon.id,
				tinhTrangCanChuyen: hoaDon.tinhTrangCanChuyen,
				ghiChu: hoaDon.ghiChu
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					var quaTrinh = response.data.qua_trinh;
					quaTrinh.ngayDienRa = new Date().getTime();
					hoaDon.danhSachQuaTrinh.push(quaTrinh);
					hoaDon.quaTrinhGanNhat = $scope.getQuaTrinhGanNhat(hoaDon);
					$scope.showSimpleToast('Đổi trạng thái thành công.');
					console.log(hoaDon);
				}
				else $scope.showSimpleToast(notification);
			}, function(error) {
				console.log(error);
			});
		}, function() {
		});
	}

	$http.post('/FlowerShop/api/get_danh_sach_tinh_trang_hoa_don', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listTinhTrang = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.capNhatDanhSachHoaDon = function() {
		$scope.trang = [];
		$scope.soTrang = Math.ceil($scope.listHoaDon.length / $scope.soHoaDonMoiTrang);
		if ($scope.trangHienTai > $scope.soTrang) $scope.trangHienTai = $scope.soTrang;
		if ($scope.trangHienTai < 1) $scope.trangHienTai = 1;
		if ($scope.soTrang < 6) {
			for (var i = 0; i < $scope.soTrang; i++) {
				$scope.trang[i] = i + 1;
			}
		}
		else {
			if ($scope.trangHienTai < 3) {
				var trangBatDau = 1;
			}
			else if ($scope.trangHienTai <= $scope.soTrang - 2) {
				var trangBatDau = $scope.trangHienTai - 2;
			}
			else {
				var trangBatDau = $scope.soTrang - 4;
			}
			for (var i = 0; i < 5; i++) {
				$scope.trang[i] = trangBatDau;
				trangBatDau = trangBatDau + 1;
			}
		}
		var soLuongHoaDonTruoc = ($scope.trangHienTai - 1) * $scope.soHoaDonMoiTrang;
		$scope.listHoaDonCon = $scope.listHoaDon.slice(soLuongHoaDonTruoc, soLuongHoaDonTruoc + $scope.soHoaDonMoiTrang);
		$cookies.putObject('dashboard_order_list', {
			trangHienTai: $scope.trangHienTai,
			soHoaDonMoiTrang: $scope.soHoaDonMoiTrang,
			locHoaDon: $scope.hoaDonDaXem,
			maHoaDonCanTim: $scope.maHoaDonCanTim
		}, {
			path: '/FlowerShop'
		});
	}

	$scope.xemHoaDonTrang = function(item) {
		$scope.trangHienTai = item;
		$scope.capNhatDanhSachHoaDon();
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		$scope.capNhatDanhSachHoaDon();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		$scope.capNhatDanhSachHoaDon();
	}

	$scope.capNhatSoHoaDonMoiTrang = function() {
		if ($scope.soHoaDonMoiTrang < 5) return;
		$scope.capNhatDanhSachHoaDon();
	}

	$scope.denTrangThu = function() {
		if ($scope.trangHienTai < 1 || $scope.trangHienTai > $scope.soTrang) return;
		$scope.capNhatDanhSachHoaDon();
	}

	$scope.hienThiChiTietHoaDon = function(item) {
		item.hienThi = !item.hienThi;
		if (!item.daXem && item.hienThi) {
			$http.post('/FlowerShop/api/doi_trang_thai_hoa_don', angular.toJson({
				idHoaDon: item.id,
				daXem: true
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					item.daXem = true;
					$rootScope.soHoaDonChuaDoc = $filter('filter')($scope.listHoaDonGoc, {daXem: false}).length;
				} else {
					$scope.showSimpleToast(notification);
				}
			}, function(error) {
				console.log(error);
			});
		}
	}

	$scope.danhDauChuaDoc = function(item) {
		$http.post('/FlowerShop/api/doi_trang_thai_hoa_don', angular.toJson({
			idHoaDon: item.id,
			daXem: false
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				item.daXem = false;
				$rootScope.soHoaDonChuaDoc = $filter('filter')($scope.listHoaDonGoc, {daXem: false}).length;
			} else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.locDanhSachHoaDon = function() {
		if ($scope.hoaDonDaXem == undefined) {
			$scope.listHoaDon = $scope.listHoaDonGoc;
		}
		else {
			$scope.listHoaDon = $filter('filter')($scope.listHoaDonGoc, {daXem: $scope.hoaDonDaXem});
		}	
		$scope.capNhatDanhSachHoaDon();
	}

	$scope.timMaHoaDon = function() {
		$scope.listHoaDon = $filter('filter')($scope.listHoaDonGoc, {maHoaDon: $scope.maHoaDonCanTim});
		$scope.capNhatDanhSachHoaDon();
	}

	$scope.initiateHoaDon = function(hoaDon) {
		hoaDon.hienThi = false; 
		var date = new Date(hoaDon.ngayLap);
		//hoaDon.ngayLap = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds()));
		hoaDon.ngayLapDate = date;
		
		hoaDon.quaTrinhGanNhat = $scope.getQuaTrinhGanNhat(hoaDon);
	}

	$scope.getQuaTrinhGanNhat = function(hoaDon) {
		var recentDate = new Date(Math.max.apply(Math, hoaDon.danhSachQuaTrinh.map(function(o) { return o.ngayDienRa; })));
		var quaTrinhGanNhat = $filter('filter')(hoaDon.danhSachQuaTrinh, { ngayDienRa: recentDate.getTime() })[0];
		return quaTrinhGanNhat;
	}

	$scope.getGiaKhuyenMai = function(kieuSanPham, hoaDon) {
		var dsKhuyenMai = $filter('filter')(kieuSanPham.danhSachKhuyenMai, function(khuyenMai) {
			return (!khuyenMai.daXoa && hoaDon.ngayLap > khuyenMai.thoiGianBatDau && hoaDon.ngayLap < khuyenMai.thoiGianKetThuc)
		});
		var giaKhuyenMai = kieuSanPham.giaTien;
		dsKhuyenMai.forEach(function(value) {
			var phanTramGiam = value.phanTramGiam / 100;
			var giaTienSauKhiGiamToiDa = giaKhuyenMai - value.giaGiamToiDa;
			giaKhuyenMai = giaKhuyenMai * (1 - phanTramGiam);
			if (giaKhuyenMai < giaTienSauKhiGiamToiDa) giaKhuyenMai = giaTienSauKhiGiamToiDa;
		});
		return giaKhuyenMai;
	}

	$scope.tongTien = function(hoaDon) {
		var sum = 0;
		hoaDon.danhSachDonHang.forEach(function(value) {
			sum = sum + ($scope.getGiaKhuyenMai(value.kieuSanPham, hoaDon) * value.soLuong);
		});
		return sum;
	}

	$scope.xuatHoaDon = function(hoaDon) {
		var forms = new FormData();
		forms.append('id_hoa_don', hoaDon.id);
		$http.post('/FlowerShop/api/xuat_hoa_don', forms, {
			transformRequest : angular.identity,
			headers: {
				'content-type': undefined
			}
		}).then(function() {
			$window.location.href = '/FlowerShop/resources/files/hoa_don.doc'
		}, function(error) {
			console.log(error);
		});
	}
});