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
    <link rel="stylesheet" type="text/css" href="/css/mybase.css">
    <style>
        .sel_btn{
            height: 21px;
            line-height: 21px;
            padding: 0 11px;
            background: #02bafa;
            border: 1px #26bbdb solid;
            border-radius: 3px;
            /*color: #fff;*/
            display: inline-block;
            text-decoration: none;
            font-size: 12px;
            outline: none;
        }
        .ch_cls{
            background: #e4e4e4;
        }

        .ch_pro{
            background: #8c9ae4;
        }

        .sel_pro{
            height: 21px;
            line-height: 21px;
            padding: 0 11px;
            background: #02bafa;
            border: 1px #26bbdb solid;
            border-radius: 3px;
            width: 33%;
            /*color: #fff;*/
            /*display: inline-block;*/
            text-decoration: none;
            font-size: 12px;
            outline: none;
        }

        .up_btn{
            height: 21px;
            line-height: 21px;
            padding: 0 11px;
            background-color: #FF5722;
            border: 1px #db574b solid;
            border-radius: 3px;
            color: #fff;
            display: inline-block;
            text-decoration: none;
            font-size: 12px;
            outline: none;
            text-align: center;
        }
        .down_btn{
            height: 21px;
            line-height: 21px;
            padding: 0 11px;
            background-color: #5FB878;
            border: 1px #0adb6f solid;
            border-radius: 3px;
            color: #fff;
            display: inline-block;
            text-decoration: none;
            font-size: 12px;
            outline: none;
            text-align: center;
        }
        .btnBigSize{font-size: 20px; width: 100px;height: 60px;line-height: 60px;margin-bottom: 3em;}

        .pay_title{line-height: 40px;
            height: 40px;
            background-color: #f2f2f2;
            border-bottom: 1px solid #d2d2d2;padding-left: 5px;}
        .index_top{height: 50px;width: 100%;border-bottom: 1px solid #d2d2d2;}
        .index_top:after{content: '';display: block;clear: both;}
        .user_info{float: left;text-align: left;padding-left: 5px;width:90px;line-height: 50px;height: 50px;}
        .user_info:after{content: '';display: block;clear: both;}
        .user_info span{line-height: 50px;display: inline-block;height: 50px;}
        .user_info >img{width: 44px;height:44px;margin-top:3px;margin-left: 4px;float: left;        }
        .account_info{text-align: center;width: 30%;}
        .account_info p{line-height: 20px;margin: 0px;line-height: 50px;height: 50px;}
        .cz{width:110px;line-height: 50px;height: 50px;float: right;}
        .kImg{height: 300px;width: 100%;margin: 5px 0px;background-color: #EEEEEE;overflow: visible;}
        .pay_money_div:after{content: '';display: block;clear: both;}
        .selectDiv>span{width: 28%;float: left;cursor: pointer;text-align: center;border: 1px solid #ddd;background-color: #eee;margin:6px 6px 0px 0px;height: 35px;line-height: 35px;border-radius: 5px;}
        .pay_money_opt>span{height: 60px;line-height: 20px;min-width: 60px;            padding: 5px 0px;}
        .pay_money_opt .zf{font-size: 14px;}
        .currentCss1{border:1px solid #F7B824!important;}
        .currentCss2{border:1px solid #FF5722!important;color: #FF5722}
        .pay_money_opt .syl{color:red;font-size: 10px;}
        .pay_money_div{}
    </style>
</head>

<body>
<!--用户状态栏-->
<div class="index_top">
    <div class="user_info">
        <img src="/images/l.jpg">
        <%--<span>&nbsp;ID：8002</span>--%>
    </div>
    <div class="leftD account_info">
        <p>个人账户:0元</p>
    </div>
    <div class="cz leftD">
        <a class="up_btn" id="chongzhi">充值</a>&nbsp;&nbsp;<a class="down_btn" id="tixian">提现</a>
    </div>
</div>
<!--产品列表-->
<div style="height:48px;overflow: visible;">
    <table  style="width: 100%;">
        <tr>
            <td height="40" class="sel_pro ch_pro">
                <b>晶体蜡</b><br/>
                <b>2346.56</b>
            </td>
            <td class="sel_pro ">
                <b>焦炭</b><br/>
                <b>2346.56</b>
            </td>
            <td class="sel_pro ">
                <b>乙烯</b><br/>
                <b>2346.56</b>
            </td>
        </tr>
    </table>
</div>
<!--走势图展示位置-->
<div>
    <div id="lineView" class="kImg"></div>
</div>
<div style="height:40px;text-align: center;">
    <a class='sel_btn ch_cls' data='0'>分时线</a>
    <a class='sel_btn' data='1' >1分钟</a>
    <a class='sel_btn' data='5' >5分钟</a>
    <a class='sel_btn' data='15' >15分钟</a>
</div>
<div style="text-align: center;">
    <a class='up_btn buy btnBigSize' data=0>订货</a>
    <a class='down_btn buy btnBigSize' data=1 >回购</a>
</div >

<!--弹出层显示位置-->
<div id="createOrderDiv" style="display: none;">
    <div>
    <form id="createOrderForm" action="" method="post" >
        <input id="buyPrice" name="buyPrice" type="hidden" value="8530.23"/>
        <input id="productName" name="productName" type="hidden" value="晶体蜡"/>
        <input id="productId" name="productId" type="hidden" value="1"/>
        <input id="revenueModelCode" name="revenueModelCode" type="hidden" value="R_87.5"/>
        <input id="buyAmount" name="buyAmount" type="hidden" value="100.00"/>
        <input id="buyGoing" name="buyGoing" type="hidden" value="1"/>
        <input id="unionid" name="unionid" type="hidden" value="oCxYvw6cYVcMZaZhLsDS-xxZE9G4"/>
<div class="pay_title">晶体蜡（当前价格：8530）</div>
        <table>
            <tr>
                <td colspan="3"><p>结算时间</p></td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="selectDiv pay_money_opt">
                    <span class="currentCss1">
                        <p class="zf">15点</p>
                        <p class="syl">收益87.5%</p>
                    </span>
                    <span>
                        <p class="zf">30点</p>
                        <p class="syl">收益90%</p>
                    </span>
                    <span>
                       <p class="zf">60点</p>
                        <p class="syl">收益92%</p>
                    </span>
                    </div>
                </td>
            </tr>
        </table>
        <div>投资金额</div>
        <div class="selectDiv pay_money_div">
            <span class="currentCss2">100</span>
            <span>200</span>
            <span>500</span>
            <span>1000</span>
            <span>2000</span>
        </div>
        <table>
            <tr>
                <td>可用余额：0.00元</td>
                <td>预计收益：0.00元</td>
            </tr>
        </table>
    </form>
    </div>
</div>
<jsp:include page="./common/bottom.jsp"></jsp:include>
</body>
<script type="text/javascript">
    $(function () {
        $("#chongzhi").click(function () {
            alert("充值按钮");
        });

        $("#tixian").click(function () {
            alert("提现按钮");
        });

//        $("").on("click",function () {
//            alert(1);
//            $(".pay_money_div>span").removeClass("currentPayMoney");
//            $(this).addClass("currentPayMoney");
//        });


        $(document).on("click",".pay_money_opt>span",function(){
            $(".pay_money_opt>span").removeClass("currentCss1");
            $(this).addClass("currentCss1");
        });

        $(document).on("click",".pay_money_div>span",function(){
            $(".pay_money_div>span").removeClass("currentCss2");
            $(this).addClass("currentCss2");
        });
    });

    //初始化加载分时线
    toLoadView(0);

    $(".sel_btn").click(function(){
        var data=$(this).attr('data');
        $(this).addClass('ch_cls');
        $(this).siblings().removeClass('ch_cls');
        toLoadView(data);
    });

    function toLoadView(data) {
        switch(data)
        {
            case '0':
                $("#lineView").load("/stock/toMPage.html");
                break;
            case '5':
                $("#lineView").load("/stock/toM5Page.html");
                break;
            case '15':
                $("#lineView").load("/stock/toM15Page.html");
                break;
            case '30':
                $("#lineView").load("/stock/toM30Page.html");
                break;
            default:
                $("#lineView").load("/stock/toMPage.html");
        }
    }

    /*下单*/
    $(".buy").click(function(){
        var data=$(this).attr('data');
        openDialog();
    });

    //layer弹出层
    function openDialog() {
        layer.open({
            type: 1,
            anim: 'scale',
            btn: ['下单', '取消'],
            shade: 'background-color: rgba(0,0,0,.3)',//遮罩层
            fix: false,
            move: false,//拖拽
            offset: 'auto',
            content: $('#createOrderDiv').html(),//这里content是一个DOM
            style: 'width:80%;',
            yes:function(index){
                toCreateStockOrder();
                layer.close(index);
            },
            no:function(index){
            }
        });
    }

    function toCreateStockOrder() {
        var _url='/stock/toCreateStockOrder.html';
        $.ajax({
            type: "POST",
            url:_url,
            data:$('#createOrderForm').serialize(),
            dataType: "json",
            error: function(){
                alert('获取数据失败！');
            },
            success: function(data) {
                if(data.status){
                    //信息框
                    layer.open({
                        content: '下单成功！'
                        ,btn: '我知道了'
                    });
                }else {
                    layer.open({
                        content: '下单失败！'
                        ,btn: '我知道了'
                    });
                }
            }
        });
    }


</script>
</html>
