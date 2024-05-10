-- Trigger Description:
-- Resets 'valid_email' to 0 before updating a user's email in 'users' table.
-- Ensures 'valid_email' reflects email changes, potentially requiring revalidation.
-- Fired before each 'users' table update, affecting each row individually.
-- Sets 'valid_email' to 0 if new email differs from old email.
-- Enforces email validation procedures and maintains data integrity.

CREATE TRIGGER reset_valid_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.email != OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END;
