app.controller('EventAddController', function($http, $scope, $rootScope, $mdToast, $location, $mdDialog, $window, $filter, $cookies, Page) {
	Page.setTitle('Thêm chương trình khuyến mãi');
	
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

		last = angular.extend({}, current);
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

	$scope.khuyenMai = {};

	$http.post('/FlowerShop/api/get_tat_ca_kieu_san_pham', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listKieuSanPhamGoc = $filter('filter')(response.data, {sanPham: {daXoa: false}});
		$scope.listKieuSanPham = $scope.listKieuSanPhamGoc;
	}, function(error) {
		console.log(error);
	});
	
	$http.post('/FlowerShop/api/get_danh_sach_danh_muc', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.danhSachDanhMuc = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.danhMucSanPham = '0';

	$scope.doiDanhMucSanPham = function(danhMucSanPham) {
		if (danhMucSanPham == 0) {
			$scope.listKieuSanPham = $scope.listKieuSanPhamGoc;
		} else {
			$scope.listKieuSanPham = $filter('filter')($scope.listKieuSanPhamGoc, {sanPham: {danhMuc: {id: +danhMucSanPham}}});
		}
	}

	$scope.khuyenMai.listKieuSanPham = [];

	$scope.chonKieuSanPham = function(kieuSanPham) {
		var index = $scope.listKieuSanPhamGoc.indexOf(kieuSanPham);
		$scope.listKieuSanPhamGoc.splice(index, 1);
		$scope.doiDanhMucSanPham($scope.danhMucSanPham);
		$scope.khuyenMai.listKieuSanPham.push(kieuSanPham);
	}

	$scope.huyChonKieuSanPham = function(kieuSanPham) {
		var index = $scope.khuyenMai.listKieuSanPham.indexOf(kieuSanPham);
		$scope.khuyenMai.listKieuSanPham.splice(index, 1);
		$scope.listKieuSanPhamGoc.push(kieuSanPham);
		$scope.doiDanhMucSanPham($scope.danhMucSanPham);
	}

	$scope.chonHetKieuSanPham = function() {
		$scope.khuyenMai.listKieuSanPham = $scope.khuyenMai.listKieuSanPham.concat($scope.listKieuSanPham);
		for (var i = $scope.listKieuSanPham.length - 1; i >= 0; i--) {
			var index = $scope.listKieuSanPhamGoc.indexOf($scope.listKieuSanPham[i]);
			$scope.listKieuSanPhamGoc.splice(index, 1);
		}
		$scope.doiDanhMucSanPham($scope.danhMucSanPham);
	}

	$scope.huyChonHetKieuSanPham = function() {
		$scope.listKieuSanPhamGoc = $scope.listKieuSanPhamGoc.concat($scope.khuyenMai.listKieuSanPham);
		$scope.khuyenMai.listKieuSanPham = [];
		$scope.doiDanhMucSanPham($scope.danhMucSanPham);
	}

	$scope.themKhuyenMai = function(item) {
		var forms = new FormData();
		forms.append('file', item.fileKhuyenMai);
		forms.append('path', "/resources/images/events/");
		
		$http.post('/FlowerShop/api/upload_file', forms, {
	        transformRequest : angular.identity,
	        headers : {
	        	'Content-Type' : undefined
	        }
	    }).then(function() {
	    	var thoiGianBatDau = item.thoiGianBatDau;
			var thoiGianKetThuc = item.thoiGianKetThuc;
			var data = {
				tenKhuyenMai: item.tenKhuyenMai,
				moTa: item.moTa,
				thoiGianBatDau: new Date(Date.UTC(thoiGianBatDau.getFullYear(), thoiGianBatDau.getMonth(), thoiGianBatDau.getDate(), thoiGianBatDau.getHours(), thoiGianBatDau.getMinutes(), thoiGianBatDau.getSeconds())),
				thoiGianKetThuc: new Date(Date.UTC(thoiGianKetThuc.getFullYear(), thoiGianKetThuc.getMonth(), thoiGianKetThuc.getDate(), thoiGianKetThuc.getHours(), thoiGianKetThuc.getMinutes(), thoiGianKetThuc.getSeconds())),
				phanTramGiam: item.phanTramGiam,
				giaGiamToiDa: item.giaGiamToiDa
			}
			if (item.fileKhuyenMai != undefined) {
	    		data.anhKhuyenMai = item.fileKhuyenMai.name;
	    	}
			data.kieuSanPham = [];
			item.listKieuSanPham.forEach(function (value) {
				data.kieuSanPham.push(value.id);
			});
			$http.post('/FlowerShop/api/them_khuyen_mai', angular.toJson(data), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$scope.showSimpleToast('Thêm khuyến mãi thành công.');
					$location.path('/event_info/' + response.data.id);
				} 
				else {
					$scope.showSimpleToast(notification);
				}
			}, function(error) {
				console.log(error);
			});
	    }, function(error) {
	    	console.log(error);
	    });
	}
});