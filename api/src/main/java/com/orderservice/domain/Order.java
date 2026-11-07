package com.orderservice.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class Order {
    private UUID id;
    private String customerId;
    private List<OrderItem> items;
    private OrderStatus status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private BigDecimal totalAmount;

    public Order(UUID id, String customerId, List<OrderItem> items, OrderStatus status) {
        this.id = id;
        this.customerId = customerId;
        this.items = items;
        this.status = status;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.totalAmount = calculateTotalAmount();
    }

    public UUID getId() {
        return id;
    }

    public String getCustomerId() {
        return customerId;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
        this.updatedAt = LocalDateTime.now();
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    private BigDecimal calculateTotalAmount() {
        return items.stream()
                .map(item -> item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public static class OrderItem {
        private String productId;
        private String productName;
        private int quantity;
        private BigDecimal unitPrice;

        public OrderItem(String productId, String productName, int quantity, BigDecimal unitPrice) {
            this.productId = productId;
            this.productName = productName;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
        }

        public String getProductId() {
            return productId;
        }

        public String getProductName() {
            return productName;
        }

        public int getQuantity() {
            return quantity;
        }

        public BigDecimal getUnitPrice() {
            return unitPrice;
        }
    }

    public enum OrderStatus {
        CREATED,
        PROCESSING,
        SHIPPED,
        DELIVERED,
        CANCELLED
    }
}