package com.hiveview.entity;

import java.math.BigDecimal;
import java.util.Date;

public class StockOrder {
    private long id;

    private int userId;

    private String unionid;

    private Integer productId;

    private String productName;

    private BigDecimal buyPrice;

    private BigDecimal sellPrice;

    private BigDecimal buyAmount;

    private BigDecimal feeAmount;

    private Integer buyGoing;

    private Date updateTime;

    private Date addTime;

    private Date closePositionTime;

    private Integer changeQuantity;

    private String revenueModelCode;

    private Integer orderStatus;

    private BigDecimal revenueAmount;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public String getUnionid() {
        return unionid;
    }

    public void setUnionid(String unionid) {
        this.unionid = unionid;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getBuyPrice() {
        return buyPrice;
    }

    public void setBuyPrice(BigDecimal buyPrice) {
        this.buyPrice = buyPrice;
    }

    public BigDecimal getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(BigDecimal sellPrice) {
        this.sellPrice = sellPrice;
    }

    public BigDecimal getBuyAmount() {
        return buyAmount;
    }

    public void setBuyAmount(BigDecimal buyAmount) {
        this.buyAmount = buyAmount;
    }

    public BigDecimal getFeeAmount() {
        return feeAmount;
    }

    public void setFeeAmount(BigDecimal feeAmount) {
        this.feeAmount = feeAmount;
    }

    public Integer getBuyGoing() {
        return buyGoing;
    }

    public void setBuyGoing(Integer buyGoing) {
        this.buyGoing = buyGoing;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public Date getClosePositionTime() {
        return closePositionTime;
    }

    public void setClosePositionTime(Date closePositionTime) {
        this.closePositionTime = closePositionTime;
    }

    public Integer getChangeQuantity() {
        return changeQuantity;
    }

    public void setChangeQuantity(Integer changeQuantity) {
        this.changeQuantity = changeQuantity;
    }

    public String getRevenueModelCode() {
        return revenueModelCode;
    }

    public void setRevenueModelCode(String revenueModelCode) {
        this.revenueModelCode = revenueModelCode;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public BigDecimal getRevenueAmount() {
        return revenueAmount;
    }

    public void setRevenueAmount(BigDecimal revenueAmount) {
        this.revenueAmount = revenueAmount;
    }
}