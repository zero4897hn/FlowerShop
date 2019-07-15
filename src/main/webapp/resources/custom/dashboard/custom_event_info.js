app.controller('EventInfoController', function($http, $scope, $rootScope, $routeParams, $mdToast, $mdDialog, $filter, $cookies, $location, Page) {
	Page.setTitle('Thông tin khuyến mãi');

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

	var idKhuyenMai = $routeParams.idEvent;

	$scope.trangHienTai = 1;
	$scope.soKieuSanPhamMoiTrang = 10;
	
	$http.post('/FlowerShop/api/get_khuyen_mai', angular.toJson({
		idKhuyenMai: +idKhuyenMai
	}), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.khuyenMai = response.data;
		if ($scope.khuyenMai != 'null') {
			$scope.khuyenMai.thoiGianBatDau = new Date($scope.khuyenMai.thoiGianBatDau);
			$scope.khuyenMai.thoiGianKetThuc = new Date($scope.khuyenMai.thoiGianKetThuc);
			$scope.soTrang = Math.ceil($scope.khuyenMai.danhSachKieuSanPham.length / $scope.soKieuSanPhamMoiTrang);
			$scope.capNhatKieuSanPhamTrangHienTai();
		}
	}, function(error) {
		console.log(error);
	})

	$scope.capNhatKieuSanPhamTrangHienTai = function() {
		var soLuongKieuSanPhamTruoc = ($scope.trangHienTai - 1) * $scope.soKieuSanPhamMoiTrang;
		$scope.danhSachKieuSanPhamCon = $scope.khuyenMai.danhSachKieuSanPham.slice(soLuongKieuSanPhamTruoc, soLuongKieuSanPhamTruoc + $scope.soKieuSanPhamMoiTrang);
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		if ($scope.trangHienTai < 1) $scope.trangHienTai = 1;
		$scope.capNhatKieuSanPhamTrangHienTai();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		if ($scope.trangHienTai > $scope.soTrang) $scope.trangHienTai = $scope.soTrang;
		$scope.capNhatKieuSanPhamTrangHienTai();
	}

	$scope.suaKhuyenMai = function() {
		$location.path('/event_edit/' + $scope.khuyenMai.id);
	}

	$scope.xoaKhuyenMai = function() {
		var confirm = $mdDialog.confirm()
			.title('Xác nhận xóa khuyến mãi')
			.textContent('Bạn chắc chắn muốn xóa khuyến mãi này? Những sản phẩm có khuyến mãi này cũng sẽ bị ảnh hưởng.')
			.ok('Xác nhận')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/sua_khuyen_mai', angular.toJson({
				id: $scope.khuyenMai.id,
				daXoa: true
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$scope.showSimpleToast('Xóa thành công');
					if ($rootScope.nhanVienHienTai.chucVu.id < 3) {
						$cookies.remove('dashboard_event_id', {
							path: '/FlowerShop'	
						});
						$location.path('event_list');
					} else {
						$scope.khuyenMai.daXoa = true;
					}
				}
				else $scope.showSimpleToast(notification);
			}, function(error) {
				console.log(error);
			});
		}, function() {
			
		});
	}

	$scope.khoiPhucKhuyenMai = function() {
		$http.post('/FlowerShop/api/sua_khuyen_mai', angular.toJson({
			id: $scope.khuyenMai.id,
			daXoa: false
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				$scope.khuyenMai.daXoa = false;
				$scope.showSimpleToast('Khôi phục thành công.');
			}
			else $scope.showSimpleToast(notification);
		}, function(error) {
			console.log(error);
		});
	}

	$scope.xoaVinhVien = function() {
		var confirm = $mdDialog.confirm()
			.title('Xác nhận xóa khuyến mãi')
			.textContent('Bạn chắc chắn muốn xóa vĩnh viễn khuyến mãi này? Thao tác xong sẽ không thể hoàn tác.')
			.ok('Xác nhận')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/xoa_khuyen_mai', angular.toJson({
				idKhuyenMai: $scope.khuyenMai.id
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$scope.showSimpleToast('Xóa thành công');
					$cookies.remove('dashboard_event_id', {
						path: '/FlowerShop'	
					});
					$location.path('event_list');
				}
				else $scope.showSimpleToast(notification);
			}, function(error) {
				console.log(error);
			});
		}, function() {

		})
	}
});