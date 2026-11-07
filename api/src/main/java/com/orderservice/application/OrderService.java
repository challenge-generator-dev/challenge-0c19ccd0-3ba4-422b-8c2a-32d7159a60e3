package com.orderservice.application;

import com.orderservice.domain.Order;
import com.orderservice.domain.Order.OrderItem;
import com.orderservice.domain.Order.OrderStatus;
import com.orderservice.domain.OrderRepository;
import com.orderservice.infrastructure.aws.SQSOrderEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final SQSOrderEventPublisher eventPublisher;

    public OrderService(OrderRepository orderRepository, SQSOrderEventPublisher eventPublisher) {
        this.orderRepository = orderRepository;
        this.eventPublisher = eventPublisher;
    }

    @Transactional
    public Order createOrder(String customerId, List<OrderItem> items) {
        if (customerId == null || customerId.isBlank()) {
            throw new IllegalArgumentException("Customer ID cannot be null or empty");
        }
        if (items == null || items.isEmpty()) {
            throw new IllegalArgumentException("Order must contain at least one item");
        }

        for (OrderItem item : items) {
            if (item.getProductId() == null || item.getProductId().isBlank()) {
                throw new IllegalArgumentException("Product ID cannot be null or empty");
            }
            if (item.getQuantity() <= 0) {
                throw new IllegalArgumentException("Quantity must be positive");
            }
            if (item.getUnitPrice() == null || item.getUnitPrice().compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Unit price must be positive");
            }
        }

        Order order = new Order(
            UUID.randomUUID(),
            customerId,
            items,
            OrderStatus.PENDING
        );

        Order savedOrder = orderRepository.save(order);

        try {
            eventPublisher.publishOrderCreatedEvent(savedOrder);
        } catch (Exception e) {
            System.err.println("Failed to publish order created event: " + e.getMessage());
        }

        return savedOrder;
    }

    @Transactional(readOnly = true)
    public Optional<Order> getOrderById(UUID orderId) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        return orderRepository.findById(orderId);
    }

    @Transactional
    public Order updateOrderStatus(UUID orderId, OrderStatus newStatus) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        if (newStatus == null) {
            throw new IllegalArgumentException("Status cannot be null");
        }

        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isEmpty()) {
            throw new IllegalArgumentException("Order not found with ID: " + orderId);
        }

        Order order = orderOpt.get();
        OrderStatus previousStatus = order.getStatus();
        order.setStatus(newStatus);

        Order updatedOrder = orderRepository.save(order);

        try {
            eventPublisher.publishOrderStatusChangedEvent(updatedOrder, previousStatus);
        } catch (Exception e) {
            System.err.println("Failed to publish order status change event: " + e.getMessage());
        }

        return updatedOrder;
    }

    @Transactional(readOnly = true)
    public List<Order> getOrdersByCustomerId(String customerId) {
        if (customerId == null || customerId.isBlank()) {
            throw new IllegalArgumentException("Customer ID cannot be null or empty");
        }
        return List.of();
    }
}