app.controller('HompageEditController', function($scope, $http, $mdToast, $filter, Page){
	Page.setTitle('Quản lý trang chủ');

	$scope.listFontawesome = ['truck', 'tags', 'phone-square'];
	$scope.noiDung = [{}, {}, {}];
	$scope.noiDung[0].kiHieu = $scope.listFontawesome[0];
	$scope.noiDung[1].kiHieu = $scope.listFontawesome[0];
	$scope.noiDung[2].kiHieu = $scope.listFontawesome[0];
	$scope.chanTrang = {
		benTrai: {
			noiDung: [""]
		},
		xaHoi: [{
			kiHieu: undefined,
			duongDan: undefined
		}],
		benPhai: {
			noiDung: [""]
		}
	};

	var last = {
		bottom: false,
		top: true,
		left: false,
		right: true
	};

	$scope.listSelectedSanPham = [];

	$scope.soLuongSanPham = '4';

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
			var bannerField = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'banner'})[0].noiDung);
			if (bannerField != undefined) {
				$scope.listBanner = bannerField;
			}
			var sanPhamField = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'sanPham'})[0].noiDung);
			if (sanPhamField.sanPhamHot) {
				$scope.isSanPhamHotChecked = sanPhamField.sanPhamHot;
				$scope.soLuongSanPham = sanPhamField.soLuongSanPham;
			}
			var noiDungField = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'noiDung'})[0].noiDung);
			if (noiDungField != undefined) {
				$scope.noiDung = noiDungField;
			}
			var nhungBanDoField = $filter('filter')(duLieuTrangChu, {tenTruong: 'nhungBanDo'})[0].noiDung;
			if (nhungBanDoField != undefined) {
				$scope.nhungBanDo = nhungBanDoField;
			}
			var chanTrangField = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'chanTrang'})[0].noiDung);
			if (chanTrangField != undefined) {
				$scope.chanTrang = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'chanTrang'})[0].noiDung);
			}
		}
	}, function(error) {
		console.log(error);
	});

	$http.post('/FlowerShop/api/get_tat_ca_san_pham', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listSanPham = $filter('filter')(response.data, {banRa: true, daXoa: false});
	}, function(error) {
		console.log(error);
	});

	$http.post('/FlowerShop/api/get_danh_sach_san_pham', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listSelectedSanPham = response.data;
		for (var i = $scope.listSelectedSanPham.length - 1; i >= 0; i--) {
			var index = $scope.listSanPham.indexOf($scope.listSelectedSanPham[i]);
			$scope.listSanPham.splice(index, 1);
		}
	}, function(error) {
		console.log(error);
	});

	$scope.themNoiDungChanTrangBenTrai = function() {
		$scope.chanTrang.benTrai.noiDung.push("");
	}

	$scope.xoaNoiDungChanTrangBenTrai = function(index) {
		$scope.chanTrang.benTrai.noiDung.splice(index, 1);
	}

	$scope.themXaHoi = function() {
		$scope.chanTrang.xaHoi.push({
			kiHieu: undefined,
			duongDan: undefined
		});
	}

	$scope.xoaXaHoi = function(index) {
		$scope.chanTrang.xaHoi.splice(index, 1);
	}

	$scope.themNoiDungChanTrangBenPhai = function() {
		$scope.chanTrang.benPhai.noiDung.push("");
	}

	$scope.xoaNoiDungChanTrangBenPhai = function(index) {
		$scope.chanTrang.benPhai.noiDung.splice(index, 1);
	}

	$scope.addNewBanner = function() {
		$scope.listBanner.push({
			tieuDe: undefined,
			noiDung: undefined,
			hinhAnh: undefined,
			hienThi: true
		});
	}

	$scope.collapseBanner = function(item) {
		item.hienThi = !item.hienThi;
	}

	$scope.removeBanner = function(item) {
		if ($scope.listBanner.length < 2) return;
		var index = $scope.listBanner.indexOf(item);
		$scope.listBanner.splice(index, 1);
	}

	$scope.chonSanPham = function(item) {
		var index = $scope.listSanPham.indexOf(item);
		$scope.listSanPham.splice(index, 1);
		$scope.listSelectedSanPham.push(item);
	}

	$scope.huyChonSanPham = function(item) {
		var index = $scope.listSelectedSanPham.indexOf(item);
		$scope.listSelectedSanPham.splice(index, 1);
		$scope.listSanPham.push(item);
	}

	$scope.capNhatTrangChu = function() {
		var data = {
			noiDung: $scope.noiDung,
			banner: [],
			sanPham: {
				sanPhamHot: $scope.isSanPhamHotChecked,
				soLuongSanPham: $scope.soLuongSanPham,
			},
			nhungBanDo: $scope.nhungBanDo,
			chanTrang: $scope.chanTrang
		}

		if ($scope.listSelectedSanPham.length > 0) {
			data.sanPham.danhSachIdSanPham = [];
			$scope.listSelectedSanPham.forEach(function (value) {
				data.sanPham.danhSachIdSanPham.push(value.id);
			});
		}

		var formData = new FormData();
		formData.append('path', "/resources/images/events/");
		for (var i = 0; i < $scope.listBanner.length; i++) {
			data.banner[i] = {};
			data.banner[i].tieuDe = $scope.listBanner[i].tieuDe;
			data.banner[i].noiDung = $scope.listBanner[i].noiDung;
			if ($scope.listBanner[i].fileAnh != undefined) {
				data.banner[i].hinhAnh = $scope.listBanner[i].fileAnh.name;
				formData.append('file' + i, $scope.listBanner[i].fileAnh);
			} else {
				data.banner[i].hinhAnh = $scope.listBanner[i].hinhAnh;
			}
		}

		$http.post('/FlowerShop/api/upload_multiple_files', formData, {
			headers: { 'Content-Type': undefined },
			transformRequest: angular.identity
		}).success(function(result) {
			if (result.notice == 'success') {
				$http.post('/FlowerShop/api/cap_nhat_trang_chu', angular.toJson(data), {
					headers: {
						'content-type': 'application/json;charset=UTF-8'
					}
				}).then(function(response) {
					$scope.showSimpleToast(response.data.notice);
				}, function(error) {
					console.log(error);
				});
			} else {
				$scope.showSimpleToast(result.notice);
			}
		}).error(function(error) {
			console.log(error);
		});           
	}
});