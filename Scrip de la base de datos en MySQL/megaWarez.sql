CREATE SCHEMA IF NOT EXISTS mega_warez DEFAULT CHARACTER SET utf8 ;
USE mega_warez ;

/************ Update: Tables ***************/

/******************** Add Table: category ************************/

/* Build Table Structure */
CREATE TABLE category
(
	cat_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	cat_name VARCHAR(80) NOT NULL,
	cat_created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Add Indexes */
CREATE UNIQUE INDEX category_cat_name_Idx ON category (cat_name) USING BTREE;


/******************** Add Table: download ************************/

/* Build Table Structure */
CREATE TABLE download
(
	dwn_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	dwn_user_id INTEGER UNSIGNED NOT NULL,
	dwn_item_id INTEGER UNSIGNED NOT NULL,
	dwn_created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Add Indexes */
CREATE INDEX download_dwn_item_id_Idx ON download (dwn_item_id) USING BTREE;

CREATE INDEX download_dwn_user_id_Idx ON download (dwn_user_id) USING BTREE;

CREATE INDEX download_dwn_user_id_dwn_item_id_Idx ON download (dwn_user_id, dwn_item_id) USING BTREE;


/******************** Add Table: item ************************/

/* Build Table Structure */
CREATE TABLE item
(
	itm_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	itm_subcategory_id INTEGER UNSIGNED NOT NULL,
	itm_name VARCHAR(80) NOT NULL,
	itm_created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Add Indexes */
CREATE UNIQUE INDEX item_itm_name_Idx ON item (itm_name) USING BTREE;

CREATE INDEX item_itm_subcategory_id_Idx ON item (itm_subcategory_id) USING BTREE;


/******************** Add Table: session ************************/

/* Build Table Structure */
CREATE TABLE session
(
	ses_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	ses_user_id INTEGER UNSIGNED NOT NULL,
	ses_token VARCHAR(32)
		COMMENT 'Hash con md5' NOT NULL,
	ses_created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Add Indexes */
CREATE INDEX session_ses_user_id_Idx ON session (ses_user_id) USING BTREE;


/******************** Add Table: subcategory ************************/

/* Build Table Structure */
CREATE TABLE subcategory
(
	scat_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	scat_category_id INTEGER UNSIGNED NOT NULL,
	scat_name VARCHAR(80) NOT NULL,
	scat_created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Add Indexes */
CREATE INDEX subcategory_scat_category_id_Idx ON subcategory (scat_category_id) USING BTREE;

CREATE UNIQUE INDEX subcategory_scat_name_scat_category_id_Idx ON subcategory (scat_name, scat_category_id) USING BTREE;


/******************** Add Table: user ************************/

/* Build Table Structure */
CREATE TABLE user
(
	use_id INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	use_username VARCHAR(80) NOT NULL,
	use_password VARCHAR(32)
		COMMENT 'Hash con md5' NOT NULL,
	use_created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	use_updated_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Add Indexes */
CREATE UNIQUE INDEX user_use_username_Idx ON user (use_username) USING BTREE;

CREATE INDEX user_use_username_use_password_Idx ON user (use_username, use_password) USING BTREE;





/************ Add Foreign Keys ***************/

/* Add Foreign Key: fk_download_item */
ALTER TABLE download ADD CONSTRAINT fk_download_item
	FOREIGN KEY (dwn_item_id) REFERENCES item (itm_id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_download_user */
ALTER TABLE download ADD CONSTRAINT fk_download_user
	FOREIGN KEY (dwn_user_id) REFERENCES user (use_id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_item_subcategory */
ALTER TABLE item ADD CONSTRAINT fk_item_subcategory
	FOREIGN KEY (itm_subcategory_id) REFERENCES subcategory (scat_id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_session_user */
ALTER TABLE session ADD CONSTRAINT fk_session_user
	FOREIGN KEY (ses_user_id) REFERENCES user (use_id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;

/* Add Foreign Key: fk_subcategory_category */
ALTER TABLE subcategory ADD CONSTRAINT fk_subcategory_category
	FOREIGN KEY (scat_category_id) REFERENCES category (cat_id)
	ON UPDATE NO ACTION ON DELETE NO ACTION;