package com.orderservice.infrastructure.aws;

import com.orderservice.domain.Order;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import software.amazon.awssdk.services.sqs.SqsAsyncClient;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;
import software.amazon.awssdk.services.sqs.model.SendMessageResponse;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

@Component
public class SQSOrderEventPublisher {

    private static final Logger log = LoggerFactory.getLogger(SQSOrderEventPublisher.class);

    private final SqsAsyncClient sqsAsyncClient;
    private final String queueUrl;

    public SQSOrderEventPublisher(
            SqsAsyncClient sqsAsyncClient,
            @Value("${aws.sqs.queue-url:}") String queueUrl) {
        this.sqsAsyncClient = sqsAsyncClient;
        this.queueUrl = queueUrl;
    }

    public CompletableFuture<SendMessageResponse> publishOrderCreatedEvent(Order order) {
        if (queueUrl == null || queueUrl.isBlank()) {
            log.warn("SQS queue URL not configured, skipping event publication for order: {}", order.getId());
            return CompletableFuture.completedFuture(null);
        }

        Map<String, Object> eventPayload = buildOrderEventPayload(order);
        String messageBody = serializeToJson(eventPayload);

        SendMessageRequest request = SendMessageRequest.builder()
                .queueUrl(queueUrl)
                .messageBody(messageBody)
                .messageGroupId("order-events")
                .build();

        log.info("Publishing order created event for order ID: {}", order.getId());

        return sqsAsyncClient.sendMessage(request)
                .whenComplete((response, exception) -> {
                    if (exception != null) {
                        log.error("Failed to publish event for order: {}", order.getId(), exception);
                    } else {
                        log.info("Successfully published event for order: {}. MessageId: {}",
                                order.getId(), response.messageId());
                    }
                });
    }

    private Map<String, Object> buildOrderEventPayload(Order order) {
        Map<String, Object> payload = new HashMap<>();
        payload.put("eventType", "ORDER_CREATED");
        payload.put("orderId", order.getId().toString());
        payload.put("customerId", order.getCustomerId());
        payload.put("totalAmount", order.getTotalAmount().toString());
        payload.put("status", order.getStatus().name());
        payload.put("createdAt", order.getCreatedAt().toString());

        Map<String, Object> items = new HashMap<>();
        order.getItems().forEach(item -> {
            Map<String, Object> itemData = new HashMap<>();
            itemData.put("productId", item.getProductId());
            itemData.put("productName", item.getProductName());
            itemData.put("quantity", item.getQuantity());
            itemData.put("unitPrice", item.getUnitPrice().toString());
            items.put(item.getProductId(), itemData);
        });
        payload.put("items", items);

        return payload;
    }

    private String serializeToJson(Map<String, Object> payload) {
        StringBuilder json = new StringBuilder("{");
        int count = 0;
        for (Map.Entry<String, Object> entry : payload.entrySet()) {
            if (count > 0) {
                json.append(",");
            }
            json.append("\"").append(entry.getKey()).append("\":");
            json.append(serializeValue(entry.getValue()));
            count++;
        }
        json.append("}");
        return json.toString();
    }

    private String serializeValue(Object value) {
        if (value == null) {
            return "null";
        } else if (value instanceof String) {
            return "\"" + escapeJsonString((String) value) + "\"";
        } else if (value instanceof Number) {
            return value.toString();
        } else if (value instanceof Map) {
            return serializeToJson((Map<String, Object>) value);
        } else {
            return "\"" + value.toString() + "\"";
        }
    }

    private String escapeJsonString(String value) {
        return value.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}