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
        body,table{
            font-size:12px;
        }
        table{
            table-layout:fixed;
            empty-cells:show;
            border-collapse: collapse;
            margin:5px;
        }
        td{
            height:30px;
        }
        h1,h2,h3{
            font-size:12px;
            margin:0;
            padding:0;
        }
        .table{
            border:1px solid #cad9ea;
            color:#666;
        }
        .table th {
            background-repeat:repeat-x;
            height:30px;
        }
        .table td,.table th{
            border:1px solid #cad9ea;
            padding:0 1em 0;
        }
        .table tr.alter{
            background-color:#f5fafe;
        }
    </style>
</head>

<body>
<jsp:include page="../common/top.jsp"></jsp:include>
<div class="opt_div">
    <table align="center" class="table">
        <form id="depositorsForm" action="" method="post" >
        <tr>
            <td width="">账户余额</td>
            <td width=""><fmt:formatNumber value="${user.balance}" pattern="0.00" /></td>
            <input type="hidden" id="balance" name="balance" value="${user.balance}"/>
        </tr>
        <tr>
            <td width="">提现金额</td>
            <td width=""><input type="text" id="amount" name="amount" value="0.00"/></td>
        </tr>
        <tr>
            <td width="" colspan="2"><a herf="" id="toApplay" class="sel_btn">申请提现</a></td>
        </tr>
        </form>
    </table>
</div>
<jsp:include page="../common/bottom.jsp"></jsp:include>
</body>
<script type="text/javascript">
    $(function () {
        /*下单*/
        $(".sel_btn").click(function(){
            toApplay();
        });
    });

    function toApplay() {
        var _url='/member/toSaveDepositors.json';
        var balance=$("#balance").val();
        var amount=$("#amount").val();

        if(amount>balance){
            layer.open({
                content: '余额不足！'
                ,btn: '我知道了'
            });
        }
        $.ajax({
            type: "POST",
            url:_url,
            data:$('#depositorsForm').serialize(),
            dataType: "json",
            error: function(){
                alert('获取数据失败！');
            },
            success: function(data) {

                if(data!=''&&data.code==1){
                    //信息框
                    layer.open({
                        content: '申请成功！'
                        ,btn: '我知道了'
                    });
                }else {
                    layer.open({
                        content: data.msg
                        ,btn: '我知道了'
                    });
                }
            }
        });
    }
</script>
</html>
