app.controller('ProductEditController', function($http, $scope, $routeParams, $mdToast, $location, $cookies, Page) {
	Page.setTitle('Sửa sản phẩm');

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
	
	var idSanPham = $routeParams.idProduct;

	if (idSanPham == undefined) {
		$location.path('/');
	}
	else {
		$http.post('/FlowerShop/api/get_san_pham', angular.toJson({
			idSanPham: +idSanPham
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.sanPham = response.data;
		}, function(error) {
			console.log(error);
		})
	}

	$http.post('/FlowerShop/api/get_tat_ca_danh_muc', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listDanhMuc = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.hienThiKieuDanhMuc = function(item) {
		item.hienThi = !item.hienThi;
	}

	$scope.themKieuSanPham = function() {
		$scope.sanPham.danhSachKieuSanPham.push({
			tenKieu: undefined,
			giaTien: undefined,
			soLuong: undefined,
			hienThi: true
		});
	};

	$scope.xoaKieuSanPham = function(item) {
		item.isDeleted = true;
	};

	$scope.suaSanPham = function(item) {
		var forms = new FormData();
		forms.append('file', $scope.anhSanPham);
		forms.append('path', "/resources/images/products/");
		$http.post('/FlowerShop/api/upload_file', forms, {
	        transformRequest : angular.identity,
	        headers : {
	        	'Content-Type' : undefined
	        }
	    }).then(function(value) {
	    	if ($scope.anhSanPham != undefined) item.hinhAnh = $scope.anhSanPham.name;
	    	item.daXoa = undefined;
	    	$http.post('/FlowerShop/api/sua_san_pham', angular.toJson(item), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$scope.showSimpleToast('Sửa thành công.');
					$location.path('/product_info/' + item.id);
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