<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- 引入 ECharts 文件 -->
    <script type="text/javascript" src="/js/common/echarts/echarts.min.js" language="javascript"></script>
    <script type="text/javascript" src="/js/common/jquery/jquery-1.9.1.js" language="javascript"></script>
    <script type="text/javascript" src="/plugins/layer/mobile/layer.js" language="javascript"></script>
    <script type="text/javascript" src="/plugins/jquery-validation-1.14.0/lib/jquery.js" language="javascript"></script>
    <script type="text/javascript" src="/plugins/jquery-validation-1.14.0/dist/jquery.validate.js" language="javascript"></script>
    <script type="text/javascript" src="/plugins/jquery-validation-1.14.0/dist/localization/messages_zh.js" language="javascript"></script>

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
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="width: 90%;height:400px;left: 10%;"></div>
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
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    // 数据意义：开盘(open)，收盘(close)，最低(lowest)，最高(highest)
    var data0 = splitData([
        ['09:00', 2320.26,2320.26,2287.3,2362.94],
        ['09:05', 2300,2291.3,2288.26,2308.38],
        ['09:10', 2295.35,2346.5,2295.35,2346.92],
        ['09:15', 2347.22,2358.98,2337.35,2363.8],
        ['09:20', 2360.75,2382.48,2347.89,2383.76],
        ['09:25', 2383.43,2385.42,2371.23,2391.82],
        ['09:30', 2377.41,2419.02,2369.57,2421.15],
        ['09:35', 2425.92,2428.15,2417.58,2440.38],
        ['09:40', 2411,2433.13,2403.3,2437.42],
        ['09:45', 2432.68,2434.48,2427.7,2441.73],
        ['09:50', 2430.69,2418.53,2394.22,2433.89],
        ['09:55', 2416.62,2432.4,2414.4,2443.03],
        ['10:00', 2441.91,2421.56,2415.43,2444.8],
        ['10:05', 2420.26,2382.91,2373.53,2427.07],
        ['10:10', 2383.49,2397.18,2370.61,2397.94],
        ['10:15', 2378.82,2325.95,2309.17,2378.82],
        ['10:20', 2322.94,2314.16,2308.76,2330.88],
        ['10:25', 2320.62,2325.82,2315.01,2338.78],
        ['10:30', 2313.74,2293.34,2289.89,2340.71],
        ['10:35', 2297.77,2313.22,2292.03,2324.63],
        ['10:40', 2322.32,2365.59,2308.92,2366.16],
        ['10:45', 2364.54,2359.51,2330.86,2369.65],
        ['10:50', 2332.08,2273.4,2259.25,2333.54],
        ['10:55', 2274.81,2326.31,2270.1,2328.14],
        ['11:00', 2333.61,2347.18,2321.6,2351.44],
        ['11:05', 2340.44,2324.29,2304.27,2352.02],
        ['11:10', 2326.42,2318.61,2314.59,2333.67],
        ['11:15', 2314.68,2310.59,2296.58,2320.96],
        ['11:20', 2309.16,2286.6,2264.83,2333.29],
        ['11:25', 2282.17,2263.97,2253.25,2286.33],
        ['11:30', 2255.77,2270.28,2253.31,2276.22],
        ['11:35', 2269.31,2278.4,2250,2312.08],
        ['11:40', 2267.29,2240.02,2239.21,2276.05],
        ['11:45', 2244.26,2257.43,2232.02,2261.31],
        ['11:50', 2257.74,2317.37,2257.42,2317.86],
        ['11:55', 2318.21,2324.24,2311.6,2330.81],
        ['12:00', 2321.4,2328.28,2314.97,2332],
        ['12:05', 2334.74,2326.72,2319.91,2344.89],
        ['12:10', 2318.58,2297.67,2281.12,2319.99],
        ['12:15', 2299.38,2301.26,2289,2323.48],
        ['12:20', 2273.55,2236.3,2232.91,2273.55],
        ['12:25', 2238.49,2236.62,2228.81,2246.87],
        ['12:30', 2229.46,2234.4,2227.31,2243.95],
        ['12:35', 2234.9,2227.74,2220.44,2253.42],
        ['12:40', 2232.69,2225.29,2217.25,2241.34],
        ['12:45', 2196.24,2211.59,2180.67,2212.59],
        ['12:50', 2215.47,2225.77,2215.47,2234.73],
        ['12:55', 2224.93,2226.13,2212.56,2233.04],
        ['13:00', 2236.98,2219.55,2217.26,2242.48],
        ['13:05', 2218.09,2206.78,2204.44,2226.26],
        ['13:10', 2199.91,2181.94,2177.39,2204.99],
        ['13:15', 2169.63,2194.85,2165.78,2196.43],
        ['13:20', 2195.03,2193.8,2178.47,2197.51],
        ['13:25', 2181.82,2197.6,2175.44,2206.03],
        ['13:30', 2201.12,2244.64,2200.58,2250.11],
        ['13:35', 2236.4,2242.17,2232.26,2245.12],
        ['13:40', 2242.62,2184.54,2182.81,2242.62],
        ['13:45', 2187.35,2218.32,2184.11,2226.12],
        ['13:50', 2213.19,2199.31,2191.85,2224.63],
        ['13:55', 2203.89,2177.91,2173.86,2210.58],
        ['14:00', 2170.78,2174.12,2161.14,2179.65],
        ['14:05', 2179.05,2205.5,2179.05,2222.81],
        ['14:10', 2212.5,2231.17,2212.5,2236.07],
        ['14:15', 2227.86,2235.57,2219.44,2240.26],
        ['14:20', 2242.39,2246.3,2235.42,2255.21],
        ['14:25', 2246.96,2232.97,2221.38,2247.86],
        ['14:30', 2228.82,2246.83,2225.81,2247.67],
        ['14:35', 2247.68,2241.92,2231.36,2250.85],
        ['14:40', 2238.9,2217.01,2205.87,2239.93],
        ['14:45', 2217.09,2224.8,2213.58,2225.19],
        ['14:50', 2221.34,2251.81,2210.77,2252.87],
        ['14:55', 2249.81,2282.87,2248.41,2288.09],
        ['15:00', 2286.33,2299.99,2281.9,2309.39],
        ['15:05', 2297.11,2305.11,2290.12,2305.3],
        ['15:10', 2303.75,2302.4,2292.43,2314.18],
        ['15:15', 2293.81,2275.67,2274.1,2304.95],
        ['15:20', 2281.45,2288.53,2270.25,2292.59],
        ['15:25', 2286.66,2293.08,2283.94,2301.7],
        ['15:30', 2293.4,2321.32,2281.47,2322.1],
        ['15:35', 2323.54,2324.02,2321.17,2334.33],
        ['15:40', 2316.25,2317.75,2310.49,2325.72],
        ['15:45', 2320.74,2300.59,2299.37,2325.53],
        ['15:50', 2300.21,2299.25,2294.11,2313.43],
        ['15:55', 2297.1,2272.42,2264.76,2297.1],
        ['16:00', 2270.71,2270.93,2260.87,2276.86],
        ['16:05', 2264.43,2242.11,2240.07,2266.69],
        ['16:10', 2242.26,2210.9,2205.07,2250.63],
        ['16:15', 2190.1,2148.35,2126.22,2190.1],
        ['16:20', 2293.4,2321.32,2281.47,2322.1],
        ['16:25', 2242.26,2210.9,2205.07,2250.63],
        ['16:30', 2270.71,2270.93,2260.87,2276.86],
        ['16:35', 2303.75,2302.4,2292.43,2314.18],
        ['16:40', 2221.34,2251.81,2210.77,2252.87],
        ['16:45', 2316.25,2317.75,2310.49,2325.72],
        ['16:50', 2217.09,2224.8,2213.58,2225.19],
        ['16:55', 2303.75,2302.4,2292.43,2314.18]
    ]);


    function splitData(rawData) {
        var categoryData = [];
        var values = []
        for (var i = 0; i < rawData.length; i++) {
            categoryData.push(rawData[i].splice(0, 1)[0]);
            values.push(rawData[i])
        }
        return {
            categoryData: categoryData,
            values: values
        };
    }

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
            data: data0.categoryData,
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
            data: calculateMA(1)
        }]
    };

    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }



    function calculateMA(dayCount) {
        var result = [];
        for (var i = 0, len = data0.values.length; i < len; i++) {
            if (i < dayCount) {
                result.push('-');
                continue;
            }
            var sum = 0;
            for (var j = 0; j < dayCount; j++) {
                sum += data0.values[i - j][1];
            }
            result.push(sum / dayCount);
        }
        return result;
    }

    function fetchData(cb) {
        // 通过 setTimeout 模拟异步加载
        setTimeout(function () {
            cb({
                categories: data0.categoryData,
                data:data0.values
            });
        }, 1000);
    }

    function change(type,val){
        myChart.setOption({
            series: [{
                // 根据名字对应到相应的系列
                name: '销量',
                type: type,
                data: val
            }]
        });
    }

    $(".sel_btn").click(function(){
        var data=$(this).attr('data');
        $(this).addClass('ch_cls');
        $(this).siblings().removeClass('ch_cls');
        switch(data)
        {
            case '0':
                var val=calculateMA(1);
                change('line',val);
                break;
            case '5':
                var val=data0.values;
                change('candlestick',val);
                break;
            case '15':
                var val=data0.values;
                change('candlestick',val);
                break;
            case '30':
                var val=data0.values;
                change('candlestick',val);
                break;
            case '60':
                var val=data0.values;
                change('candlestick',val);
                break;
            default:
        }
    });
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
        var _url='/stock/toCreateStockOrder';
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

            }
        });
    }
</script>
</html>
