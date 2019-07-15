app.controller('FeedbackListController', function($scope, $rootScope, $http, $mdToast, $cookies, $mdDialog, Page){
	Page.setTitle('Thư góp ý');

	$rootScope.soPhanHoiChuaDoc = 0;

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

	$http.post('/FlowerShop/api/get_danh_sach_phan_hoi', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listPhanHoi = response.data;
		$scope.listPhanHoiCon = $scope.listPhanHoi;
		var feedbackListCookie = $cookies.getObject('dashboard_feedback_list');
		if (feedbackListCookie == undefined) {
			$scope.trangHienTai = 1;
			$scope.soPhanHoiMoiTrang = 10;
		}
		else {
			if (feedbackListCookie.trangHienTai == undefined) {
				$scope.trangHienTai = 1;
			}
			else {
				$scope.trangHienTai = feedbackListCookie.trangHienTai;
			}
			if (feedbackListCookie.soPhanHoiMoiTrang == undefined) {
				$scope.soPhanHoiMoiTrang = 10;
			}
			else {
				$scope.soPhanHoiMoiTrang = feedbackListCookie.soPhanHoiMoiTrang;
			}
			if (feedbackListCookie.phanHoiCanTim != undefined) {
				$scope.phanHoiCanTim = feedbackListCookie.phanHoiCanTim;
				$scope.listPhanHoi = $filter('filter')($scope.listPhanHoiGoc, $scope.phanHoiCanTim);
			}
		}
		$scope.capNhatDanhSachPhanHoi();
	}, function(error) {
		console.log(error);
	});

	$scope.capNhatDanhSachPhanHoi = function() {
		$scope.trang = [];
		$scope.soTrang = Math.ceil($scope.listPhanHoi.length / $scope.soPhanHoiMoiTrang);
		if ($scope.trangHienTai > $scope.soTrang) $scope.trangHienTai = $scope.soTrang;
		if ($scope.trangHienTai < 1) $scope.trangHienTai = 1;
		if ($scope.soTrang < 6) {
			for (var i = 0; i < $scope.soTrang; i++) {
				$scope.trang[i] = i + 1;
			}
		}
		else {
			if ($scope.trangHienTai < 3) {
				var trangBatDau = 1;
			}
			else if ($scope.trangHienTai <= $scope.soTrang - 2) {
				var trangBatDau = $scope.trangHienTai - 2;
			}
			else {
				var trangBatDau = $scope.soTrang - 4;
			}
			for (var i = 0; i < 5; i++) {
				$scope.trang[i] = trangBatDau;
				trangBatDau = trangBatDau + 1;
			}
		}
		var soLuongPhanHoiTruoc = ($scope.trangHienTai - 1) * $scope.soPhanHoiMoiTrang;
		$scope.listPhanHoiCon = $scope.listPhanHoi.slice(soLuongPhanHoiTruoc, soLuongPhanHoiTruoc + $scope.soPhanHoiMoiTrang);
		$cookies.putObject('dashboard_feedback_list', {
			trangHienTai: $scope.trangHienTai,
			soPhanHoiMoiTrang: $scope.soPhanHoiMoiTrang,
			phanHoiCanTim: $scope.phanHoiCanTim
		}, {
			path: '/FlowerShop'
		});
	}

	$scope.xemPhanHoiTrang = function(item) {
		$scope.trangHienTai = item;
		$scope.capNhatDanhSachPhanHoi();
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		$scope.capNhatDanhSachPhanHoi();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		$scope.capNhatDanhSachPhanHoi();
	}

	$scope.capNhatSoPhanHoiMoiTrang = function() {
		if ($scope.soPhanHoiMoiTrang < 5) return;
		$scope.capNhatDanhSachPhanHoi();
	}

	$scope.denTrangThu = function() {
		if ($scope.trangHienTai < 1 || $scope.trangHienTai > $scope.soTrang) return;
		$scope.capNhatDanhSachPhanHoi();
	}

	$scope.timPhanHoi = function() {
		$scope.listPhanHoi = $filter('filter')($scope.listPhanHoiGoc, $scope.phanHoiCanTim);
		$scope.capNhatDanhSachPhanHoi();
	}

	$scope.xemPhanHoi = function(phanHoi) {
		 $mdDialog.show(
		 	$mdDialog.alert()
		 	.title(phanHoi.tieuDe)
		 	.textContent(phanHoi.noiDung)
		 	.ok('Đã hiểu')
    	);
	}
});