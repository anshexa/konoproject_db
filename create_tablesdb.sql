CREATE TABLE country
(
	id serial PRIMARY KEY,
	name VARCHAR (64) UNIQUE NOT NULL,
	name_en VARCHAR (128) UNIQUE
);

CREATE TABLE genre
(
	id serial PRIMARY KEY,
	name VARCHAR (128) UNIQUE NOT NULL,
	name_en VARCHAR (128) UNIQUE
);

CREATE TABLE spoken_language
(
	id serial PRIMARY KEY,
	name VARCHAR (64),
	name_en VARCHAR (64),

	CONSTRAINT name_name_en_unique UNIQUE (name, name_en)
);

CREATE TABLE image
(
	id serial PRIMARY KEY,
	url VARCHAR (512),
	preview_url VARCHAR (512),
	type VARCHAR(10)
);

CREATE TABLE production_company
(
	id serial PRIMARY KEY,
	name VARCHAR (255) UNIQUE NOT NULL
);

CREATE TABLE profession
(
	id serial PRIMARY KEY,
	profession VARCHAR (20) UNIQUE NOT NULL,
	profession_en VARCHAR (20) UNIQUE,
	value VARCHAR (20)
);

CREATE TABLE person
(
	id serial PRIMARY KEY,
	idkp INT UNIQUE NOT NULL,
	name VARCHAR (128),
	name_en VARCHAR (128),
	birth_place JSON,
	death_place JSON,
	facts JSON,
	sex VARCHAR(7),

	fk_image_id INT REFERENCES image (id)
);

CREATE TABLE film
(
	id serial PRIMARY KEY,
	idkp INT UNIQUE NOT NULL,
	name VARCHAR (255) NOT NULL,
	name_en VARCHAR (255),
	year INT,
	description TEXT,
	short_description TEXT,
	rating JSONB,
	movie_length INT,
	age_rating INT,
	alternative_name VARCHAR (255),
	type VARCHAR (15),
	type_number INT,
	slogan VARCHAR (255),
	fees JSONB,
	premiere JSONB,
	votes JSONB,
	budget JSON,
	status VARCHAR (15),
	rating_mpaa VARCHAR (5),
	distributors JSON,
	names JSONB,
	external_id JSON,
	top10 INT,
	top250 INT,

	fk_poster_id INT REFERENCES image (id),
	fk_backdrop_id INT REFERENCES image (id),
	fk_logo_id INT REFERENCES image (id)
);

CREATE TABLE film_country
(
	film_id INT REFERENCES film (id),
	country_id INT REFERENCES country (id),

	CONSTRAINT film_country_pkey PRIMARY KEY (film_id, country_id)
);

CREATE TABLE film_genre
(
	film_id INT REFERENCES film (id),
	genre_id INT REFERENCES genre (id),

	CONSTRAINT film_genre_pkey PRIMARY KEY (film_id, genre_id)
);

CREATE TABLE film_spoken_language
(
	film_id INT REFERENCES film (id),
	spoken_language_id INT REFERENCES spoken_language (id),

	CONSTRAINT film_spoken_language_pkey PRIMARY KEY (film_id, spoken_language_id)
);

CREATE TABLE fact
(
	id serial PRIMARY KEY,
	value TEXT NOT NULL,
	type VARCHAR (32),
	spoiler BOOLEAN,

	fk_film_id INT REFERENCES film (id) NOT NULL
);


CREATE TABLE film_similar_film
(
	film_id INT REFERENCES film (id),
	similar_film_id INT REFERENCES film (id),

	CONSTRAINT film_similar_film_pkey PRIMARY KEY (film_id, similar_film_id)
);

CREATE TABLE review
(
	id serial PRIMARY KEY,
	idkp INT UNIQUE NOT NULL,
	movie_idkp INT NOT NULL,
	title TEXT,
	type VARCHAR (20),
	review TEXT NOT NULL,
	date TIMESTAMP,
	author VARCHAR (64),
	user_id INT,

	fk_film_id INT REFERENCES film (id) NOT NULL
);

CREATE TABLE comment
(
	id bigserial PRIMARY KEY,
	comment TEXT NOT NULL,
	date TIMESTAMP,
	author VARCHAR (64),
	user_id INT,

	fk_review_id INT REFERENCES review (id) NOT NULL
);

CREATE TABLE video
(
	id serial PRIMARY KEY,
	url VARCHAR (512) NOT NULL,
	name VARCHAR (255),
	type VARCHAR (15),
	site VARCHAR (32),
	size INT,

	fk_film_id INT REFERENCES film (id) NOT NULL
);

CREATE TABLE film_production_company
(
	film_id INT REFERENCES film (id),
	production_company_id INT REFERENCES production_company (id),

	CONSTRAINT film_production_company_pkey PRIMARY KEY (film_id, production_company_id)
);

CREATE TABLE person_profession
(
	id serial UNIQUE,

	person_id INT REFERENCES person (id),
	profession_id INT REFERENCES profession (id),

	CONSTRAINT person_profession_pkey PRIMARY KEY (id, person_id, profession_id),
	CONSTRAINT person_id_profession_id_unique UNIQUE (person_id, profession_id)
);

CREATE TABLE film_person_profession
(
	film_id INT REFERENCES film (id),
	person_profession_id INT REFERENCES person_profession (id),
	general  BOOLEAN,
	description TEXT,

	CONSTRAINT film_person_profession_pkey PRIMARY KEY (film_id, person_profession_id)
);
