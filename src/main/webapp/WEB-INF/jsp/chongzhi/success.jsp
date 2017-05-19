<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="Generator" content="EditPlus®">
    <meta name="Keywords" content="">
    <meta name="Description" content="">
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>充值成功</title>
</head>
<body class="c_center">
<br /><br />
    <div style="width: 600px;height:500px;">
        <table>
            <tr>
                <td>充值订单号</td>
                <td>${data.orderNo}</td>
            </tr>
            <tr>
                <td>充值金额</td>
                <td>${data.orderNo}</td>
            </tr>
            <tr>
                <td>充值订单号</td>
                <td>${data.orderNo}</td>
            </tr>
            <tr>
                <td>余额</td>
                <td>${data.balance}</td>
            </tr>
        </table>
    </div>
    <a href="/toserver.html"><button class="layui-btn" style="width: 95%;">确定</button></a>
</body>
</html>
