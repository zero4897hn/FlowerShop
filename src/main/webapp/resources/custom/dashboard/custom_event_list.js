app.controller('EventListController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $filter, $cookies, $location, Page) {
	Page.setTitle('Danh sách khuyến mãi');

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

	$scope.boQuaDaXoa = true;
	$scope.loaiSuKien = 'all';

	$http.post('/FlowerShop/api/get_danh_sach_khuyen_mai', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listKhuyenMaiGoc = response.data;
		$scope.listKhuyenMaiBoQuaDaXoa = $filter('filter')($scope.listKhuyenMaiGoc, {daXoa: false});
		$scope.listKhuyenMai = $scope.listKhuyenMaiBoQuaDaXoa;
		var eventListCookie = $cookies.getObject('dashboard_product_list');
		if (eventListCookie == undefined) {
			$scope.trangHienTai = 1;
			$scope.soKhuyenMaiMoiTrang = 10;
		}
		else {
			if (eventListCookie.trangHienTai == undefined) {
				$scope.trangHienTai = 1;
			}
			else {
				$scope.trangHienTai = eventListCookie.trangHienTai;
			}
			if (eventListCookie.soKhuyenMaiMoiTrang == undefined) {
				$scope.soKhuyenMaiMoiTrang = 10;
			}
			else {
				$scope.soKhuyenMaiMoiTrang = eventListCookie.soKhuyenMaiMoiTrang;
			}
			if ($rootScope.nhanVienHienTai.chucVu.id > 2 && eventListCookie.boQuaDaXoa != undefined) {
				$scope.boQuaDaXoa = eventListCookie.boQuaDaXoa;
				$scope.capNhatBoQuaDaXoa($scope.boQuaDaXoa, true);
			}
			if (eventListCookie.tenKhuyenMaiCanTim != undefined) {
				$scope.tenKhuyenMaiCanTim = eventListCookie.tenKhuyenMaiCanTim;
				$scope.timKhuyenMai(true);
			}
		}
		$scope.capNhatDanhSachKhuyenMai();
	}, function(error) {
		console.log(error);
	});

	$scope.capNhatBoQuaDaXoa = function(item, noRefresh) {
		if (item) {
			$scope.listKhuyenMai = $scope.listKhuyenMaiBoQuaDaXoa;
		}
		else {
			$scope.listKhuyenMai = $scope.listKhuyenMaiGoc;
		}
		$scope.boQuaDaXoa = item;
		if (noRefresh == undefined || !noRefresh) $scope.capNhatDanhSachKhuyenMai();
	}

	$scope.longToDate = function(item) {
		item.thoiGianBatDau = new Date(item.thoiGianBatDau);
		item.thoiGianKetThuc = new Date(item.thoiGianKetThuc);
	}

	$scope.capNhatDanhSachKhuyenMai = function() {
		$scope.trang = [];
		$scope.soTrang = Math.ceil($scope.listKhuyenMai.length / $scope.soKhuyenMaiMoiTrang);
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
		var soLuongKhuyenMaiTruoc = ($scope.trangHienTai - 1) * $scope.soKhuyenMaiMoiTrang;
		$scope.listKhuyenMaiCon = $scope.listKhuyenMai.slice(soLuongKhuyenMaiTruoc, soLuongKhuyenMaiTruoc + $scope.soKhuyenMaiMoiTrang);
		$cookies.putObject('dashboard_event_list', {
			trangHienTai: $scope.trangHienTai,
			soKhuyenMaiMoiTrang: $scope.soKhuyenMaiMoiTrang,
			tenKhuyenMaiCanTim: $scope.tenKhuyenMaiCanTim,
			boQuaDaXoa: $scope.boQuaDaXoa
		}, {
			path: '/FlowerShop'
		});
	}

	$scope.xemKhuyenMaiTrang = function(item) {
		$scope.trangHienTai = item;
		$scope.capNhatDanhSachKhuyenMai();
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		$scope.capNhatDanhSachKhuyenMai();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		$scope.capNhatDanhSachKhuyenMai();
	}

	$scope.capNhatSoKhuyenMaiMoiTrang = function() {
		if ($scope.soKhuyenMaiMoiTrang < 5) return;
		$scope.capNhatDanhSachKhuyenMai();
	}

	$scope.denTrangThu = function() {
		if ($scope.trangHienTai < 1 || $scope.trangHienTai > $scope.soTrang) return;
		$scope.capNhatDanhSachKhuyenMai();
	}

	$scope.timKhuyenMai = function(noRefresh) {
		if ($scope.boQuaDaXoa) {
			$scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiBoQuaDaXoa, {tenKhuyenMai: $scope.tenKhuyenMaiCanTim});
		}
		else {
			$scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiGoc, {tenKhuyenMai: $scope.tenKhuyenMaiCanTim});
		}
		if (noRefresh == undefined || !noRefresh) $scope.capNhatDanhSachKhuyenMai();
	}

	$scope.suaKhuyenMai = function(item) {
		$location.path('/event_edit/' + item.id);
	}

	$scope.xoaKhuyenMai = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xác nhận xóa khuyến mãi')
			.textContent('Bạn chắc chắn muốn xóa khuyến mãi này? Những sản phẩm có khuyến mãi này cũng sẽ bị ảnh hưởng.')
			.ok('Xác nhận')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/sua_khuyen_mai', angular.toJson({
				id: item.id,
				daXoa: true
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
    			if (notification == 'success') {
    				item.daXoa = true;
    				var index = $scope.listKhuyenMaiBoQuaDaXoa.indexOf(item);
					if (index > -1) $scope.listKhuyenMaiBoQuaDaXoa.splice(index, 1);
    				if ($scope.boQuaDaXoa) {
    					var index = $scope.listKhuyenMai.indexOf(item);
						if (index > -1) $scope.listKhuyenMai.splice(index, 1);
    				}
					$scope.capNhatDanhSachKhuyenMai();
    				$scope.showSimpleToast('Xóa thành công.');
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

	var currentTime = new Date().getTime();

	$scope.locDanhSachKhuyenMai = function() {
		if ($scope.loaiSuKien == 'all') {
			$scope.capNhatBoQuaDaXoa($scope.boQuaDaXoa, true);
		}
		if ($scope.loaiSuKien == 'past') {
			if ($scope.boQuaDaXoa) $scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiBoQuaDaXoa, khuyenMaiTruocDay);
			else $scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiGoc, khuyenMaiTruocDay);
		}
		if ($scope.loaiSuKien == 'present') {
			if ($scope.boQuaDaXoa) $scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiBoQuaDaXoa, khuyenMaiHienTai);
			else $scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiGoc, khuyenMaiHienTai);
		}
		if ($scope.loaiSuKien == 'future') {
			if ($scope.boQuaDaXoa) $scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiBoQuaDaXoa, khuyenMaiSauNay);
			else $scope.listKhuyenMai = $filter('filter')($scope.listKhuyenMaiGoc, khuyenMaiSauNay);
		}
		$scope.capNhatDanhSachKhuyenMai();
	}

	function khuyenMaiHienTai(khuyenMai) {
		return (currentTime > khuyenMai.thoiGianBatDau && currentTime < khuyenMai.thoiGianKetThuc);
	}

	function khuyenMaiTruocDay(khuyenMai) {
		return currentTime > khuyenMai.thoiGianKetThuc;
	}

	function khuyenMaiSauNay(khuyenMai) {
		return currentTime < khuyenMai.thoiGianBatDau;
	}
});