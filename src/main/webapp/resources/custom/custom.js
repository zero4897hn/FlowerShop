'use strict';
var app = angular.module('myApp', ['ngMaterial', 'ngRoute', 'ngCookies', 'ngSanitize', 'ui.bootstrap', 'ngAnimate']);

app.directive('fileModel', ['$parse', function ($parse) {
	return {
		restrict: 'A',
		link: function(scope, element, attrs) {
			var model = $parse(attrs.fileModel);
			var modelSetter = model.assign;
			element.bind('change', function() {
				scope.$apply(function() {
					modelSetter(scope, element[0].files[0]);
				});
			});
		}
	};
}]);
app.directive('renderIframely', ['$timeout', function ($timeout) {
	return {
		link: function ($scope, element, attrs) {
			$timeout(function () {
				// Run code after element is rendered                        
				window.iframely && iframely.load();
            }, 0, false);
        }
    };
}])
app.controller('MyController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $location, $cookies, $window, $filter) {
	var last = {
		bottom: false,
		top: true,
		left: false,
		right: true
	};

	$rootScope.idNhanVien = $cookies.get('id_nhan_vien_hien_tai');
	if ($rootScope.idNhanVien != undefined) {
		$http.post('/FlowerShop/api/get_nhan_vien', angular.toJson({
			idNhanVien: $rootScope.idNhanVien
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$scope.nhanVien = response.data;
		}, function(error) {
			console.log(error);
		});
	}

	$scope.isNavCollapsed = true;
	$scope.isCollapsed = false;
	$scope.isCollapsedHorizontal = false;

	$scope.collapseNavbar = function() {
		$scope.isNavCollapsed = !$scope.isNavCollapsed;
	}

	$http.post('/FlowerShop/api/get_du_lieu_trang_chu', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		var duLieuTrangChu = response.data;
		if (duLieuTrangChu != undefined) {
			$scope.chanTrang = angular.fromJson($filter('filter')(duLieuTrangChu, {tenTruong: 'chanTrang'})[0].noiDung);
		}
	}, function(error) {
		console.log(error);
	});

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

	$http.post('/FlowerShop/api/get_danh_sach_danh_muc', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.danhSachDanhMuc = response.data;
	}, function(error) {
		console.log(error);
	});

	var gioHangCookie = $cookies.get('gio_hang_cookie');

	if (gioHangCookie == undefined || !gioHangCookie) {
		var listGioHang = [];
	} else {
		var listGioHang = angular.fromJson(gioHangCookie);
	}

	$rootScope.soLuongSanPhamTrongGioHang = listGioHang.length;

	$scope.xemDanhSachSanPham = function(item) {
		$cookies.put('danh_muc_id', item, {
			path: '/FlowerShop'
		});
		if ($location.path() == '/danh_sach_san_pham') {
			$window.location.reload();
		}
		else {
			$location.path('/danh_sach_san_pham');
		}
	}

	$scope.dangNhap = function() {
		$window.location.href = '/FlowerShop/dangnhap';
	}

	$scope.dangXuat = function() {
		var confirm = $mdDialog.confirm()
		.title('Đăng xuất')
		.textContent('Xác nhận đăng xuất?')
		.ok('Xác nhận')
		.cancel('Không');

		$mdDialog.show(confirm).then(function() {
			$cookies.remove('id_nhan_vien_hien_tai', {
				path: '/FlowerShop'
			});
			$window.location.reload();
		}, function() {
			
		});
	}

	$scope.timKiemSanPham = function(sanPhamCanTim) {
		$cookies.put('danh_muc_id', -1, {
			path: '/FlowerShop'
		});
		$cookies.put('san_pham_can_tim', sanPhamCanTim, {
			path: '/FlowerShop'
		});
		if ($location.path() == '/danh_sach_san_pham') {
			$window.location.reload();
		}
		else {
			$location.path('/danh_sach_san_pham');
		}
	}

	$scope.timHoaDon = function() {
		$mdDialog.show({
			controller: DialogController,
			templateUrl: '/FlowerShop/resources/webdata/timhoadon.jsp',
			clickOutsideToClose: true,
			fullscreen: $scope.customFullscreen
		})
		.then(function(value) {
			$http.post('/FlowerShop/api/kiem_tra_ton_tai_ma_hoa_don', angular.toJson({
				maHoaDon: value
			}), {
				headers: {
					'content-type': 'application/json;charset=UTF-8'
				}
			}).then(function(response) {
				var notification = response.data.notice;
				if (notification == 'success') {
					$cookies.put('hoa_don_id', response.data.idHoaDon, {
						path: '/FlowerShop'
					});
					if ($location.path().startsWith('/chi_tiet_don_mua')) {
						$window.location.reload();
					}
					else {
						$location.path('/chi_tiet_don_mua/' + response.data.idHoaDon);
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

	function DialogController($scope, $mdDialog) {
		$scope.hide = function() {
			$mdDialog.hide();
		};

		$scope.cancel = function() {
			$mdDialog.cancel();
		};

		$scope.submit = function(value) {
			$mdDialog.hide(value);
		};
	}
});
app.config(function ($routeProvider, $locationProvider) {
	$locationProvider.html5Mode(true);
	$routeProvider
	.when('/', {
		templateUrl: '/FlowerShop/resources/webdata/trangchu.jsp',
		controller: 'TrangChuController'
	})
	.when('/danh_sach_san_pham', {
		templateUrl: '/FlowerShop/resources/webdata/danhsachsanpham.jsp',
		controller: 'DanhSachSanPhamController'
	})
	.when('/chi_tiet_san_pham/:idSanPham', {
		templateUrl: '/FlowerShop/resources/webdata/chitietsanpham.jsp',
		controller: 'ChiTietSanPhamController'
	})
	.when('/gio_hang', {
		templateUrl: '/FlowerShop/resources/webdata/giohang.jsp',
		controller: 'GioHangController'
	})
	.when('/hoa_don', {
		templateUrl: '/FlowerShop/resources/webdata/hoadon.jsp',
		controller: 'HoaDonController'
	})
	.when('/thong_tin_nguoi_dung', {
		templateUrl: '/FlowerShop/resources/webdata/thongtinnguoidung.jsp',
		controller: 'ThongTinNguoiDungController'
	})
	.when('/don_mua', {
		templateUrl: '/FlowerShop/resources/webdata/donmua.jsp',
		controller: 'DonMuaController'
	})
	.when('/chi_tiet_don_mua/:idHoaDon', {
		templateUrl: '/FlowerShop/resources/webdata/chitietdonmua.jsp',
		controller: 'ChiTietDonMuaController'
	})
	.when('/thong_tin', {
		templateUrl: '/FlowerShop/resources/webdata/thongtin.jsp',
		controller: 'ThongTinController'
	})
	.when('/lien_he', {
		templateUrl: '/FlowerShop/resources/webdata/lienhe.jsp',
		controller: 'LienHeController'
	})
	.otherwise({ redirectTo: '/' });
});
app.controller('ToastCtrl', function($scope, $mdToast) {
	$scope.closeToast = function() {
		$mdToast.hide();
	};
});