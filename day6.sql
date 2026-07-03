lab 6
-- Create Role
CREATE ROLE 'app_readwrite';

-- Grant permissions to role
GRANT SELECT, INSERT, UPDATE, DELETE
ON *.*
TO 'app_readwrite';

-- Create User
CREATE USER 'ncit'@'localhost'
IDENTIFIED BY '1234567890';

-- Grant role to user
GRANT 'app_readwrite'
TO 'ncit'@'localhost';

-- Set the role to default
SET DEFAULT ROLE 'app_readwrite'
TO 'appuser'@'localhost';

-- Check grants
SHOW GRANTS FOR 'app_readwrite';

-- Revoke permissions
REVOKE UPDATE
ON *.*
FROM 'app_readwrite';

-- Revoke role from user
REVOKE 'app_readwrite'
FROM 'ncit'@'localhost';

-- Drop role
DROP ROLE 'app_readwrite';
