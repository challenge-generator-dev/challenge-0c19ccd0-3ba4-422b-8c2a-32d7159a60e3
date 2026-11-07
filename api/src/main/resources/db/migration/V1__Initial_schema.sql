-- Script de migración inicial para el esquema de base de datos del servicio de órdenes
-- Crea las tablas necesarias para persistir órdenes y sus elementos
-- Versión: V1__Initial_schema.sql

-- Tabla principal de órdenes
CREATE TABLE orders (
    id UUID PRIMARY KEY,
    customer_id VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(19, 2) NOT NULL DEFAULT 0.00,
    CONSTRAINT uk_orders_id UNIQUE (id)
);

-- Tabla de elementos de orden (relación uno a muchos con orders)
CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id UUID NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    product_name VARCHAR(500) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(19, 2) NOT NULL CHECK (unit_price >= 0.00),
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) 
        REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uk_order_items_order_product UNIQUE (order_id, product_id)
);

-- Índice para búsquedas por customer_id
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- Índice para búsquedas por status
CREATE INDEX idx_orders_status ON orders(status);

-- Índice para búsquedas por fecha de creación
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);

-- Índice para búsquedas de items por order_id
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Índice para búsquedas de items por product_id
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Función para actualizar automáticamente updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para actualizar updated_at en la tabla orders
CREATE TRIGGER update_orders_updated_at
    BEFORE UPDATE ON orders
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger para actualizar updated_at en la tabla orders cuando se modifica un item
CREATE TRIGGER update_orders_updated_at_on_item_change
    AFTER INSERT OR UPDATE OR DELETE ON order_items
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Comentarios para documentación del esquema
COMMENT ON TABLE orders IS 'Almacena las órdenes del sistema de ventas';
COMMENT ON TABLE order_items IS 'Almacena los elementos (productos) de cada orden';
COMMENT ON COLUMN orders.customer_id IS 'Identificador único del cliente que realizó la orden';
COMMENT ON COLUMN orders.status IS 'Estado de la orden: PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED, CANCELLED';
COMMENT ON COLUMN orders.total_amount IS 'Monto total de la orden en formato decimal con 2 decimales';
COMMENT ON COLUMN order_items.quantity IS 'Cantidad de unidades del producto en esta línea de orden';
COMMENT ON COLUMN order_items.unit_price IS 'Precio unitario del producto en el momento de la orden';