<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript">
	window.paceOptions = {
		document: true,
		eventLag: true,
		restartOnPushState: true,
		restartOnRequestAfter: true,
		ajax: {
			trackMethods: [ 'POST','GET']
		}
	};
</script>

<!-- build:js({.tmp,app}) scripts/app.min.js -->
<script src='<c:url value="/resources/vendor/jquery/dist/jquery.js"/>'></script>
<script src='<c:url value="/resources/vendor/PACE/pace.js"/>'></script>
<script src='<c:url value="/resources/vendor/tether/dist/js/tether.js"/>'></script>
<script src='<c:url value="/resources/vendor/bootstrap/dist/js/bootstrap.js"/>'></script>
<script src='<c:url value="/resources/vendor/fastclick/lib/fastclick.js"/>'></script>
<script src='<c:url value="/resources/scripts/constants.js"/>'></script>
<script src='<c:url value="/resources/scripts/main.js"/>'></script>
<!-- endbuild -->

<!-- page scripts -->
<script type="text/javascript" src='<c:url value="/resources/vendor/embed.min.js"/>'></script>
<script src='<c:url value="/resources/vendor/sweetalert/dist/sweetalert.min.js"/>'></script>
<script src='<c:url value="/resources/vendor/multiselect/js/jquery.multi-select.js"/>'></script>
<!-- end page scripts -->

<!-- initialize page scripts -->
<script src='<c:url value="/resources/scripts/ui/alert.js"/>'></script>
<!-- end initialize page scripts -->

<!-- angular script -->
<script type="text/javascript" src='<c:url value="/resources/vendor/angular-1.5.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/angular.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/angular-route.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/angular-animate.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/angular-cookies.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/angular-aria.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/angular-messages.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/angular-material.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/text-angular/textAngular-rangy.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/text-angular/textAngular-sanitize.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/text-angular/textAngular.min.js"/>'></script>
<!-- end angular script -->

<!-- custom script -->
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_dashboard.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_homepage.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_user_list.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_user_info.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_user_add.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_product_list_by_category.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_product_list.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_product_info.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_product_edit.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_product_add.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_order_list.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_event_list.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_event_info.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_event_edit.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_event_add.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_homepage_edit.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_product_rate.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_feedback_list.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_history.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/custom/dashboard/custom_info_page_edit.js"/>'></script>
<!-- end custom script -->