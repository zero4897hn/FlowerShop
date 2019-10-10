'use strict';
var app = angular.module('myApp', ['ngMaterial', 'ngRoute', 'ngCookies', 'textAngular']);

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
app.factory('Page', function(){
	var title = 'Trang chủ';
	return {
		title: function() { return title; },
		setTitle: function(newTitle) { title = newTitle; }
	};
});
app.controller('MyController', function($http, $scope, $rootScope, $mdToast, $mdDialog, $window, $location, $cookies, Page) {
	$scope.Page = Page;
	var last = {
		bottom: false,
		top: true,
		left: false,
		right: true
	};

	$scope.toastPosition = angular.extend({}, last);

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

	$rootScope.idNhanVien = $cookies.get('id_nhan_vien_hien_tai');
	if ($rootScope.idNhanVien == undefined) {
		$window.location.href = '/FlowerShop/admin/login';
	}
	else {
		$http.post('/FlowerShop/api/get_nhan_vien', angular.toJson({
			idNhanVien: $rootScope.idNhanVien
		}), {
			headers: {
				'content-type': 'application/json;charset=UTF-8'
			}
		}).then(function(response) {
			$rootScope.nhanVienHienTai = response.data;
		}, function(error) {
			console.log(error);
		});

		$http.post('/FlowerShop/api/so_hoa_don_chua_doc', {
			headers: {
				'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
			}
		}).then(function(response) {
			$rootScope.soHoaDonChuaDoc = response.data.result;
		}, function(error) {
			console.log(error);
		});

		$http.post('/FlowerShop/api/so_phan_hoi_chua_doc', {
			headers: {
				'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
			}
		}).then(function(response) {
			$rootScope.soPhanHoiChuaDoc = response.data.result;
		}, function(error) {
			console.log(error);
		});

		$http.post('/FlowerShop/api/so_danh_gia_chua_doc', {
			headers: {
				'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
			}
		}).then(function(response) {
			$rootScope.soDanhGiaChuaDoc = response.data.result;
		}, function(error) {
			console.log(error);
		});
	}

	$scope.dangXuatKhoiTaiKhoan = function() {
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
});
app.config(function ($routeProvider, $locationProvider) {
	$locationProvider.html5Mode(true);
	$routeProvider
	.when('/', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/homepage.jsp',
		controller: 'HomepageController'
	})
	.when('/user_list', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/list_of_users.jsp',
		controller: 'UserListController'
	})
	.when('/user_info/:idUser', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/information_of_user.jsp',
		controller: 'UserInfoController'
	})
	.when('/user_add', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/add_user.jsp',
		controller: 'UserAddController'
	})
	.when('/product_list_by_category', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/list_of_products_by_category.jsp',
		controller: 'ProductListByCategoryController'
	})
	.when('/product_list', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/list_of_products.jsp',
		controller: 'ProductListController'
	})
	.when('/product_info/:idProduct', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/information_of_product.jsp',
		controller: 'ProductInfoController'
	})
	.when('/product_edit/:idProduct', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/edit_product.jsp',
		controller: 'ProductEditController'
	})
	.when('/product_add', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/add_new_product.jsp',
		controller: 'ProductAddController'
	})
	.when('/order_list', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/list_of_orders.jsp',
		controller: 'OrderListController'
	})
	.when('/event_list', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/list_of_events.jsp',
		controller: 'EventListController'
	})
	.when('/event_info/:idEvent', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/information_of_event.jsp',
		controller: 'EventInfoController'
	})
	.when('/event_edit/:idEvent', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/edit_event.jsp',
		controller: 'EventEditController'
	})
	.when('/event_add', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/add_new_event.jsp',
		controller: 'EventAddController'
	})
	.when('/homepage_edit', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/edit_homepage.jsp',
		controller: 'HompageEditController'
	})
	.when('/feedback_list', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/list_of_feedbacks.jsp',
		controller: 'FeedbackListController'
	})
	.when('/info_edit', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/edit_info_page.jsp',
		controller: 'InfoPageEditController'
	})
	.when('/product_rate', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/rate_product.jsp',
		controller: 'ProductRateController'
	})
	.when('/history', {
		templateUrl: '/FlowerShop/resources/webdata/dashboard/history.jsp',
		controller: 'HistoryController'
	})
	.otherwise({ redirectTo: '/' });
});
app.controller('ToastCtrl', function($scope, $mdToast) {
	$scope.closeToast = function() {
		$mdToast.hide();
	};
});