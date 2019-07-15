app.controller('EventEditController', function($http, $scope, $mdToast, $routeParams, $mdDialog, $location, $cookies, $filter, Page) {
	Page.setTitle('Sửa chương trình khuyến mãi');

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

	var idKhuyenMai = $routeParams.idEvent;

	$scope.danhMucSanPham = '0';
	
	$http.post('/FlowerShop/api/get_khuyen_mai', angular.toJson({
		idKhuyenMai: +idKhuyenMai
	}), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.khuyenMai = response.data;
		if ($scope.khuyenMai != null) {
			$scope.khuyenMai.thoiGianBatDau = new Date($scope.khuyenMai.thoiGianBatDau);
			$scope.khuyenMai.thoiGianKetThuc = new Date($scope.khuyenMai.thoiGianKetThuc);
		}
		$scope.editable = $scope.khuyenMai != 'null' && !$scope.khuyenMai.daXoa;
	}, function(error) {
		console.log(error);
	})

	if ($scope.khuyenMai != null) {
		$http.post('/FlowerShop/api/get_tat_ca_kieu_san_pham', {
			headers: {
				'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.listKieuSanPhamGoc = $filter('filter')(response.data, {sanPham: {daXoa: false}});
			for (var i = $scope.khuyenMai.danhSachKieuSanPham.length - 1; i >= 0; i--) {
				var index = $scope.listKieuSanPhamGoc.indexOf($scope.khuyenMai.danhSachKieuSanPham[i]);
				if (index > -1) $scope.listKieuSanPhamGoc.splice(index, 1);
			}
			$scope.doiDanhMucSanPham($scope.danhMucSanPham);
		}, function(error) {
			console.log(error);
		});
	}

	$http.post('/FlowerShop/api/get_danh_sach_danh_muc', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.danhSachDanhMuc = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.doiDanhMucSanPham = function(danhMucSanPham) {
		if (danhMucSanPham == 0) {
			$scope.listKieuSanPham = $scope.listKieuSanPhamGoc;
		} else {
			$scope.listKieuSanPham = $filter('filter')($scope.listKieuSanPhamGoc, {sanPham: {danhMuc: {id: +danhMucSanPham}}});
		}
	}

	$scope.chonKieuSanPham = function(kieuSanPham) {
		var index = $scope.listKieuSanPhamGoc.indexOf(kieuSanPham);
		if (index > -1) $scope.listKieuSanPhamGoc.splice(index, 1);
		$scope.doiDanhMucSanPham($scope.danhMucSanPham);
		$scope.khuyenMai.danhSachKieuSanPham.push(kieuSanPham);
	}

	$scope.huyChonKieuSanPham = function(kieuSanPham) {
		if (!kieuSanPham.sanPham.daXoa) {
			var index = $scope.khuyenMai.danhSachKieuSanPham.indexOf(kieuSanPham);
			if (index > -1) $scope.khuyenMai.danhSachKieuSanPham.splice(index, 1);
			$scope.listKieuSanPhamGoc.push(kieuSanPham);
			$scope.doiDanhMucSanPham($scope.danhMucSanPham);
		}
	}

	$scope.chonHetKieuSanPham = function() {
		$scope.khuyenMai.danhSachKieuSanPham = $scope.khuyenMai.danhSachKieuSanPham.concat($scope.listKieuSanPham);
		for (var i = $scope.listKieuSanPham.length - 1; i >= 0; i--) {
			var index = $scope.listKieuSanPhamGoc.indexOf($scope.listKieuSanPham[i]);
			$scope.listKieuSanPhamGoc.splice(index, 1);
		}
		$scope.doiDanhMucSanPham($scope.danhMucSanPham);
	}

	$scope.huyChonHetKieuSanPham = function() {
		$scope.listKieuSanPhamGoc = $scope.listKieuSanPhamGoc.concat($filter('filter')($scope.khuyenMai.danhSachKieuSanPham, {sanPham: {daXoa: false}}));
		$scope.khuyenMai.danhSachKieuSanPham = $filter('filter')($scope.khuyenMai.danhSachKieuSanPham, {sanPham: {daXoa: true}});
		$scope.doiDanhMucSanPham($scope.danhMucSanPham);
	}

	$scope.suaKhuyenMai = function(item) {
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
				id: item.id,
				tenKhuyenMai: item.tenKhuyenMai,
				moTa: item.moTa,
				thoiGianBatDau: new Date(Date.UTC(thoiGianBatDau.getFullYear(), thoiGianBatDau.getMonth(), thoiGianBatDau.getDate(), thoiGianBatDau.getHours(), thoiGianBatDau.getMinutes(), thoiGianBatDau.getSeconds())),
				thoiGianKetThuc: new Date(Date.UTC(thoiGianKetThuc.getFullYear(), thoiGianKetThuc.getMonth(), thoiGianKetThuc.getDate(), thoiGianKetThuc.getHours(), thoiGianKetThuc.getMinutes(), thoiGianKetThuc.getSeconds())),
				phanTramGiam: item.phanTramGiam,
				giaGiamToiDa: item.giaGiamToiDa
			}
			if (item.fileKhuyenMai != undefined) {
	    		data.hinhKhuyenMai = item.fileKhuyenMai.name;
	    	}
			data.danhSachKieuSanPham = [];
			item.danhSachKieuSanPham.forEach(function (value) {
				data.danhSachKieuSanPham.push(value.id);
			});
			$http.post('/FlowerShop/api/sua_khuyen_mai', angular.toJson(data), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$scope.showSimpleToast('Sửa khuyến mãi thành công.');
					$location.path('/event_info/' + item.id);
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