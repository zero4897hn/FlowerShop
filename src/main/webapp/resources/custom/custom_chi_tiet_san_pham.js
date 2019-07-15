app.controller('ChiTietSanPhamController', function($http, $scope, $rootScope, $routeParams, $cookies, $filter, $mdToast, $location, $window, $mdDialog) {
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

	$scope.danhGiaMoi = {};

	$scope.danhGiaMoi.soSao = 5;

	var idSanPham = $routeParams.idSanPham;

	$scope.soLuong = 1;

	$scope.sanPhamNotFound = false;
	
	$http.post('/FlowerShop/api/get_san_pham', angular.toJson({
		idSanPham: +idSanPham
	}), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.sanPham = response.data;
		if ($scope.sanPham != 'null') {
			$scope.radioKieuSanPham = $scope.sanPham.danhSachKieuSanPham[0].id;
			$scope.sanPham.giaTien = $scope.sanPham.danhSachKieuSanPham[0].giaTien;
			$scope.sanPham.danhSachDanhGia = $filter('filter')($scope.sanPham.danhSachDanhGia, {daXoa: false});
			$scope.soLuongToiDa = $scope.sanPham.danhSachKieuSanPham[0].soLuong;
		}
	}, function(error) {
		console.log(error);
	});

	$scope.initiateDanhGia = function(danhGia) {
		danhGia.hienTraLoi = false; 
		danhGia.anHienTraLoi = 'Hiện trả lời';
		danhGia.danhSachTraLoiDanhGia = $filter('filter')(danhGia.danhSachTraLoiDanhGia, {daXoa: false});
	}

	$scope.capNhatKieuSanPham = function(item) {
		$scope.sanPham.giaTien = $scope.sanPham.danhSachKieuSanPham[item].giaTien;
		$scope.radioKieuSanPham = $scope.sanPham.danhSachKieuSanPham[item].id;
		$scope.soLuongToiDa = $scope.sanPham.danhSachKieuSanPham[item].soLuong;
	}

	$scope.themVaoGioHang = function() {
		var gioHangCookie = $cookies.get('gio_hang_cookie');
		if (gioHangCookie == undefined || !gioHangCookie) {
			listGioHang = [];
		} else {
			listGioHang = angular.fromJson(gioHangCookie);
		}

		var objectInlist = $filter('filter')(listGioHang, {idSanPham: $scope.radioKieuSanPham})[0];

		if (objectInlist == undefined) {
			listGioHang.push({
				idSanPham: $scope.radioKieuSanPham,
				soLuong: $scope.soLuong
			});
		}
		else {
			var index = listGioHang.indexOf(objectInlist);
			listGioHang[index] = {
				idSanPham: $scope.radioKieuSanPham,
				soLuong: $scope.soLuong
			};
		}

		$rootScope.soLuongSanPhamTrongGioHang = listGioHang.length;

		$cookies.put('gio_hang_cookie', angular.toJson(listGioHang), {
			path: '/FlowerShop'
		});
	}

	$scope.dangNhap = function() {
		$window.location.href = '/FlowerShop/dangnhap';
	}

	$scope.traLoi = function(item) {
		if (!item.noiDungTraLoi) {
			$scope.showSimpleToast('Bạn chưa điền phản hồi.');
			return;
		}
		var data = {
			idNhanVien: $rootScope.idNhanVien,
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

	$scope.capNhatAnHienTraLoi = function(item) {
		if (item.hienTraLoi) {
			item.anHienTraLoi = 'Hiện trả lời';
		}
		else {
			item.anHienTraLoi = 'Ẩn trả lời';
		}
		item.hienTraLoi = !item.hienTraLoi;
	}

	$scope.doiSoSao = function(soSao) {
		$scope.danhGiaMoi.soSao = soSao;
	}

	$scope.themDanhGia = function() {
		$scope.danhGiaMoi.idSanPham = $scope.sanPham.id;
		$scope.danhGiaMoi.idNhanVien = $rootScope.idNhanVien;
		$http.post('/FlowerShop/api/them_danh_gia', angular.toJson($scope.danhGiaMoi), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				$scope.sanPham.danhSachDanhGia.push(response.data.danhGia);
			}
			else {
				$scope.showSimpleToast(notification);
			}
		}, function(error) {
			console.log(error);
		});
	}

	$scope.khuyenMaiHienTai = function(khuyenMai) {
		var current = new Date().getTime();
		return (!khuyenMai.daXoa && current > khuyenMai.thoiGianBatDau && current < khuyenMai.thoiGianKetThuc)
	}

	$scope.coKhuyenMai = function() {
		if ($scope.sanPham != undefined) {
			var kieuSanPham = $filter('filter')($scope.sanPham.danhSachKieuSanPham, {id: $scope.radioKieuSanPham})[0];
			$scope.danhSachKhuyenMai = $filter('filter')(kieuSanPham.danhSachKhuyenMai, $scope.khuyenMaiHienTai);
			return $scope.danhSachKhuyenMai.length > 0;
		}
		return false;
	}

	$scope.getGiaKhuyenMai = function() {
		if ($scope.sanPham != undefined) {
			var kieuSanPham = $filter('filter')($scope.sanPham.danhSachKieuSanPham, {id: $scope.radioKieuSanPham})[0];
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
		return 0;
	}
});