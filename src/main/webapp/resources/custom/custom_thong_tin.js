app.controller('ThongTinController', function($http, $filter, $scope, $rootScope, $mdToast, $mdDialog, $location, $cookies, $window) {
	$http.post('/FlowerShop/api/get_du_lieu_trang_chu', {
		headers: {
			'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
		}
	}).then(function(response) {
		var duLieuTrangChu = response.data;
		if (duLieuTrangChu != undefined) {
			var thongTinField = $filter('filter')(duLieuTrangChu, {tenTruong: 'thongTin'})[0].noiDung;
			if (thongTinField != undefined) {
				$scope.thongTinTrangWeb = thongTinField;
			}
		}
	}, function(error) {
		console.log(error);
	});
});