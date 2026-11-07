package com.orderservice.infrastructure.persistence;


import com.orderservice.domain.OrderItem;
import com.orderservice.domain.Order;
import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "order_items")
public class OrderItemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String productId;

    @Column(nullable = false)
    private String productName;

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private BigDecimal unitPrice;

    public OrderItemEntity() {
    }

    public OrderItemEntity(String productId, String productName, int quantity, BigDecimal unitPrice) {
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

    public Order.OrderItem toDomain() {
        return new Order.OrderItem(productId, productName, quantity, unitPrice);
    }

    public static OrderItemEntity fromDomain(Order.OrderItem orderItem) {
        return new OrderItemEntity(
                orderItem.getProductId(),
                orderItem.getProductName(),
                orderItem.getQuantity(),
                orderItem.getUnitPrice()
        );
    }
}