package com.hiveview.common;



public class Constants {
	
	/**
	 * 上传文件总目录
	 */
	public static String UPLOAD = "upload";

	/**
	 * apk上传目录
	 */
	public static String APK="tvapk";

	/**
	 * 分时线地址
	 */
	String M_0="http://stock2.finance.sina.com.cn/futures/api/json.php/IndexService.getInnerFuturesMiniKLine5m?symbol=";

	/**
	 * 消费类型--充值
	 */
	public static int TRADE_TYPE_CHONGZHI =1;

	/**
	 * 收支类型--收入
	 */
	public static int BALOFPAY_TYPE_SHOURU =1;

	/**
	 * 收支类型--支出
	 */
	public static int BALOFPAY_TYPE_ZHICHU =2;

	/**
	 * 买涨
	 */
	public static int BUY_GOING_ZHANG =1;

	/**
	 * 买跌
	 */
	public static int BUY_GOING_DIE =2;

}
