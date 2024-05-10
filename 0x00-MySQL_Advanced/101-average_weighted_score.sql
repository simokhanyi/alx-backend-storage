-- Procedure Description:
-- Computes the average weighted score for all users in the database.
-- Iterates over each user using a cursor, calculating their total weighted score and total weight.
-- Updates the 'average_score' column in the 'users' table with the computed average weighted score for each user.

DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE user_id_var INT;
    DECLARE total_score FLOAT;
    DECLARE total_weight FLOAT;
    
    -- Cursor to iterate over each user
    DECLARE user_cursor CURSOR FOR
        SELECT id FROM users;
    
    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET user_id_var = NULL;
    
    OPEN user_cursor;
    
    user_loop: LOOP
        FETCH user_cursor INTO user_id_var;
        
        -- Exit loop if no more users
        IF user_id_var IS NULL THEN
            LEAVE user_loop;
        END IF;
        
        -- Calculate total weighted score for the user
        SELECT SUM(corrections.score * projects.weight) INTO total_score
        FROM corrections
        INNER JOIN projects ON corrections.project_id = projects.id
        WHERE corrections.user_id = user_id_var;
        
        -- Calculate total weight for the user
        SELECT SUM(projects.weight) INTO total_weight
        FROM corrections
        INNER JOIN projects ON corrections.project_id = projects.id
        WHERE corrections.user_id = user_id_var;
        
        -- Compute average weighted score
        IF total_weight > 0 THEN
            UPDATE users
            SET average_score = total_score / total_weight
            WHERE id = user_id_var;
        ELSE
            UPDATE users
            SET average_score = 0
            WHERE id = user_id_var;
        END IF;
    END LOOP;
    
    CLOSE user_cursor;
END //

DELIMITER ;
