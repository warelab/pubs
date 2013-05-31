SET foreign_key_checks=0;

DROP TABLE IF EXISTS agency;
CREATE TABLE agency (
  agency_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  agency_name char(255) NOT NULL DEFAULT '',
  url_template char(255) NOT NULL DEFAULT '',
  UNIQUE (agency_name)
) ENGINE=InnoDB;

INSERT INTO `agency` VALUES (1,'unknown','');

DROP TABLE IF EXISTS funding;
CREATE TABLE funding (
  funding_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  agency_id int NOT NULL DEFAULT '1',
  award_number char(255) NOT NULL DEFAULT '',
  title text,
  abstract text,
  KEY (agency_id),
  FOREIGN KEY (agency_id) REFERENCES agency (agency_id)
) ENGINE=InnoDB;

INSERT INTO `funding` VALUES (1,1,'','unknown','');

DROP TABLE IF EXISTS pub;
CREATE TABLE pub (
  pub_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  funding_id int NOT NULL DEFAULT '1',
  year int NOT NULL DEFAULT '0',
  authors text NOT NULL DEFAULT '',
  title char(255) NOT NULL DEFAULT '',
  journal char(255) NOT NULL DEFAULT '',
  pubmed char(30) NOT NULL DEFAULT '',
  url char(255) NOT NULL DEFAULT '',
  data char(255) NOT NULL DEFAULT '',
  cover char(255) NOT NULL DEFAULT '',
  pdf char(255) NOT NULL DEFAULT '',
  info_115 char(255) NOT NULL DEFAULT '',
  KEY (funding_id),
  FOREIGN KEY (funding_id) REFERENCES funding (funding_id)
) ENGINE=InnoDB;
