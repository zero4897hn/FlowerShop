app.controller('DanhSachSanPhamController', function($http, $scope, $rootScope, $cookies, $filter, $mdToast, $location) {
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

	$scope.soSanPhamMoiTrang = 6;
	$scope.trangHienTai = 1;

	$scope.idDanhMucHienTai = $cookies.get('danh_muc_id');

	if ($scope.idDanhMucHienTai == undefined) {
		$scope.idDanhMucHienTai = 0;
	}

	var dsSanPhamCookie = $cookies.getObject('product_list');
	if (dsSanPhamCookie == undefined) {
		$scope.trangHienTai = 1;
		$scope.soSanPhamMoiTrang = 6;
	}
	else {
		if (dsSanPhamCookie.trangHienTai == undefined) {
			$scope.trangHienTai = 1;
		}
		else {
			$scope.trangHienTai = dsSanPhamCookie.trangHienTai;
		}
		if (dsSanPhamCookie.soSanPhamMoiTrang == undefined) {
			$scope.soSanPhamMoiTrang = 6;
		}
		else {
			$scope.soSanPhamMoiTrang = dsSanPhamCookie.soSanPhamMoiTrang;
		}
	}

	$http.post('/FlowerShop/api/get_tat_ca_danh_muc', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listDanhMuc = response.data;
		if ($scope.idDanhMucHienTai > 0) {
			$scope.listSanPham = $filter('filter')($scope.listDanhMuc, {id: $scope.idDanhMucHienTai})[0].danhSachSanPham;
			$scope.listSanPham = $filter('filter')($scope.listSanPham, {banRa: true, daXoa: false});
			$scope.capNhatDanhSachSanPham();
		}
	}, function(error) {
		console.log(error);
	});

	$http.post('/FlowerShop/api/get_tat_ca_san_pham', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listTatCaSanPham = $filter('filter')(response.data, {banRa: true, daXoa: false});
		if ($scope.idDanhMucHienTai == 0) {
			$scope.xemTatCaSanPham();
		}
		else if ($scope.idDanhMucHienTai == -1) {
			$scope.timKiemSanPham();
		}
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
		$cookies.putObject('product_list', {
			trangHienTai: $scope.trangHienTai,
			soSanPhamMoiTrang: $scope.soSanPhamMoiTrang,
		}, {
			path: '/FlowerShop'
		});
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
		item.giaCaoNhat = Math.max.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }))
		item.giaThapNhat = Math.min.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }))
	}

	$scope.xemSanPhamTheoDanhMuc = function(item) {
		$cookies.put('danh_muc_id', item, {
			path: '/FlowerShop'
		});
		$scope.idDanhMucHienTai = item;
		$scope.listSanPham = $filter('filter')($scope.listDanhMuc, {id: $scope.idDanhMucHienTai})[0].danhSachSanPham;
		$scope.listSanPham = $filter('filter')($scope.listSanPham, {banRa: true, daXoa: false});
		$scope.capNhatDanhSachSanPham();
	}

	$scope.xemTatCaSanPham = function() {
		$scope.idDanhMucHienTai = 0;
		$cookies.put('danh_muc_id', 0, {
			path: '/FlowerShop'
		});
		$scope.listSanPham = $scope.listTatCaSanPham;
		$scope.capNhatDanhSachSanPham();
	}

	$scope.themVaoGioHang = function(item) {
		var gioHangCookie = $cookies.get('gio_hang_cookie');
		if (gioHangCookie == undefined || !gioHangCookie) {
			listGioHang = [];
		} else {
			listGioHang = angular.fromJson(gioHangCookie);
		}

		var indexKieuSanPham = 0;

		while (true) {
			if (item.danhSachKieuSanPham[indexKieuSanPham] == undefined || item.danhSachKieuSanPham[indexKieuSanPham].soLuong > 0) break;
			indexKieuSanPham++;
		}

		var objectInlist = $filter('filter')(listGioHang, {idSanPham: item.danhSachKieuSanPham[indexKieuSanPham].id})[0];

		if (objectInlist == undefined) {
			listGioHang.push({
				idSanPham: item.danhSachKieuSanPham[indexKieuSanPham].id,
				soLuong: 1
			});
		}
		else {
			var index = listGioHang.indexOf(objectInlist);
			objectInlist.soLuong = objectInlist.soLuong + 1;
			listGioHang[index] = objectInlist;
		}

		$rootScope.soLuongSanPhamTrongGioHang = listGioHang.length;

		$cookies.put('gio_hang_cookie', angular.toJson(listGioHang), {
			path: '/FlowerShop'
		});
	}

	$scope.timKiemSanPham = function() {
		$scope.idDanhMucHienTai = -1;
		$cookies.put('danh_muc_id', -1, {
			path: '/FlowerShop'
		});
		var sanPhamCanTim = $cookies.get('san_pham_can_tim');
		if (sanPhamCanTim == undefined || !sanPhamCanTim) {
			$scope.listSanPham = [];
		}
		else {
			$scope.listSanPham = $filter('filter')($scope.listTatCaSanPham, {tenSanPham: sanPhamCanTim, banRa: true, daXoa: false});
		}
		$scope.capNhatDanhSachSanPham();
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
});