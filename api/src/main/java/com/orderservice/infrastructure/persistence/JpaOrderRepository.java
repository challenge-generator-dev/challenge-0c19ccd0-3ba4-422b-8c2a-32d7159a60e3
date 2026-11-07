package com.orderservice.infrastructure.persistence;

import com.orderservice.domain.Order;
import com.orderservice.domain.OrderRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public class JpaOrderRepository implements OrderRepository {
    private final SpringDataOrderRepository springDataOrderRepository;

    public JpaOrderRepository(SpringDataOrderRepository springDataOrderRepository) {
        this.springDataOrderRepository = springDataOrderRepository;
    }

    @Override
    public Order save(Order order) {
        OrderEntity entity = OrderEntity.fromDomain(order);
        OrderEntity savedEntity = springDataOrderRepository.save(entity);
        return savedEntity.toDomain();
    }

    @Override
    public Optional<Order> findById(UUID id) {
        return springDataOrderRepository.findById(id).map(OrderEntity::toDomain);
    }
}