<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta content="email=no" name="format-detection">
    <script type="text/javascript" src="/js/common/jquery/jquery-1.9.1.js" language="javascript"></script>
    <script type="text/javascript" src="/plugins/layer/mobile/layer.js" language="javascript"></script>
    <link rel="stylesheet" type="text/css" href="../css/mybase.css">
    <style>
        .opt_div li{height:40px;text-align: left;margin-left: 5px;line-height: 40px;border-bottom: 1px solid #dddddd;}
        .opt_div li>a{display:inline-block;margin-left: 10px;text-decoration: none;}
    </style>
</head>

<body>
<jsp:include page="../common/top.jsp"></jsp:include>
<div class="opt_div">
我的持仓单
</div>


<jsp:include page="../common/bottom.jsp"></jsp:include>
</body>
</html>
