app.controller('ThongTinNguoiDungController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $location, $cookies, $window) {
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

	$scope.enabledEdit = false;
	$scope.enabledEditChungMinh = false;
	$scope.enabledEditEmail = false;

	if ($rootScope.idNhanVien == undefined) {
		$window.location.href = '/FlowerShop/dangnhap';
	}
	else {
		$http.post('/FlowerShop/api/get_nhan_vien', angular.toJson({
			idNhanVien: $rootScope.idNhanVien
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.nhanVien = response.data;
			$scope.nhanVien.ngaySinh = $scope.stringToDate($scope.nhanVien.ngaySinh);
		}, function(error) {
			console.log(error);
		});
	}
	

	$scope.stringToDate = function(dateString) {
		var dateParts = dateString.split("/");
		var date = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);
		var utcDate = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
		return utcDate;
	}

	$scope.batDauChinhSua = function() {
		$scope.enabledEdit = true;
	}

	$scope.ketThucChinhSua = function() {
		$http.post('/FlowerShop/api/update_nhan_vien', angular.toJson({
			idNhanVien: $scope.nhanVien.id,
			tenNhanVien: $scope.nhanVien.tenNhanVien,
			idChucVu: $scope.nhanVien.chucVu.id,
			gioiTinh: $scope.nhanVien.gioiTinh,
			ngaySinh: $scope.nhanVien.ngaySinh,
			soDienThoai: $scope.nhanVien.soDienThoai,
			diaChi: $scope.nhanVien.diaChi
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.showSimpleToast(response.data.notice);
		}, function(error) {
			console.log(error);
		});
		$scope.enabledEdit = false;
	}

	$scope.capNhatEmail = function() {
		if (!$scope.nhanVien.email) {
			$scope.enabledEditEmail = true;
		}
		else {
			$mdDialog.show({
				controller: UpdateUserController,
				templateUrl: '/FlowerShop/resources/webdata/capnhatemail.jsp',
				clickOutsideToClose: true,
				fullscreen: $scope.customFullscreen
			}).then(function(value) {
				value.idNhanVien = $scope.nhanVien.id;
				$http.post('/FlowerShop/api/cap_nhat_email', angular.toJson(value), {
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
	}

	$scope.xacNhanCapNhatEmail = function() {
		$http.post('/FlowerShop/api/cap_nhat_email', angular.toJson({
			idNhanVien: $scope.nhanVien.id,
			emailMoi: $scope.nhanVien.email
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.showSimpleToast(response.data.notice);
		}, function(error) {
			console.log(error);
		});
		$scope.enabledEditEmail = false;
	}

	$scope.capNhatChungMinh = function() {
		if (!$scope.nhanVien.chungMinhNhanDan) {
			$scope.enabledEditChungMinh = true;
		}
		else {
			$mdDialog.show({
				controller: UpdateUserController,
				templateUrl: '/FlowerShop/resources/webdata/capnhatchungminhthu.jsp',
				clickOutsideToClose: true,
				fullscreen: $scope.customFullscreen
			}).then(function(value) {
				value.idNhanVien = $scope.nhanVien.id;
				$http.post('/FlowerShop/api/cap_nhat_cmnd', angular.toJson(value), {
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
	}

	$scope.xacNhanCapNhatChungMinhNhanDan = function() {
		$http.post('/FlowerShop/api/cap_nhat_cmnd', angular.toJson({
			idNhanVien: $scope.nhanVien.id,
			chungMinhNhanDanMoi: $scope.nhanVien.chungMinhNhanDan
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.showSimpleToast(response.data.notice);
		}, function(error) {
			console.log(error);
		});
		$scope.enabledEditChungMinh = false;
	}

	$scope.capNhatMatKhau = function() {
		$mdDialog.show({
			controller: UpdateUserController,
			templateUrl: '/FlowerShop/resources/webdata/doimatkhau.jsp',
			clickOutsideToClose: true,
			fullscreen: $scope.customFullscreen
		}).then(function(value) {
			value.idNhanVien = $scope.nhanVien.id;
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
			templateUrl: '/FlowerShop/resources/webdata/doiavatar.jsp',
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
});