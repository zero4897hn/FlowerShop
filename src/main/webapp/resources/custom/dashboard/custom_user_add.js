app.controller('UserAddController', function($http, $scope, $mdToast, $location, $cookies, Page){
	Page.setTitle('Thêm người dùng');

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
	
	$scope.radGioiTinh = true;
	$http.post('/FlowerShop/api/get_chuc_vu', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listChucVu = response.data;
		$scope.cbChucVu = '1';
	}, function(error) {
		console.log(error);	
	});
	
	$scope.xuLyDangKy = function() {
		var avatarName;
		if ($scope.fileAvatar === undefined || $scope.fileAvatar === null) {
			avatarName = undefined;
		}
		else {
			avatarName = $scope.fileAvatar.name;
		}

		var forms = new FormData();
		forms.append('file', $scope.fileAvatar);
		forms.append('path', "/resources/images/avatars/");
		
		$http.post('/FlowerShop/api/upload_file', forms, {
	        transformRequest : angular.identity,
	        headers : {
	        	'Content-Type' : undefined
	        }
	    }).then(function(value) {
	    	var dataUser = {
    			tenNhanVien: $scope.txtHoVaTen,
    			gioiTinh: $scope.radGioiTinh,
    			ngaySinh: $scope.dateNgaySinh,
    			diaChi: $scope.txtDiaChi,
    			chungMinhNhanDan: $scope.txtChungMinhNhanDan,
    			soDienThoai: $scope.txtSoDienThoai,
    			email: $scope.txtEmail,
    			maChucVu: $scope.cbChucVu,
    			avatar: avatarName,
    			tenDangNhap: $scope.txtTenDangNhap,
    			matKhau: $scope.txtMatKhau
    		};
	    	var noticeResult = value.data.notice;
	    	if (noticeResult == "success") {
	    		$http.post('/FlowerShop/api/them_nhan_vien', angular.toJson(dataUser), {
	    			headers: {
	    				'content-type': 'application/json;charset=UTF-8'
	    			}
	    		}).then(function(response) {
	    			var notification = response.data.notice;
	    			if (notification == 'success') {
	    				$scope.showSimpleToast('Thêm nhân viên thành công.');
						$location.path('user_info/' + response.data.idNhanVienMoi);
	    			}
	    			else {
	    				$scope.showSimpleToast(notification);
	    			}
	    		}, function(response) {
	    			$scope.showSimpleToast(response.statusText);
	    		});
	    	}
	    	else {
	    		$scope.showSimpleToast(noticeResult);
	    	}
		}, function(error) {
			console.log(error);
		});
	};
});