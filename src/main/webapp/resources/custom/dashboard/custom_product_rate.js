app.controller('ProductRateController', function($scope, $http, $mdToast, $mdDialog, $cookies, $filter, $location, $rootScope, Page) {
	Page.setTitle('Đánh giá sản phẩm');

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

	$scope.soSaoToiDa = [1, 2, 3, 4, 5];
	$scope.boQuaDaXoa = true;

	$http.post('/FlowerShop/api/get_danh_sach_danh_gia', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listDanhGiaGoc = response.data;
		$scope.listDanhGiaBoQuaDaXoa = $filter('filter')($scope.listDanhGiaGoc, {daXoa: false});
		$scope.listDanhGia = $scope.listDanhGiaGoc;
		var rateProductCookie = $cookies.getObject('dashboard_rate_product');
		if (rateProductCookie == undefined) {
			$scope.trangHienTai = 1;
			$scope.soDanhGiaMoiTrang = 10;
		}
		else {
			if (rateProductCookie.trangHienTai == undefined) {
				$scope.trangHienTai = 1;
			}
			else {
				$scope.trangHienTai = rateProductCookie.trangHienTai;
			}
			if (rateProductCookie.soDanhGiaMoiTrang == undefined) {
				$scope.soDanhGiaMoiTrang = 10;
			}
			else {
				$scope.soDanhGiaMoiTrang = rateProductCookie.soDanhGiaMoiTrang;
			}
			if ($rootScope.nhanVienHienTai.chucVu.id > 2 && rateProductCookie.boQuaDaXoa != undefined) {
				$scope.boQuaDaXoa = rateProductCookie.boQuaDaXoa;
				$scope.capNhatBoQuaDaXoa($scope.boQuaDaXoa, true);
			}
			if (rateProductCookie.locDanhGia != undefined) {
				$scope.danhGiaDaXem = orderListCookie.locDanhGia;
				$scope.locDanhSachDanhGia(true);
			}
			if (rateProductCookie.danhGiaCanTim != undefined) {
				$scope.danhGiaCanTim = rateProductCookie.danhGiaCanTim;
				$scope.timDanhGia(true);
			}
		}
		$scope.capNhatDanhSachDanhGia();
	}, function(error) {
		console.log(error);
	});

	$scope.initiateDanhGia = function(danhGia) {
		if (danhGia != undefined) {
			danhGia.hienThi = false;
			danhGia.hienTraLoi = false;
			danhGia.anHienTraLoi = 'Hiện trả lời';
			danhGia.anHienTraLoiDaXoa = 'Hiện trả lời đã xóa';
			danhGia.danhSachTraLoiDanhGiaGoc = danhGia.danhSachTraLoiDanhGia;
			danhGia.danhSachTraLoiDanhGia = $filter('filter')(danhGia.danhSachTraLoiDanhGiaGoc, {daXoa: false});
		}
	}

	$scope.capNhatBoQuaDaXoa = function(item, noRefresh) {
		if (item) {
			$scope.listDanhGia = $scope.listDanhGiaBoQuaDaXoa;
		}
		else {
			$scope.listDanhGia = $scope.listDanhGiaGoc;
		}
		$scope.boQuaDaXoa = item;
		if (noRefresh == undefined || !noRefresh) $scope.capNhatDanhSachDanhGia();
	}

	$scope.capNhatDanhSachDanhGia = function() {
		$scope.trang = [];
		$scope.soTrang = Math.ceil($scope.listDanhGia.length / $scope.soDanhGiaMoiTrang);
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
		var soLuongDanhGiaTruoc = ($scope.trangHienTai - 1) * $scope.soDanhGiaMoiTrang;
		$scope.listDanhGiaCon = $scope.listDanhGia.slice(soLuongDanhGiaTruoc, soLuongDanhGiaTruoc + $scope.soDanhGiaMoiTrang);
		$cookies.putObject('dashboard_rate_product', {
			trangHienTai: $scope.trangHienTai,
			soDanhGiaMoiTrang: $scope.soDanhGiaMoiTrang,
			locDanhGia: $scope.danhGiaDaXem,
			danhGiaCanTim: $scope.danhGiaCanTim,
			boQuaDaXoa: $scope.boQuaDaXoa
		}, {
			path: '/FlowerShop'
		});
	}

	$scope.xemDanhGiaTrang = function(item) {
		$scope.trangHienTai = item;
		$scope.capNhatDanhSachDanhGia();
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		$scope.capNhatDanhSachDanhGia();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		$scope.capNhatDanhSachDanhGia();
	}

	$scope.capNhatSoDanhGiaMoiTrang = function() {
		if ($scope.soDanhGiaMoiTrang < 5) return;
		$scope.capNhatDanhSachDanhGia();
	}

	$scope.denTrangThu = function() {
		if ($scope.trangHienTai < 1 || $scope.trangHienTai > $scope.soTrang) return;
		$scope.capNhatDanhSachDanhGia();
	}

	$scope.traLoi = function(item) {
		if (!item.noiDungTraLoi) {
			$scope.showSimpleToast('Bạn chưa điền phản hồi.');
			return;
		}
		var data = {
			idNhanVien: $rootScope.nhanVienHienTai.id,
			idDanhGia: item.id,
			noiDung: item.noiDungTraLoi
		};
		$http.post('/FlowerShop/api/tra_loi_danh_gia', angular.toJson(data), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				item.danhSachTraLoiDanhGia.push(response.data.traLoi);
			}
			else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.capNhatAnHienDanhSachDaXoa = function(danhGia) {
		if (danhGia.anHienTraLoiDaXoa == 'Hiện trả lời đã xóa') {
			danhGia.danhSachTraLoiDanhGia = danhGia.danhSachTraLoiDanhGiaGoc;
			danhGia.anHienTraLoiDaXoa = 'Ẩn trả lời đã xóa';
		}
		else {
			danhGia.danhSachTraLoiDanhGia = $filter('filter')(danhGia.danhSachTraLoiDanhGiaGoc, {daXoa: false});
			danhGia.anHienTraLoiDaXoa = 'Hiện trả lời đã xóa';
		}
	}

	$scope.xoaTraLoi = function(traLoi, danhGia) {
		var confirm = $mdDialog.confirm()
			.title('Xóa trả lời đánh giá')
			.textContent('Xác nhận xóa trả lời đánh giá này?')
			.ok('Xác nhận')
			.cancel('Không');
		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/cap_nhat_tra_loi_danh_gia', angular.toJson({
				idTraLoi: traLoi.id,
				daXoa: true
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					traLoi.daXoa = true;
					if (danhGia.anHienTraLoiDaXoa == 'Hiện trả lời đã xóa') {
						var index = danhGia.danhSachTraLoiDanhGia.indexOf(traLoi);
						if (index > -1) danhGia.danhSachTraLoiDanhGia.splice(index, 1);
					}
					$scope.showSimpleToast('Xóa thành công.');
				}
				else $scope.showSimpleToast(notification);
			}, function(error) {
				console.log(error);
			})
		}, function() {

		});
	}

	$scope.hoiPhucTraLoi = function(traLoi, danhGia) {
		$http.post('/FlowerShop/api/cap_nhat_tra_loi_danh_gia', angular.toJson({
			idTraLoi: traLoi.id,
			daXoa: false
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				traLoi.daXoa = false;
				$scope.showSimpleToast('Hồi phục thành công.');
			}
			else $scope.showSimpleToast(notification);
		}, function(error) {
			console.log(error);
		})
	}

	$scope.xoaVinhVienTraLoi = function(traLoi, danhGia) {
		var confirm = $mdDialog.confirm()
			.title('Xóa trả lời đánh giá')
			.textContent('Xác nhận xóa vĩnh viễn trả lời đánh giá này? Thao tác xong sẽ không thể hoàn tác.')
			.ok('Xác nhận')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/xoa_tra_loi_danh_gia', angular.toJson({
				idTraLoi: traLoi.id,
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					var index = danhGia.danhSachTraLoiDanhGia.indexOf(traLoi);
					if (index > -1) danhGia.danhSachTraLoiDanhGia.splice(index, 1);
					var index = danhGia.danhSachTraLoiDanhGiaGoc.indexOf(traLoi);
					if (index > -1) danhGia.danhSachTraLoiDanhGiaGoc.splice(index, 1);
					$scope.showSimpleToast('Xóa vĩnh viễn thành công');
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

	$scope.danhDauChuaDoc = function(item) {
		$http.post('/FlowerShop/api/cap_nhat_danh_gia', angular.toJson({
			id: item.id,
			daXem: false
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				item.daXem = false;
				$rootScope.soDanhGiaChuaDoc = $filter('filter')($scope.listDanhGiaGoc, {daXem: false, daXoa: false}).length;
			}
			else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.hienThiChiTietDanhGia = function(item) {
		item.hienThi = !item.hienThi;
		if (!item.daXem && item.hienThi) {
			$http.post('/FlowerShop/api/cap_nhat_danh_gia', angular.toJson({
				id: item.id,
				daXem: true
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					item.daXem = true;
					$rootScope.soDanhGiaChuaDoc = $filter('filter')($scope.listDanhGiaGoc, {daXem: false, daXoa: false}).length;
				}
				else {
					$scope.showSimpleToast(notification);
				}
			}, function(error) {
				console.log(error);
			});
		}
	}

	

	$scope.timDanhGia = function(noRefresh) {
		$scope.danhGiaDaXem = undefined;
		if ($scope.boQuaDaXoa) $scope.listDanhGia = $filter('filter')($scope.listDanhGiaBoQuaDaXoa, $scope.danhGiaCanTim);
		else $scope.listDanhGia = $filter('filter')($scope.listDanhGiaGoc, $scope.danhGiaCanTim);
		if (noRefresh == undefined || !noRefresh) $scope.capNhatDanhSachDanhGia();
	}

	$scope.capNhatAnHienTraLoi = function(item) {
		if (item.hienTraLoi) {
			item.anHienTraLoi = 'Hiện trả lời';
		}
		else {
			item.anHienTraLoi = 'Ẩn trả lời';
		}
		item.hienTraLoi = !item.hienTraLoi;
	}

	$scope.locDanhSachDanhGia = function(noRefresh) {
		if ($scope.danhGiaDaXem == undefined) {
			if ($scope.boQuaDaXoa) $scope.listDanhGia = $scope.listDanhGiaBoQuaDaXoa;
			else $scope.listDanhGia = $scope.listDanhGiaGoc;
		}
		else {
			if ($scope.boQuaDaXoa) $scope.listDanhGia = $filter('filter')($scope.listDanhGiaBoQuaDaXoa, {daXem: $scope.danhGiaDaXem});
			else $scope.listDanhGia = $filter('filter')($scope.listDanhGiaGoc, {daXem: $scope.danhGiaDaXem});
		}	
		if (noRefresh == undefined || !noRefresh) $scope.capNhatDanhSachDanhGia();
	}

	$scope.xoaDanhGia = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xóa đánh giá')
			.textContent('Bạn có chắc chắn muốn xóa đánh giá này?')
			.ok('Chắc chắn')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/cap_nhat_danh_gia', angular.toJson({
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
    				var index = $scope.listDanhGiaBoQuaDaXoa.indexOf(item);
					if (index > -1) $scope.listDanhGiaBoQuaDaXoa.splice(index, 1);
    				if ($scope.boQuaDaXoa) {
    					var index = $scope.listDanhGia.indexOf(item);
						if (index > -1) $scope.listDanhGia.splice(index, 1);
    				}
					$scope.capNhatDanhSachDanhGia();
					$rootScope.soDanhGiaChuaDoc = $filter('filter')($scope.listDanhGiaGoc, {daXem: false, daXoa: false}).length;
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

	$scope.khoiPhucDanhGia = function(item) {
		$http.post('/FlowerShop/api/cap_nhat_danh_gia', angular.toJson({
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
				var index = $scope.listDanhGiaBoQuaDaXoa.indexOf(item);
				if (index > -1) $scope.listDanhGiaBoQuaDaXoa.splice(index, 1);
				if ($scope.boQuaDaXoa) {
					var index = $scope.listDanhGia.indexOf(item);
					if (index > -1) $scope.listDanhGia.splice(index, 1);
				}
				$scope.capNhatDanhSachDanhGia();
				$rootScope.soDanhGiaChuaDoc = $filter('filter')($scope.listDanhGiaGoc, {daXem: false, daXoa: false}).length;
				$scope.showSimpleToast('Khôi phục thành công.');
			}
			else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.xoaVinhVienDanhGia = function(item) {
		var confirm = $mdDialog.confirm()
			.title('Xóa vĩnh viễn đánh giá')
			.textContent('Bạn có chắc chắn muốn xóa vĩnh viễn đánh giá này? Thao tác xong không thể hoàn tác.')
			.ok('Chắc chắn')
			.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/xoa_danh_gia', angular.toJson({
				id: item.id
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					var index = $scope.listDanhGiaBoQuaDaXoa.indexOf(item);
					if (index > -1) $scope.listDanhGiaBoQuaDaXoa.splice(index, 1);
					var index = $scope.listDanhGia.indexOf(item);
					if (index > -1) $scope.listDanhGia.splice(index, 1);
					$scope.capNhatDanhSachDanhGia();
					$rootScope.soDanhGiaChuaDoc = $filter('filter')($scope.listDanhGiaGoc, {daXem: false, daXoa: false}).length;
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


});