-- Function Description:
-- Safely divides two integers 'a' and 'b', returning a FLOAT result.
-- Parameters:
--   - a: Numerator (INT)
--   - b: Denominator (INT)
-- If 'b' is 0, sets the result to 0 to avoid division by zero error.
-- Otherwise, computes the division of 'a' by 'b' and returns the result.

DELIMITER //

CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS FLOAT
BEGIN
    DECLARE result FLOAT;

    IF b = 0 THEN
        SET result = 0;
    ELSE
        SET result = a / b;
    END IF;

    RETURN result;
END //

DELIMITER ;
