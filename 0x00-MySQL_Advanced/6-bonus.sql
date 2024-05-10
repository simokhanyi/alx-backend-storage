-- Procedure Description:
-- This stored procedure, 'AddBonus', is designed to add bonus scores for a specific user and project in the database.
-- It takes three input parameters: 'p_user_id' (user ID), 'p_project_name' (project name), and 'p_score' (bonus score).
-- The procedure first checks if the project exists by querying the 'projects' table based on the provided project name.
-- If the project does not exist, it creates a new project entry in the 'projects' table.
-- Then, it inserts a new record into the 'corrections' table with the provided user ID, project ID, and bonus score.
-- This procedure is useful for managing bonus scoring systems within the application.

DELIMITER //

CREATE PROCEDURE AddBonus(
    IN p_user_id INT,
    IN p_project_name VARCHAR(255),
    IN p_score INT
)
BEGIN
    DECLARE project_id INT;

    -- Check if the project exists, if not, create it
    SELECT id INTO project_id FROM projects WHERE name = p_project_name;
    
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (p_project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;

    -- Add the correction
    INSERT INTO corrections (user_id, project_id, score) VALUES (p_user_id, project_id, p_score);
END//

DELIMITER ;
