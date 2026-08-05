package com.ecommerce.service;

import com.ecommerce.dto.OrderDTO;
import com.ecommerce.dto.OrderItemDTO;
import com.ecommerce.entity.Order;
import com.ecommerce.entity.OrderItem;
import com.ecommerce.entity.Product;
import com.ecommerce.entity.User;
import com.ecommerce.exception.ApiException;
import com.ecommerce.repository.OrderRepository;
import com.ecommerce.repository.ProductRepository;
import com.ecommerce.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;

    public Page<OrderDTO> getUserOrders(Long userId, Pageable pageable) {
        if (!userRepository.existsById(userId)) {
            throw new ApiException("User not found", HttpStatus.NOT_FOUND);
        }
        Page<Order> orders = orderRepository.findByUserId(userId, pageable);
        return orders.map(this::convertToDTO);
    }

    public OrderDTO getOrderById(Long orderId) {
        Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new ApiException("Order not found", HttpStatus.NOT_FOUND));
        return convertToDTO(order);
    }

    @Transactional
    public OrderDTO createOrder(Long userId, OrderDTO dto) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ApiException("User not found", HttpStatus.NOT_FOUND));

        Order order = Order.builder()
            .user(user)
            .totalAmount(BigDecimal.ZERO)
            .build();

        BigDecimal total = BigDecimal.ZERO;

        for (OrderItemDTO itemDTO : dto.getItems()) {
            Product product = productRepository.findById(itemDTO.getProductId())
                .orElseThrow(() -> new ApiException("Product not found", HttpStatus.NOT_FOUND));

            if (product.getQuantity() < itemDTO.getQuantity()) {
                throw new ApiException("Insufficient stock for product: " + product.getName(), HttpStatus.BAD_REQUEST);
            }

            OrderItem item = OrderItem.builder()
                .order(order)
                .product(product)
                .quantity(itemDTO.getQuantity())
                .price(product.getPrice())
                .build();

            order.getItems().add(item);
            total = total.add(product.getPrice().multiply(BigDecimal.valueOf(itemDTO.getQuantity())));

            product.setQuantity(product.getQuantity() - itemDTO.getQuantity());
            productRepository.save(product);
        }

        order.setTotalAmount(total);
        Order saved = orderRepository.save(order);
        return convertToDTO(saved);
    }

    public OrderDTO updateOrderStatus(Long orderId, String status) {
        Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new ApiException("Order not found", HttpStatus.NOT_FOUND));

        order.setStatus(com.ecommerce.entity.OrderStatus.valueOf(status));
        Order updated = orderRepository.save(order);
        return convertToDTO(updated);
    }

    private OrderDTO convertToDTO(Order order) {
        List<OrderItemDTO> items = order.getItems().stream()
            .map(item -> OrderItemDTO.builder()
                .id(item.getId())
                .productId(item.getProduct().getId())
                .productName(item.getProduct().getName())
                .quantity(item.getQuantity())
                .price(item.getPrice())
                .build())
            .collect(Collectors.toList());

        return OrderDTO.builder()
            .id(order.getId())
            .userId(order.getUser().getId())
            .totalAmount(order.getTotalAmount())
            .status(order.getStatus())
            .items(items)
            .createdAt(order.getCreatedAt())
            .updatedAt(order.getUpdatedAt())
            .build();
    }
}
