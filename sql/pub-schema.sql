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
  title char(255) NOT NULL DEFAULT 'unknown',
  award_number char(255) NOT NULL DEFAULT '',
  abstract text,
  UNIQUE (agency_id, title),
  KEY (agency_id),
  FOREIGN KEY (agency_id) REFERENCES agency (agency_id)
) ENGINE=InnoDB;

INSERT INTO `funding` (funding_id, agency_id, title) VALUES (1,1,'unknown');

DROP TABLE IF EXISTS pub;
CREATE TABLE pub (
  pub_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  year int NOT NULL DEFAULT '0',
  title char(255) NOT NULL DEFAULT '',
  journal char(255) NOT NULL DEFAULT '',
  pubmed char(30) NOT NULL DEFAULT '',
  authors text NOT NULL DEFAULT '',
  url char(255) NOT NULL DEFAULT '',
  data_path char(255) NOT NULL DEFAULT '',
  comments text NOT NULL DEFAULT '',
  hide_from_view tinyint NOT NULL DEFAULT '0',
  cover char(255) NOT NULL DEFAULT '',
  pdf char(255) NOT NULL DEFAULT '',
  doc_115 char(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB;

DROP TABLE IF EXISTS pub_to_funding;
CREATE TABLE pub_to_funding (
  pub_to_funding_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  pub_id int NOT NULL DEFAULT '1',
  funding_id int NOT NULL DEFAULT '1',
  UNIQUE (pub_id, funding_id),
  KEY (pub_id),
  KEY (funding_id),
  FOREIGN KEY (pub_id) REFERENCES pub (pub_id),
  FOREIGN KEY (funding_id) REFERENCES funding (funding_id)
) ENGINE=InnoDB;
