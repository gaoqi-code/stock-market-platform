package com.hiveview.entity;

public class StockRevenueModel {
    private Integer id;

    private Integer changeQuantity;

    private Double revenueNum;

    private String revenueCode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getChangeQuantity() {
        return changeQuantity;
    }

    public void setChangeQuantity(Integer changeQuantity) {
        this.changeQuantity = changeQuantity;
    }

    public Double getRevenueNum() {
        return revenueNum;
    }

    public void setRevenueNum(Double revenueNum) {
        this.revenueNum = revenueNum;
    }

    public String getRevenueCode() {
        return revenueCode;
    }

    public void setRevenueCode(String revenueCode) {
        this.revenueCode = revenueCode;
    }
}