<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script type="text/javascript" src="/js/common/jquery/jquery-1.9.1.js" language="javascript"></script>
    <script type="text/javascript" src="/plugins/layer/mobile/layer.js" language="javascript"></script>

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

        .up_btn{
            height: 21px;
            line-height: 21px;
            padding: 0 11px;
            background: #fa554c;
            border: 1px #db574b solid;
            border-radius: 3px;
            /*color: #fff;*/
            display: inline-block;
            text-decoration: none;
            font-size: 12px;
            outline: none;
        }
        .down_btn{
            height: 21px;
            line-height: 21px;
            padding: 0 11px;
            background: #0cfa6f;
            border: 1px #0adb6f solid;
            border-radius: 3px;
            /*color: #fff;*/
            display: inline-block;
            text-decoration: none;
            font-size: 12px;
            outline: none;
        }
    </style>
</head>

<body>
<!--走势图展示位置-->
<div id="lineView" style="width:800px;height:400px;"></div>
<div>
    <a class='sel_btn ch_cls' data='0' >分时线</a>
    <a class='sel_btn' data='5' >5分钟</a>
    <a class='sel_btn' data='15' >15分钟</a>
    <a class='sel_btn' data='30' >30分钟</a>
    <a class='sel_btn' data='60' >60分钟</a>
</div>
<div>
    <a class='up_btn buy' data=0 >买涨</a>
    <a class='down_btn buy' data=1 >买跌</a>
</div>

<!--弹出层显示位置-->
<div id="createOrderDiv" style="display: none;">
    <div>
    <form id="createOrderForm" action="" method="post">
        <table>
            <tr>
                <td>晶体蜡</td>
                <td>当前价格：8530</td>
            </tr>
        </table>
        <div>结算时间</div>
        <table>
            <tr>
                <td>15点（收益87.5%）</td>
                <td>30点（收益90%）</td>
                <td>60点（收益92%）</td>
            </tr>
        </table>
        <div>投资金额</div>
        <table>
            <tr>
                <td>100</td>
                <td>200</td>
                <td>500</td>
                <td>1000</td>
                <td>2000</td>
            </tr>
            <tr>
                <td>可用余额：0.00元</td>
                <td>预计收益：0.00元</td>
            </tr>
        </table>
    </form>
    </div>
</div>

</body>
<script type="text/javascript">
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
                $("#lineView").load("/stock/toMPage.do");
                break;
            case '5':
                $("#lineView").load("/stock/toM5Page.do");
                break;
            case '15':
                $("#lineView").load("/stock/toM15Page.do");
                break;
            case '30':
                $("#lineView").load("/stock/toM30Page.do");
                break;
            case '60':
                $("#lineView").load("/stock/toM60Page.do");
                break;
            default:
                $("#lineView").load("/stock/toMPage.do");
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
            style: 'width:80%; height:200px;',
            yes:function(index){
                toCreateStockOrder();
                layer.close(index);
            },
            no:function(index){
            }
        });
    }

    function toCreateStockOrder() {
        var _url='/stock/toCreateStockOrder.do';
        $.ajax({
            cache: true,
            type: "POST",
            url:_url,
            data:$('#formCondition').serialize(),
            async: false,
            error: function(request) {
                alert("Your request is wrong!!!");
            },
            success: function(data) {
                if(data.status){
                    alert("下单成功！");
                }
            }
        });
    }
</script>
</html>
