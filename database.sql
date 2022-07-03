CREATE TABLE IF NOT EXISTS `users` (
	`userid` int(11) NOT NULL AUTO_INCREMENT,
	`username` varchar(50) DEFAULT NULL,
	`license` varchar(50) DEFAULT NULL,
	`steam` varchar(20) DEFAULT NULL,
	`fivem` varchar(10) DEFAULT NULL,
	`discord` varchar(20) DEFAULT NULL,
	PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `characters` (
	`charid` int(11) NOT NULL AUTO_INCREMENT,
	`userid` int(11) NOT NULL,
	`firstname` varchar(50) NOT NULL,
	`lastname` varchar(50) NOT NULL,
	`gender` varchar(50) NOT NULL,
	`dateofbirth` date NOT NULL,
	`phone_number` varchar(20) NOT NULL,
	`last_played` date NOT NULL DEFAULT curdate(),
	`is_dead` tinyint(1) NOT NULL DEFAULT 0,
	`x` float DEFAULT NULL,
	`y` float DEFAULT NULL,
	`z` float DEFAULT NULL,
	`heading` float DEFAULT NULL,
	`inventory` longtext NOT NULL DEFAULT '[]',
	PRIMARY KEY (`charid`) USING BTREE,
	KEY `FK_character_users` (`userid`) USING BTREE,
	CONSTRAINT `FK_characters_users` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `user_accounts` (
	`charid` int(11) NOT NULL,
	`name` varchar(50) NOT NULL,
	`amount` int(11) NOT NULL DEFAULT 0,
	UNIQUE KEY `name` (`name`, `charid`) USING BTREE,
	KEY `FK_user_accounts_characters` (`charid`) USING BTREE,
	CONSTRAINT `FK_user_accounts_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `ox_groups` (
	`name` VARCHAR(20) NOT NULL,
	`label` VARCHAR(50) NOT NULL,
	`grades` LONGTEXT NOT NULL,
	PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB;

INSERT INTO `ox_groups` (`name`, `label`, `grades`)
VALUES (
		'sheriff',
		'Sheriff',
		'["Commander", "Chief"]'
	);

CREATE TABLE IF NOT EXISTS `user_groups` (
	`charid` int(11) NOT NULL,
	`name` varchar(50) NOT NULL,
	`grade` int(11) NOT NULL,
	UNIQUE KEY `name` (`name`, `charid`) USING BTREE,
	KEY `FK_user_groups_characters` (`charid`) USING BTREE,
	CONSTRAINT `FK_user_groups_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `ox_inventory` (
	`owner` varchar(60) DEFAULT NULL,
	`name` varchar(60) NOT NULL,
	`data` longtext DEFAULT NULL,
	`lastupdated` timestamp NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
	UNIQUE KEY `owner` (`owner`, `name`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `vehicles` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`plate` CHAR(8) NOT NULL DEFAULT '',
	`owner` INT(11) NULL DEFAULT NULL,
	`model` VARCHAR(20) NOT NULL,
	`class` TINYINT(1) NULL DEFAULT NULL,
	`type` VARCHAR(10) NOT NULL DEFAULT 'automobile',
	`data` LONGTEXT NOT NULL,
	`trunk` LONGTEXT NULL DEFAULT NULL,
	`glovebox` LONGTEXT NULL DEFAULT NULL,
	`stored` VARCHAR(50) NOT NULL DEFAULT 'false',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `plate` (`plate`) USING BTREE,
	INDEX `FK_vehicles_characters` (`owner`) USING BTREE,
	CONSTRAINT `FK_vehicles_characters` FOREIGN KEY (`owner`) REFERENCES `overextended`.`characters` (`charid`) ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE = InnoDB;