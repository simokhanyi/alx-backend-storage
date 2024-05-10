-- Trigger Description:
-- Decreases item quantity in 'items' table after new order addition in 'orders'.
-- Ensures accurate stock levels by updating quantities based on orders.
-- Executed after each 'orders' insertion.
-- Automated inventory management.

-- Create Trigger to Decrease Quantity
DELIMITER //
CREATE TRIGGER decrease_quantity_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END;
//
DELIMITER ;
