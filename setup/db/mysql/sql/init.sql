CREATE USER IF NOT EXISTS 'expiry_sync'@'%' IDENTIFIED BY 'admin';
SET PASSWORD FOR 'expiry_sync'@'%'=PASSWORD('admin');
CREATE DATABASE IF NOT EXISTS expiry_sync CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON expiry_sync.* TO 'expiry_sync'@'%';