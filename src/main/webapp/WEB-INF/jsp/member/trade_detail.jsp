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
    <ul>
        <li><a href="test">交易记录</a></li>
        <%--<li><a href="test">绑定银行卡</a></li>--%>
        <li><a href="test">出金记录</a></li>
    </ul>
    <table>
        <tr>
            <td width="20%">日期</td>
            <td width="20%">金额</td>
            <td width="15%">项目</td>
        </tr>
        <c:forEach items="${list}" var="detail" varStatus="status">
            <tr>
                <td><fmt:formatDate value="${detail.addTime}" pattern="yyyy:mm:dd hh:mm:ss" /></td>
                <td><fmt:formatNumber value="${detail.money}" pattern="0.00" /></td>
                <td>
                    <c:if test="${detail.orderStatus ==1}">充值</c:if>
                    <c:if test="${detail.orderStatus ==2}">金蛋消费</c:if>
                    <c:if test="${detail.orderStatus ==3}">砸蛋</c:if>
                    <c:if test="${detail.orderStatus ==4}">佣金</c:if>
                    <c:if test="${detail.orderStatus ==5}">微盘消费</c:if>
                    <c:if test="${detail.orderStatus ==6}">微盘盈收</c:if>
                    <c:if test="${detail.orderStatus ==7}">提现</c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>


<jsp:include page="../common/bottom.jsp"></jsp:include>
</body>
</html>
