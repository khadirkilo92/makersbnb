# MakersBNB
## Installing Locally

```ruby
$ git clone https://github.com/khadirkilo92/makersbnb.git
$ cd makersbnb
$ bundle install
$ rackup
```
## Run Web App

```ruby 
$ ruby app.rb
```
or

```ruby 
$ rackup config.ru
```

## Postgres Install

```ruby
$ brew install postgresql

$ brew services start postgresql

$ psql postgres
```
## Setup makersbnb and makersbnb_test Database

```sql
psql

CREATE DATABASE makersbnb;

\c makersbnb

CREATE TABLE spaces(id SERIAL PRIMARY KEY, name VARCHAR(40), description VARCHAR(240), price_per_night FLOAT4);

\q

CREATE DATABASE makersbnb_test;

\c makersbnb_test

CREATE TABLE spaces(id SERIAL PRIMARY KEY, name VARCHAR(40), description VARCHAR(240), price_per_night FLOAT4);

```

## MakersBNB Model

<img src="./images/makersbnb-mock-up.png">

## MakersBNB Web Pages


## User Stories