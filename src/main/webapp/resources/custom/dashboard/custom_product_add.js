app.controller('ProductAddController', function($scope, $http, $mdToast, $location, $cookies, Page) {
	Page.setTitle('Thêm sản phẩm');

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

	$scope.sanPham = {
		tenSanPham: undefined,
		moTa: undefined,
		danhMuc: '1',
		anhSanPham: undefined,
		kieuSanPham: [
			{
				tenKieu: undefined,
				giaBan: undefined,
				soLuong: undefined,
				hienThi: true
			}
		]
	};

	$http.post('/FlowerShop/api/get_tat_ca_danh_muc', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listDanhMuc = response.data;
	}, function(error) {
		console.log(error);
	});

	$scope.themKieuSanPham = function() {
		$scope.sanPham.kieuSanPham.push({
			tenKieu: undefined,
			giaBan: undefined,
			soLuong: undefined,
			hienThi: true
		});
	};

	$scope.hienThiKieuDanhMuc = function(item) {
		item.hienThi = !item.hienThi;
	}

	$scope.xoaKieuSanPham = function(item) {
		var index = $scope.sanPham.kieuSanPham.indexOf(item);
		$scope.sanPham.kieuSanPham.splice(index, 1);
	}

	$scope.themSanPham = function(item) {
		var forms = new FormData();
		forms.append('file', item.anhSanPham);
		forms.append('path', "/resources/images/products/");
		$http.post('/FlowerShop/api/upload_file', forms, {
	        transformRequest : angular.identity,
	        headers : {
	        	'Content-Type' : undefined
	        }
	    }).then(function(value) {
	    	if (item.anhSanPham != undefined) item.anhSanPham = item.anhSanPham.name;
    		$http.post('/FlowerShop/api/them_san_pham', angular.toJson(item), {
    			headers: {
    				'content-type': 'application/json;charset=UTF-8'
    			}
    		}).then(function(response) {
    			console.log(item);
    			var notification = response.data.notice;
    			if (notification == 'success') {
    				$scope.showSimpleToast('Thêm thành công.');
    				$location.path('/product_info/' + response.data.idSanPham);
    			}
    			else {
    				$scope.showSimpleToast(notification);
    			}
    		}, function(error) {
    			console.log(error);
    		});
	    }, function(error) {
	    	console.log(error);
	    })
	}
});