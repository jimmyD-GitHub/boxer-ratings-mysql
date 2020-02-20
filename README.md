# boxer-ratings-mysql
Development environment MySQL database and production schema documentation.

## Development

This application acts as a database server for the development environment. It also contains the MySQL schema and test 
data files that are shared with other BoxerRatings.com repositories that have this project as a composer dependency.

Use docker-compose to build and run it from your docker host:

```shell script
$ docker-compose up --build -d
```

To push a rebuilt version of the image just do:

```shell script
$ docker push jimmydockerhub/boxer-ratings-mysql:latest
```

## Production

The database is a MySQL instance hosted on AWS RDS.