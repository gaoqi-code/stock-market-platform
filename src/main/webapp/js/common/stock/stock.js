// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main_m'));
var categoryData = new Array();
var values = new Array();
var lineType=0;
var timer;
var layer_pay;
var layer_pass;

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
        data : categoryData,
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
    series: [
        {
            name: '分时线',
            type: 'line',
            data: values
        },
        {
            name: 'k线',
            type: 'candlestick',
            data: [ ]
        }
    ]
};

if (option && typeof option === "object") {
    myChart.setOption(option, true);
}


function toLoadView(line) {
    lineType=line;
    $.ajax({
        type: "POST",
        url:"/stock/toGetInitData.json",
        data:{lineType:lineType},
        dataType: "json",
        error: function(){
            alert('获取数据失败！');
        },
        success: function(obj) {
            if(obj != ''&& obj.code!=0){
                var data=obj.data;
                values=[];
                categoryData=[];
                for(var i=0;i<data.length;i++){
                    if(lineType==0){
                        values.push(data[i].price);
                        categoryData.push(new Date(data[i].dataTime).Format("hh:mm"));
                    }else {
                        // 数据意义：开盘(open)，收盘(close)，最低(lowest)，最高(highest)
                        values.push([data[i].openingPrice,data[i].lastClosingPrice,data[i].maxPrice,data[i].minPrice]);
                        categoryData.push(new Date(data[i].dataTime).Format("hh:mm"));
                    }
                }
                setOption();//设置线型
            }else {
                //信息框
                layer.open({
                    content: obj.msg
                    ,btn: '我知道了'
                });
            }
        }
    });

}

/* 根据选择的k线设置图形 */
function setOption(){
    if(lineType==0){
        myChart.setOption({
            xAxis: {
                data: categoryData
            },
            series: [
                {
                    name:'分时线',
                    data: values
                },
                {
                    name:'k线',
                    data: []
                }
            ]
        });
        clearInterval(timer);
        timer=setInterval(getFreshData,1000);
    }else{
        myChart.setOption({
            xAxis: {
                data: categoryData
            },
            series: [
                {
                    name:'分时线',
                    data: []
                },
                {
                    name:'k线',
                    data: values
                }
            ]
        });
        clearInterval(timer);
        timer=setInterval(getFreshData,5*1000);
    }
}
function getFreshData(){
    $.ajax({
        type: "post",
        url: "/stock/toGetOneFreshData.json",
        data:{lineType:lineType},
        dataType: "json",
        success: function(obj){
            if(obj!= ''&&obj.code!=0){
                var data=obj.data;
                if(lineType==0){
                    values.push(data[0].price);
                    categoryData.push(new Date(data[0].dataTime).Format("hh:mm"));
                    values.shift();
                    categoryData.shift();
                }else {
                    // 数据意义：开盘(open)，收盘(close)，最低(lowest)，最高(highest)
                    values.push([data[0].openingPrice,data[0].lastClosingPrice,data[0].maxPrice,data[0].minPrice]);
                    categoryData.push(new Date(data[0].dataTime).Format("hh:mm"));
                    values.shift();
                    categoryData.shift();
                }
                setOption();
            }else {
                //信息框
                layer.open({
                    content: obj.msg
                    ,btn: '我知道了'
                });
            }
        }
    });
}
if (option && typeof option === "object") {
    myChart.setOption(option, true);
    //window.onresize = myChart.resize;
}

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
            layer_pay=index;
            passWordDialog()
        },
        no:function(index){
        }
    });
}

function passWordDialog(){
    layer.open({
        type: 1,
        anim: 'scale',
        btn: ['确定', '取消'],
        shade: 'background-color: rgba(0,0,0,.3)',//遮罩层
        fix: false,
        move: false,//拖拽
        offset: 'auto',
        content: '<div id="pass">'+$('#passwordDiv').html()+'</div>',//这里content是一个DOM
        style: 'width:80%; height:150px;',
        yes:function(index){
            layer_pass=index;
            //校验密码
            checkPassWord();
        },
        no:function(index){
        }
    });
}

function checkPassWord(){
    var _url='/member/toCheckPass.json';
    var password=$("#pass input[type='password']").val();
    if(password.length==0||password==''){
            layer.open({
                content: '请输入交易密码！'
                ,btn: '我知道了'
            });
        }else {
            $.ajax({
                type: "POST",
                url:_url,
                data:{pass:password},
                dataType: "json",
                error: function(){
                    alert('获取数据失败！');
                },
                success: function(data) {
                    if(data){
                        layer.close(layer_pass);
                        toCreateStockOrder();//密码校验通过，提交订单
                    }else {
                        layer.open({
                            content: '密码错误！'
                            ,btn: '我知道了'
                        });
                    }
                }
            });
        }
}

function toCreateStockOrder() {
    var _url='/stock/toCreateStockOrder.json';
    var balance=$("#balance").val();
    if(balance==0||balance==''){
        layer.open({
            content: '余额不足！'
            ,btn: '我知道了'
        });
    }else {
        $.ajax({
            type: "POST",
            url:_url,
            data:$('#createOrderForm').serialize(),
            dataType: "json",
            error: function(){
                alert('获取数据失败！');
            },
            success: function(data) {

                if(data!=''&&data.code==1){
                    //信息框
                    layer.open({
                        content: '下单成功！'
                        ,btn: '我知道了'
                    });
                    layer.close(layer_pay);
                }else {
                    layer.open({
                        content: data.msg
                        ,btn: '我知道了'
                    });
                }
            }
        });
    }
}