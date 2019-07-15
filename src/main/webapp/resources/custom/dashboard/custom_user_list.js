app.controller('UserListController', function($http, $scope, $mdToast, $mdDialog, $filter, $cookies, $location, $window, Page) {
	Page.setTitle('Danh sách người dùng');

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

	$scope.trangHienTai = 1;
	$scope.soTaiKhoanMoiTrang = 10;
	
	$http.post('/FlowerShop/api/get_danh_sach_tai_khoan', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listTaiKhoanGoc = response.data;
		$scope.listTaiKhoan = $scope.listTaiKhoanGoc;
		var userListCookie = $cookies.getObject('dashboard_user_list');
		if (userListCookie != undefined) {
			if (userListCookie.trangHienTai != undefined) {
				$scope.trangHienTai = userListCookie.trangHienTai;
			}
			if (userListCookie.soTaiKhoanMoiTrang != undefined) {
				$scope.soTaiKhoanMoiTrang = userListCookie.soTaiKhoanMoiTrang;
			}
			if (userListCookie.locTaiKhoanId != undefined) {
				$scope.loaiTaiKhoan = userListCookie.locTaiKhoanId;
				console.log($scope.loaiTaiKhoan);
				$scope.listTaiKhoan = $filter('filter')($scope.listTaiKhoanGoc, {nhanVien: {chucVu: {id: +$scope.loaiTaiKhoan}}});
			}
			if (userListCookie.taiKhoanCanTim != undefined) {
				$scope.taiKhoanCanTim = userListCookie.taiKhoanCanTim;
				$scope.listTaiKhoan = $filter('filter')($scope.listTaiKhoanGoc, $scope.taiKhoanCanTim);
			}
		}
		$scope.capNhatDanhSachTaiKhoan();
	}, function(error) {
		console.log(error);
	});

	$scope.capNhatDanhSachTaiKhoan = function() {
		$scope.trang = [];
		$scope.soTrang = Math.ceil($scope.listTaiKhoan.length / $scope.soTaiKhoanMoiTrang);
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
		var soLuongTaiKhoanTruoc = ($scope.trangHienTai - 1) * $scope.soTaiKhoanMoiTrang;
		$scope.listTaiKhoanCon = $scope.listTaiKhoan.slice(soLuongTaiKhoanTruoc, soLuongTaiKhoanTruoc + $scope.soTaiKhoanMoiTrang);
		$cookies.putObject('dashboard_user_list', {
			trangHienTai: $scope.trangHienTai,
			soTaiKhoanMoiTrang: $scope.soTaiKhoanMoiTrang,
			locTaiKhoanId: $scope.loaiTaiKhoan,
			taiKhoanCanTim: $scope.taiKhoanCanTim
		}, {
			path: '/FlowerShop'
		});
	}

	$scope.xemTaiKhoanTrang = function(item) {
		$scope.trangHienTai = item;
		$scope.capNhatDanhSachTaiKhoan();
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		$scope.capNhatDanhSachTaiKhoan();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		$scope.capNhatDanhSachTaiKhoan();
	}

	$scope.capNhatSoTaiKhoanMoiTrang = function() {
		if ($scope.soTaiKhoanMoiTrang < 5) return;
		$scope.capNhatDanhSachTaiKhoan();
	}

	$scope.denTrangThu = function() {
		if ($scope.trangHienTai < 1 || $scope.trangHienTai > $scope.soTrang) return;
		$scope.capNhatDanhSachTaiKhoan();
	}
	
	$scope.showDetail = function(item) {
		item.show = !item.show;
	};
	
	$scope.removeNhanVien = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xác nhận xóa nhân viên')
			.textContent('Nhân viên và tài khoản của người đó sẽ bị xóa khỏi hệ thống và sẽ không thể hoàn tác, bạn chắc chắn chứ?')
			.ariaLabel('Xóa nhân viên')
			.ok('Chắc chắn')
			.cancel('Không');
		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/xoa_tai_khoan_nhan_vien', angular.toJson({
				idDangNhap: item.id
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notice = response.data.notice;
				if (notice == 'success') {
					var index = $scope.listTaiKhoan.indexOf(item);
					$scope.listTaiKhoan.splice(index, 1);
					$scope.capNhatDanhSachTaiKhoan();
					$scope.showSimpleToast('Xóa thành công.');
				}
				else {
					$scope.showSimpleToast(notice);
				}
			}, function(error) {
				console.log(error);
			});
		}, function() {

		});
	};

	$scope.locDanhSachTaiKhoan = function() {
		if ($scope.loaiTaiKhoan == undefined) {
			$scope.listTaiKhoan = $scope.listTaiKhoanGoc;
		}
		else {
			$scope.listTaiKhoan = $filter('filter')($scope.listTaiKhoanGoc, {nhanVien: {chucVu: {id: +$scope.loaiTaiKhoan}}});
		}
		$scope.capNhatDanhSachTaiKhoan();
	}

	$scope.timTaiKhoan = function() {
		$scope.listTaiKhoan = $filter('filter')($scope.listTaiKhoanGoc, $scope.taiKhoanCanTim);
		$scope.capNhatDanhSachTaiKhoan();
	}

	function RemoveUserController($scope, $mdDialog) {
		$scope.hide = function() {
			$mdDialog.hide();
		};

		$scope.cancel = function() {
			$mdDialog.cancel();
		};

		$scope.updateUser = function(item) {
			$mdDialog.hide(item);
		};
	}

	$scope.thongKeDanhSachNguoiDung = function() {
		var forms = new FormData();
		forms.append('loai_nguoi_dung', $scope.loaiTaiKhoan);
		$http.post('/FlowerShop/api/thong_ke_nguoi_dung', forms, {
			transformRequest : angular.identity,
			headers: {
				'content-type': undefined
			}
		}).then(function() {
			$window.location.href = '/FlowerShop/resources/files/nguoi_dung.xls'
		}, function(error) {
			console.log(error);
		});
	}
});