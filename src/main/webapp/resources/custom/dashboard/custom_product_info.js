app.controller('ProductInfoController', function($http, $scope, $rootScope, $routeParams, $mdToast, $mdDialog, $location, $cookies, $filter, Page) {
	Page.setTitle('Thông tin sản phẩm');

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

	var idSanPham = $routeParams.idProduct;
	
	$http.post('/FlowerShop/api/get_san_pham', angular.toJson({
		idSanPham: +idSanPham
	}), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.sanPham = response.data;
	}, function(error) {
		console.log(error);
	})

	$scope.hienThiKieuSanPham = function(item) {
		item.hienThi = !item.hienThi;
	}

	$scope.suaSanPham = function() {
		$location.path('/product_edit/' + $scope.sanPham.id)
	}

	$scope.enableThemSoLuong = function() {
		$scope.isEnableAddQuantity = true;
	}

	$scope.xoaSanPham = function(item) {
		if ($rootScope.nhanVienHienTai.chucVu.id < 3) {
			var contextDialog = 'Bạn có chắc chắn muốn xóa sản phẩm này? Sau khi xóa sẽ không thể hoàn tác.';
		}
		else {
			var contextDialog = 'Bạn có chắc chắn muốn xóa sản phẩm này?';
		}
		var confirm = $mdDialog.confirm()
			.title('Xóa sản phẩm')
			.textContent(contextDialog)
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
    				$scope.showSimpleToast('Xóa thành công.');
    				if ($rootScope.nhanVienHienTai.chucVu.id < 3) {
	    				$location.path('/product_list');
    				} else {
    					item.daXoa = true;
    				}
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

	$scope.khoiPhucSanPham = function(item) {
		$http.post('/FlowerShop/api/sua_san_pham', angular.toJson({
			id: item.id,
			daXoa: false
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				item.daXoa = false;
			}
			else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.xoaVinhVien = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xóa sản phẩm')
			.textContent('Bạn có chắc chắn muốn xóa vĩnh viễn sản phẩm này? Thao tác xong sẽ không thể hoàn tác.')
			.ok('Chắc chắn')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/xoa_san_pham', angular.toJson({
				idSanPham: item.id
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
    			if (notification == 'success') {
    				$scope.showSimpleToast('Xóa thành công.');
    				$location.path('/product_list');
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

	$scope.themSoLuong = function(kieuSanPham, soLuongThem) {
		$http.post('/FlowerShop/api/cap_nhat_kieu_san_pham', angular.toJson({
			id: kieuSanPham.id,
			soLuong: kieuSanPham.soLuong + soLuongThem
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				kieuSanPham.soLuong = kieuSanPham.soLuong + soLuongThem;
				kieuSanPham.isEnableAddQuantity = false;
			}
			else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.raoBanSanPham = function() {
		var confirm = $mdDialog.confirm()
			.title('Rao bán sản phẩm')
			.textContent('Bạn muốn rao bán sản phẩm này? Mọi người có thể thấy sản phẩm của bạn và đặt hàng sản phẩm này.')
			.ok('Có')
			.cancel('Không');
		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/cap_nhat_trang_thai_san_pham', angular.toJson({
				idSanPham: $scope.sanPham.id,
				banRa: $scope.sanPham.banRa
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
    			if (notification == 'success') {
    				$scope.showSimpleToast('Rao bán thành công.');
    				$scope.sanPham.banRa = !$scope.sanPham.banRa;
    			}
    			else {
    				$scope.showSimpleToast(notification);
    			}
			}, function(error) {

			});
		}, function() {

		});
	}

	$scope.huyBanSanPham = function() {
		var confirm = $mdDialog.confirm()
			.title('Hủy bán sản phẩm')
			.textContent('Bạn có chắc chắn muốn hủy bán? Mọi người sẽ không thể nhìn thấy sản phẩm này và không thể đặt hàng sản phẩm.')
			.ok('Có')
			.cancel('Không');
		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/cap_nhat_trang_thai_san_pham', angular.toJson({
				idSanPham: $scope.sanPham.id,
				banRa: $scope.sanPham.banRa
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
    			if (notification == 'success') {
    				$scope.showSimpleToast('Hủy bán thành công.');
    				$scope.sanPham.banRa = !$scope.sanPham.banRa;
    			}
    			else {
    				$scope.showSimpleToast(notification);
    			}
			}, function(error) {

			});
		}, function() {

		});
	}

	$scope.khuyenMaiHienTai = function(khuyenMai) {
		var current = new Date().getTime();
		return (current > khuyenMai.thoiGianBatDau && current < khuyenMai.thoiGianKetThuc && !khuyenMai.daXoa)
	}

	$scope.coKhuyenMai = function(kieuSanPham) {
		var dsKhuyenMai = $filter('filter')(kieuSanPham.danhSachKhuyenMai, $scope.khuyenMaiHienTai);
		return dsKhuyenMai.length > 0;
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
});