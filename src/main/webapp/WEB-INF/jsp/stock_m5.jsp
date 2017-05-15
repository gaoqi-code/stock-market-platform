<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 引入 ECharts 文件 -->
<script type="text/javascript" src="/js/common/echarts/echarts.min.js" language="javascript"></script>
<script type="text/javascript" src="/js/common/jquery/jquery-1.9.1.js" language="javascript"></script>

<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main_m5" style="width: 300px;height:260px;left: 20px;overflow: visible;"></div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main_m5'));

    var categoryData = new Array();
    var values = new Array();

    <c:forEach items="${initDatas_m5}" var="a">
        // 数据意义：开盘(open)，收盘(close)，最低(lowest)，最高(highest)
        values.push(['${a.openingPrice}','${a.lastClosingPrice}','${a.maxPrice}','${a.minPrice}']); //生成如 array.push(123)的字符串 这样前台拿到后就是js
        categoryData.push('<fmt:formatDate value="${a.dataTime}" pattern="hh:mm" />');
    </c:forEach>

    // 初始 option
    option = {
//        title: {
//            text: '异步数据加载示例'
//        },
        tooltip : {
            trigger: 'axis',
            showDelay: 20,             // 显示延迟，添加显示延迟可以避免频繁切换，单位ms
            hideDelay: 100,            // 隐藏延迟，单位ms
            transitionDuration : 0.4,  // 动画变换时间，单位s
            backgroundColor: 'rgba(0,0,0,0.7)',     // 提示背景颜色，默认为透明度为0.7的黑色
            borderColor: '#333',       // 提示边框颜色
            borderRadius: 4,           // 提示边框圆角，单位px，默认为4
            borderWidth: 0,            // 提示边框线宽，单位px，默认为0（无边框）
            padding: 5,                // 提示内边距，单位px，默认各方向内边距为5，
                                       // 接受数组分别设定上右下左边距，同css
            position: function (p) {
                // 位置回调
                return [p[0] + 10, p[1] - 10];
            },
            formatter:function (params) {
                var seriesType=params[0].seriesType;
                var res = params[0].name;
                if(seriesType == 'line'){
                    res += '<br/>  数值 : ' + params[0].value;
                }
                if(seriesType == 'candlestick'){
                    res += '<br/>  开盘 : ' + params[0].value[0];
                    res += '<br/>  收盘 : ' + params[0].value[1];
                    res += '<br/>  最高 : ' + params[0].value[3];
                    res += '<br/>  最低 : ' + params[0].value[2];
                }
                return res;
            }
        },
        xAxis: {
            type: 'category',
            data: categoryData,
            scale: true,
            boundaryGap :true,
            axisLine: {onZero: false},
            splitLine: {show: false},
            splitNumber: 20,
            min: 'dataMin',
            max: 'dataMax'
        },
        yAxis: {
            scale: true,
            splitArea: {
                show: true
            }
        },
        series: [{
            name: '销量',
            type: 'candlestick',
            data: values
        }]
    };

    setInterval(function () {
        $.ajax({
            type: "post",
            url: "/stock/toGetOneFreshDataForM5.do",
            dataType: "json",
            success: function(data){
                if(data != ''){
                    // 数据意义：开盘(open)，收盘(close)，最低(lowest)，最高(highest)
                    values.push([data.openingPrice,data.lastClosingPrice,data.maxPrice,data.minPrice]);
                    categoryData.push(data.dataTime);
                    values.shift();
                    categoryData.shift();
                }
            }
        });

        /*var _url="http://stock2.finance.sina.com.cn/futures/api/json.php/IndexService.getInnerFuturesMiniKLine5m?symbol=M0";
        $.ajax({
            cache : true,
            url:_url,
            type : "GET",
            dataType :  "json",
            success: function(data){
                alert(data);

                if(data != ''){
                    // 数据意义：开盘(open)，收盘(close)，最低(lowest)，最高(highest)
                    values.push([data.openingPrice,data.lastClosingPrice,data.maxPrice,data.minPrice]);
                    categoryData.push(data.dataTime);
                    values.shift();
                    categoryData.shift();
                }
            }
        });*/

        myChart.setOption({
            xAxis: {
                data: categoryData
            },
            series: [{
                name:'成交',
                data: values
            }]
        });
    }, 5*60*1000);

    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }

</script>
</html>
