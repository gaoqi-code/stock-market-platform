<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 引入 ECharts 文件 -->
<script type="text/javascript" src="/js/common/echarts/echarts.min.js" language="javascript"></script>
<script type="text/javascript" src="/js/common/jquery/jquery-1.9.1.js" language="javascript"></script>

<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="width: 750px;height:260px;"></div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    var categoryData = new Array();
    var values = new Array();

    <c:forEach items="${initDatas_m}" var="a">
        values.push('${a.price}'); //生成如 array.push(123)的字符串 这样前台拿到后就是js
        categoryData.push('<fmt:formatDate value="${a.dataTime}" pattern="hh:mm" />'); //生成如 array.push(123)的字符串 这样前台拿到后就是js
    </c:forEach>

    // 初始 option
    option = {
//        title: {
//            text: '异步数据加载示例'
//        },
        tooltip : {
            trigger: 'axis',
            formatter:function (params) {
                console.log(params);
                var seriesType=params[0].seriesType;
                var res = params[0].name;
                if(seriesType == 'line'){
                    res += '<br/>  数值 : ' + params[0].value;
                }
                if(seriesType == 'candlestick'){
                    res += '<br/>  开盘 : ' + params[0].value[0] + '  最高 : ' + params[0].value[3];
                    res += '<br/>  收盘 : ' + params[0].value[1] + '  最低 : ' + params[0].value[2];
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
            type: 'line',
            data: values
        }]
    };

    setInterval(function () {
        $.ajax({
            type: "post",
            url: "/stock/toGetOneFreshDataForM.do",
            dataType: "json",
            success: function(data){
                if(data != ''){
                    values.push(data.price);
                    categoryData.push('<fmt:formatDate value="${data.dataTime}" pattern="hh:mm" />');
                    values.shift();
                    categoryData.shift();
                }
            }
        });

        myChart.setOption({
            xAxis: {
                data: categoryData
            },
            series: [{
                name:'成交',
                data: values
            }]
        });
    }, 60*1000);

    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
</script>
</html>
