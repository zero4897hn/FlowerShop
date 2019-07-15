app.controller('TrangChuController', function($http, $scope, $rootScope, $filter, $cookies, $location, $mdToast, $sce) {
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

	$http.post('/FlowerShop/api/get_du_lieu_trang_chu', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		var duLieuTrangChu = response.data;
		if (duLieuTrangChu != undefined) {
			$scope.listBanner = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'banner'})[0].noiDung);
			for (var i = 0; i < $scope.listBanner.length; i++) {
				$scope.addSlide();
			}
			$scope.noiDung = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'noiDung'})[0].noiDung);
			$scope.nhungBanDo = $sce.trustAsHtml($filter('filter')(duLieuTrangChu, {tenTruong: 'nhungBanDo'})[0].noiDung);
		}
	}, function(error) {
		console.log(error);
	});

	//Slider
	$scope.myInterval = 3000;
	$scope.noWrapSlides = false;
	$scope.active = 0;
	var slides = $scope.slides = [];
	var currIndex = 0;

	$scope.addSlide = function() {
		slides.push({
			image: '/FlowerShop/resources/images/events/' + $scope.listBanner[slides.length % $scope.listBanner.length].hinhAnh,
			text: $scope.listBanner[slides.length % $scope.listBanner.length].noiDung,
			title: $scope.listBanner[slides.length % $scope.listBanner.length].tieuDe,
			id: currIndex++
		});
	};
	//End Slider

	$http.post('/FlowerShop/api/get_danh_sach_san_pham', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listSanPham = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.setMinAndMax = function(item) {
		item.danhSachKieuSanPham.forEach(function(value) {
			value.giaTien = $scope.getGiaKhuyenMai(value);
		});
		item.giaCaoNhat = Math.max.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }))
		item.giaThapNhat = Math.min.apply(Math, item.danhSachKieuSanPham.map(function(o) { return o.giaTien; }))
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