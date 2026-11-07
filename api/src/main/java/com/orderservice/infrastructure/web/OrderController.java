package com.orderservice.infrastructure.web;

import com.orderservice.application.OrderService;
import com.orderservice.domain.Order;
import com.orderservice.domain.Order.OrderItem;
import com.orderservice.domain.Order.OrderStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private static final Logger log = LoggerFactory.getLogger(OrderController.class);

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponseDTO> createOrder(@RequestBody OrderRequestDTO request) {
        log.info("Received create order request for customer: {}", request.customerId());

        List<OrderItem> items = request.items().stream()
                .map(itemDTO -> new OrderItem(
                        itemDTO.productId(),
                        itemDTO.productName(),
                        itemDTO.quantity(),
                        itemDTO.unitPrice()))
                .toList();

        Order createdOrder = orderService.createOrder(request.customerId(), items);

        log.info("Order created successfully with ID: {}", createdOrder.getId());

        OrderResponseDTO response = toResponseDTO(createdOrder);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponseDTO> getOrder(@PathVariable UUID id) {
        log.info("Received get order request for ID: {}", id);

        return orderService.getOrderById(id)
                .map(order -> {
                    log.info("Order found for ID: {}", id);
                    return ResponseEntity.ok(toResponseDTO(order));
                })
                .orElseGet(() -> {
                    log.warn("Order not found for ID: {}", id);
                    return ResponseEntity.notFound().build();
                });
    }

    private OrderResponseDTO toResponseDTO(Order order) {
        List<OrderItemDTO> itemDTOs = order.getItems().stream()
                .map(item -> new OrderItemDTO(
                        item.getProductId(),
                        item.getProductName(),
                        item.getQuantity(),
                        item.getUnitPrice()))
                .toList();

        return new OrderResponseDTO(
                order.getId(),
                order.getCustomerId(),
                itemDTOs,
                order.getStatus().name(),
                order.getCreatedAt().toString(),
                order.getUpdatedAt() != null ? order.getUpdatedAt().toString() : null,
                order.getTotalAmount());
    }

    public record OrderRequestDTO(String customerId, List<OrderItemDTO> items) {}

    public record OrderItemDTO(String productId, String productName, int quantity, BigDecimal unitPrice) {}

    public record OrderResponseDTO(
            UUID id,
            String customerId,
            List<OrderItemDTO> items,
            String status,
            String createdAt,
            String updatedAt,
            BigDecimal totalAmount) {}
}