app.controller('HistoryController', function($http, $scope, $filter, Page) {
	Page.setTitle('Lịch sử tương tác');

	$scope.trangHienTai = 1;
	$scope.soTuongTacMoiTrang = 10;

	$http.post('/FlowerShop/api/get_lich_su_tuong_tac', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		$scope.listTuongTacGoc = response.data;
		$scope.listTuongTac = $scope.listTuongTacGoc;
		if ($scope.listTuongTac != 'null') {
			$scope.capNhatTuongTacTrangHienTai();
		}
	}, function(error) {
		console.log(error);
	});

	$scope.capNhatTuongTacTrangHienTai = function() {
		$scope.soTrang = Math.ceil($scope.listTuongTac.length / $scope.soTuongTacMoiTrang);
		var soLuongTuongTacTruoc = ($scope.trangHienTai - 1) * $scope.soTuongTacMoiTrang;
		$scope.listTuongTacCon = $scope.listTuongTac.slice(soLuongTuongTacTruoc, soLuongTuongTacTruoc + $scope.soTuongTacMoiTrang);
	}

	$scope.linkDenTruong = function(tuongTac) {
		if (tuongTac.truongTuongTac == 'nhan_vien') return 'user_info/' + tuongTac.idTuongTac;
		else if (tuongTac.truongTuongTac == 'san_pham') return 'product_info/' + tuongTac.idTuongTac;
		else if (tuongTac.truongTuongTac == 'khuyen_mai') return 'event_info/' + tuongTac.idTuongTac;
		else return '';
	}

	$scope.trangTruoc = function() {
		$scope.trangHienTai = $scope.trangHienTai - 1;
		if ($scope.trangHienTai < 1) $scope.trangHienTai = 1;
		$scope.capNhatTuongTacTrangHienTai();
	}

	$scope.trangTiepTheo = function() {
		$scope.trangHienTai = $scope.trangHienTai + 1;
		if ($scope.trangHienTai > $scope.soTrang) $scope.trangHienTai = $scope.soTrang;
		$scope.capNhatTuongTacTrangHienTai();
	}

	$scope.locTuongTacTheoNgay = function(tuongTacTheoNgay) {
		if (tuongTacTheoNgay == undefined) {
			$scope.listTuongTac = $scope.listTuongTacGoc;
		}
		else {
			$scope.listTuongTac = $filter('filter')($scope.listTuongTacGoc, function(tuongTac) {
				return tuongTac.thoiGianTuongTac.toString().startsWith(dateToString(tuongTacTheoNgay));
			});
		}
		$scope.capNhatTuongTacTrangHienTai();
	}

	function dateToString(date) {
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();
		return (day < 10? '0' : '') + day + '/' + (month < 10? '0' : '') + month + '/' + year;
	}
});