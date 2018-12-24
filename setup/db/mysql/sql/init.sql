CREATE USER 'expiry_sync'@'%' IDENTIFIED BY 'admin';
CREATE DATABASE expiry_sync CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON expiry_sync.* TO 'expiry_sync'@'%';