app.controller('UserInfoController', function($scope, $routeParams, $rootScope, $http, $mdToast, $mdDialog, $cookies, $location, Page) {
	Page.setTitle('Thông tin người dùng');

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

	idNhanVien = $routeParams.idUser;

	$http.post('/FlowerShop/api/get_nhan_vien', angular.toJson({
		idNhanVien: +idNhanVien
	}), {
		headers: {
			'content-type': 'application/json;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.nhanVien = response.data;
		if ($scope.nhanVien != 'null') {
			$scope.nhanVien.ngaySinh = $scope.stringToDate($scope.nhanVien.ngaySinh);
		}
	}, function(error) {
		console.log(error);
	});

	$scope.enabledEdit = false;

	$scope.startEdit = function() {
		$scope.enabledEdit = true;
	};
	
	$scope.endEdit = function() {
		$http.post('/FlowerShop/api/update_nhan_vien', angular.toJson({
			idNhanVien: $scope.nhanVien.id,
			tenNhanVien: $scope.nhanVien.tenNhanVien,
			idChucVu: $scope.nhanVien.chucVu.id,
			gioiTinh: $scope.nhanVien.gioiTinh,
			ngaySinh: $scope.nhanVien.ngaySinh,
			chungMinhNhanDan: $scope.nhanVien.chungMinhNhanDan,
			soDienThoai: $scope.nhanVien.soDienThoai,
			diaChi: $scope.nhanVien.diaChi,
			email: $scope.nhanVien.email
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			var notification = response.data.notice;
			if (notification == 'success') {
				if ($rootScope.nhanVienHienTai.id == $scope.nhanVien.id) {
					$rootScope.nhanVienHienTai.chucVu = $scope.nhanVien.chucVu;
				}
				$scope.enabledEdit = false;
				$scope.showSimpleToast('Cập nhật thành công.');
			}
			else $scope.showSimpleToast(notification);
		}, function(error) {
			console.log(error);
		});
	}

	$http.post('/FlowerShop/api/get_chuc_vu', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(value) {
		$scope.listChucVu = value.data;
	}, function(error) {
		console.log(error);
	});

	$scope.stringToDate = function(dateString) {
		var dateParts = dateString.split("/");
		var date = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);
		var utcDate = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
		return utcDate;
	}

	$scope.changePassword = function() {
		$mdDialog.show({
			controller: UpdateUserController,
			templateUrl: '/FlowerShop/resources/webdata/dashboard/change_password.jsp',
			clickOutsideToClose: true,
			fullscreen: $scope.customFullscreen
		})
		.then(function(value) {
			value['id'] = $scope.nhanVien.id;
			$http.post('/FlowerShop/api/doi_mat_khau_tai_khoan', angular.toJson(value), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				$scope.showSimpleToast(response.data.notice);
			}, function(error) {
				console.log(error);
			});
		}, function() {
			
		});
	}

	$scope.thayAvatar = function() {
		$mdDialog.show({
			controller: UpdateUserController,
			templateUrl: '/FlowerShop/resources/webdata/dashboard/change_avatar.jsp',
			clickOutsideToClose: true,
			fullscreen: $scope.customFullscreen
		})
		.then(function(value) {
			var forms = new FormData();
			forms.append('file', value);
			forms.append('path', "/resources/images/avatars/");
			
			$http.post('/FlowerShop/api/upload_file', forms, {
		        transformRequest : angular.identity,
		        headers : {
		        	'Content-Type' : undefined
		        }
		    }).then(function(response) {
		    	var notification = response.data.notice;
		    	if (notification == 'success') {
		    		if (value != undefined) {
		    			$http.post('/FlowerShop/api/thay_avatar_nhan_vien', angular.toJson({
		    				idNhanVien: $scope.nhanVien.id,
		    				avatar: value.name
		    			}), {
		    				headers: {
								'content-type': 'application/json;charset=UTF-8'
							}
		    			}).then(function(response1) {
		    				var notification = response1.data.notice;
		    				if (notification == 'success') {
		    					$scope.nhanVien.avatar = value.name;
		    					if ($scope.nhanVien.id == $rootScope.nhanVienHienTai.id) {
		    						$rootScope.nhanVienHienTai.avatar = value.name;
		    					}
		    					$scope.showSimpleToast('Thay Avatar thành công.');
		    				} else {
		    					$scope.showSimpleToast(notification);
		    				}
		    			}, function(error) {
		    				console.log(error);
		    			});
		    		}
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
	
	function UpdateUserController($scope, $mdDialog) {
		$scope.hide = function() {
			$mdDialog.hide();
		};

		$scope.cancel = function() {
			$mdDialog.cancel();
		};

		$scope.updateUser = function(item) {
			$mdDialog.hide(item);
		};
	}

	$scope.xoaTaiKhoan = function() {
		var confirm = $mdDialog.confirm()
			.title('Xác nhận xóa nhân viên')
			.textContent('Nhân viên và tài khoản của người đó sẽ bị xóa khỏi hệ thống và sẽ không thể hoàn tác, bạn chắc chắn chứ?')
			.ariaLabel('Xóa nhân viên')
			.ok('Chắc chắn')
			.cancel('Không');
		$mdDialog.show(confirm).then(function() {
			$http.post('/FlowerShop/api/xoa_tai_khoan_nhan_vien', angular.toJson({
				idDangNhap: $scope.nhanVien.id
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$scope.showSimpleToast('Xóa thành công.');
					$cookies.remove('dashboard_nhan_vien_id', {
						path: '/FlowerShop'
					});
					$location.path('/user_list');
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