app.controller('ProductListByCategoryController', function($http, $scope, $mdToast, $location, $mdDialog, $cookies, $filter, $window, Page) {
	Page.setTitle('Danh sách sản phẩm theo danh mục');

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

	$scope.listSanPham = true;
	
	$http.post('/FlowerShop/api/get_tat_ca_danh_muc', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listDanhMuc = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.initiateDanhMuc = function(danhMuc) {
		danhMuc.hienThiDanhSachSanPham = false; 
		danhMuc.chinhSuaDanhMuc = false;
		danhMuc.danhSachSanPhamGoc = danhMuc.danhSachSanPham;
		danhMuc.danhSachSanPham = $filter('filter')(danhMuc.danhSachSanPhamGoc, {daXoa: false});
		danhMuc.boQuaDaXoa = true;
	}

	$scope.setMinAndMax = function(item) {
		item.giaCaoNhat = Math.max.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }))
		item.giaThapNhat = Math.min.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }))
	}

	$scope.capNhatBoQuaDaXoa = function(danhMuc) {
		if (danhMuc.boQuaDaXoa) {
			danhMuc.danhSachSanPham = $filter('filter')(danhMuc.danhSachSanPhamGoc, {daXoa: false});
		}
		else {
			danhMuc.danhSachSanPham = danhMuc.danhSachSanPhamGoc;
		}
	}
	
	$scope.hienThiSanPham = function(item) {
		item.hienThiDanhSachSanPham = !item.hienThiDanhSachSanPham;
	}
	
	$scope.batDauSuaDanhMuc = function(item) {
		item.chinhSuaDanhMuc = true;
	}
	
	$scope.ketThucSuaDanhMuc = function(item) {
		$http.post('/FlowerShop/api/cap_nhat_danh_muc', angular.toJson({
			id: item.id,
			tenDanhMuc: item.tenDanhMuc
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			item.chinhSuaDanhMuc = false;
			$scope.showSimpleToast(response.data.notice);
		}, function(error) {
			console.log(error);
		});
	}
	
	$scope.xoaDanhMuc = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xác nhận xóa danh mục')
			.textContent('Bạn có chắc chắn muốn xóa danh mục này không?')
			.ariaLabel('Xóa danh mục')
			.ok('Chắc chắn')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/xoa_danh_muc', angular.toJson({
				id: item.id,
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					var index = $scope.listDanhMuc.indexOf(item);
					$scope.listDanhMuc.splice(index, 1);
					$scope.showSimpleToast('Xóa danh mục thành công.');
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

	$scope.themDanhMuc = function(index) {
		$mdDialog.show({
			controller: DialogController,
			templateUrl: '/FlowerShop/resources/webdata/dashboard/add_new_category.jsp',
			clickOutsideToClose: true,
			fullscreen: $scope.customFullscreen // Only for -xs, -sm breakpoints.
		})
		.then(function(tenDanhMuc) {
			$http.post('/FlowerShop/api/them_danh_muc', angular.toJson({
				tenDanhMuc: tenDanhMuc
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$scope.listDanhMuc.push(response.data.new_category);
					$scope.showSimpleToast('Thêm danh mục thành công.');
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

	function DialogController($scope, $mdDialog) {
		$scope.hide = function() {
			$mdDialog.hide();
		};

		$scope.cancel = function() {
			$mdDialog.cancel();
		};

		$scope.themDanhMuc = function(tenDanhMuc) {
			$mdDialog.hide(tenDanhMuc);
		};
	}

	$scope.suaSanPham = function(item) {
		$location.path('/product_edit/' + item.id);
	}

	$scope.xoaSanPham = function(item, danhMuc) {
		var confirm = $mdDialog.confirm()
			.title('Xóa sản phẩm')
			.textContent('Bạn có chắc chắn muốn xóa sản phẩm này? Sau khi xóa sẽ không thể hoàn tác.')
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
    				if (danhMuc.boQuaDaXoa) {
						var index = danhMuc.danhSachSanPham.indexOf(item);
						if (index > -1) danhMuc.danhSachSanPham.splice(index, 1);
					}
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

	$scope.khuyenMaiHienTai = function(khuyenMai) {
		var current = new Date().getTime();
		return (current > khuyenMai.thoiGianBatDau && current < khuyenMai.thoiGianKetThuc)
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

	$scope.thongKeDanhSachSanPham = function(danhMuc) {
		var forms = new FormData();
		forms.append('id_danh_muc', danhMuc.id);
		$http.post('/FlowerShop/api/thong_ke_san_pham', forms, {
			transformRequest : angular.identity,
			headers: {
				'content-type': undefined
			}
		}).then(function() {
			$window.location.href = '/FlowerShop/resources/files/san_pham.xls'
		}, function(error) {
			console.log(error);
		});
	}
});