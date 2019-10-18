app.controller('ProductListController', function($http, $scope, $rootScope, $mdDialog, $mdToast, $location, $cookies, $filter, $window, Page) {
	Page.setTitle('Danh sách sản phẩm');

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
	
	$scope.soSanPhamMoiTrang = 10;
	$scope.trangHienTai = 1;
	$scope.boQuaDaXoa = true;

	$http.post('/FlowerShop/api/get_tat_ca_san_pham', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listSanPhamGoc = response.data;
		$scope.listSanPhamBoQuaDaXoa = $filter('filter')($scope.listSanPhamGoc, {daXoa: false});
		$scope.listSanPham = $scope.listSanPhamBoQuaDaXoa;
		var productListCookie = $cookies.getObject('dashboard_product_list');
		if (productListCookie == undefined) {
			$scope.trangHienTai = 1;
			$scope.soSanPhamMoiTrang = 10;
		}
		else {
			if (productListCookie.trangHienTai == undefined) {
				$scope.trangHienTai = 1;
			}
			else {
				$scope.trangHienTai = productListCookie.trangHienTai;
			}
			if (productListCookie.soSanPhamMoiTrang == undefined) {
				$scope.soSanPhamMoiTrang = 10;
			}
			else {
				$scope.soSanPhamMoiTrang = productListCookie.soSanPhamMoiTrang;
			}
			if ($rootScope.nhanVienHienTai.chucVu.id > 2 && productListCookie.boQuaDaXoa != undefined) {
				$scope.boQuaDaXoa = productListCookie.boQuaDaXoa;
				$scope.capNhatBoQuaDaXoa($scope.boQuaDaXoa, true);
			}
			if (productListCookie.sanPhamCanTim != undefined) {
				$scope.sanPhamCanTim = productListCookie.sanPhamCanTim;
				$scope.timSanPham(true);
			}
		}
		$scope.capNhatDanhSachSanPham();
	}, function(error) {
		console.log(error);
	});

	$scope.capNhatDanhSachSanPham = function() {
		$scope.trang = [];
		$scope.soTrang = Math.ceil($scope.listSanPham.length / $scope.soSanPhamMoiTrang);
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
		var soLuongSanPhamTruoc = ($scope.trangHienTai - 1) * $scope.soSanPhamMoiTrang;
		$scope.listSanPhamCon = $scope.listSanPham.slice(soLuongSanPhamTruoc, soLuongSanPhamTruoc + $scope.soSanPhamMoiTrang);
		$cookies.putObject('dashboard_product_list', {
			trangHienTai: $scope.trangHienTai,
			soSanPhamMoiTrang: $scope.soSanPhamMoiTrang,
			sanPhamCanTim: $scope.sanPhamCanTim,
			boQuaDaXoa: $scope.boQuaDaXoa
		}, {
			path: '/FlowerShop'
		});
	}

	$scope.capNhatBoQuaDaXoa = function(item, noRefresh) {
		if (item) {
			$scope.listSanPham = $scope.listSanPhamBoQuaDaXoa;
		}
		else {
			$scope.listSanPham = $scope.listSanPhamGoc;
		}
		$scope.boQuaDaXoa = item;
		if (noRefresh == undefined || !noRefresh) $scope.capNhatDanhSachSanPham();
	}

	$scope.xemSanPhamTrang = function(item) {
		$scope.trangHienTai = item;
		$scope.capNhatDanhSachSanPham();
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		$scope.capNhatDanhSachSanPham();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		$scope.capNhatDanhSachSanPham();
	}

	$scope.capNhatSoSanPhamMoiTrang = function() {
		if ($scope.soSanPhamMoiTrang < 5) return;
		$scope.capNhatDanhSachSanPham();
	}

	$scope.denTrangThu = function() {
		if ($scope.trangHienTai < 1 || $scope.trangHienTai > $scope.soTrang) return;
		$scope.capNhatDanhSachSanPham();
	}

	$scope.setMinAndMax = function(item) {
		item.danhSachKieuSanPham.forEach(function(value) {
			value.giaTien = $scope.getGiaKhuyenMai(value);
		});
		item.giaCaoNhat = Math.max.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }));
		item.giaThapNhat = Math.min.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }));
	}

	$scope.suaSanPham = function(item) {
		$location.path('/product_edit/' + item.id);
	}

	$scope.xoaSanPham = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xóa sản phẩm')
			.textContent('Bạn có chắc chắn muốn xóa sản phẩm này?')
			.ok('Chắc chắn')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/sua_san_pham', angular.toJson({
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
    				var index = $scope.listSanPhamBoQuaDaXoa.indexOf(item);
					if (index > -1) $scope.listSanPhamBoQuaDaXoa.splice(index, 1);
    				if ($scope.boQuaDaXoa) {
    					var index = $scope.listSanPham.indexOf(item);
						if (index > -1) $scope.listSanPham.splice(index, 1);
    				}
					$scope.capNhatDanhSachSanPham();
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

	$scope.timSanPham = function(noRefresh) {
		if ($scope.boQuaDaXoa) {
			$scope.listSanPham = $filter('filter')($scope.listSanPhamBoQuaDaXoa, $scope.sanPhamCanTim);
		}
		else {
			$scope.listSanPham = $filter('filter')($scope.listSanPhamGoc, $scope.sanPhamCanTim);
		}
		if (noRefresh == undefined || !noRefresh) $scope.capNhatDanhSachSanPham();
	}

	$scope.khuyenMaiHienTai = function(khuyenMai) {
		var current = new Date().getTime();
		return (current > khuyenMai.thoiGianBatDau && current < khuyenMai.thoiGianKetThuc && !khuyenMai.daXoa)
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

	$scope.thongKeSanPham = function() {
		$http.post('/FlowerShop/api/thong_ke_tat_ca_san_pham', {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function() {
			$window.location.href = '/FlowerShop/resources/files/tat_ca_san_pham.xls'
		}, function(error) {
			console.log(error);
		});
	}
});