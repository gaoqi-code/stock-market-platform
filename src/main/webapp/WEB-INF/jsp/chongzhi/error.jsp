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
    <title>充值失败</title>
</head>
<body class="c_center">
<br /><br />
    <div style="width: 600px;height:500px;">
        <p>充值失败，请联系客服！</p>
    </div>
    <a href="/toserver.html"><button class="layui-btn" style="width: 95%;">确定</button></a>
</body>
</html>
