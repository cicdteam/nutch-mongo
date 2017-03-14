# Apache Nutch wtih MongoDB as backend

Based on official Apache Nutch release (current Nutch version is 2.3.1).

## Supported tags and respective `Dockerfile` links

- alpine, latest [(Dockerfile)](Dockerfile)

## Used technologies

- Nutch 2.3.1
- OpenJDK 8
- Gora 0.6.1
- Gora MongoDB 0.6.1

## Start Nutch in development mode

Use `docker-compose.yml` file to run MongoDB and Apache Nutch

```
docker-compose up -d
docker-compose logs -f nutch
```

## Start Nutch in production mode

- Create youw own `Dockerfile`

```
FROM pure/nutch-mongo:alpine

ADD urls/ /urls/
ADD conf/ /nutch/conf/
```

- Create your own configuration files and seed list
  - **[urls/seeds.txt](urls/seeds.txt)** - file containing URLs to crawl
  - **[conf/gora.properties](conf/gora.properties)** - set MongoDB credentials and database name
  - **[conf/nutch-site.xml](conf/nutch-site.xml)** - tune your own crawler parametrs
  - **[conf/regex-urlfilter.txt](conf/regex-urlfilter.txt)** - set Regular Expressions for your URLS to crawl
- Build your own docker image:

```
docker build -t my-nutch .
```

- Run your own Nutch with desired count of iterations:

```
docker run \
    -d
    -e ITERATIONS=5 \
    --name my-crawler \
    my-nutch
```

- Check logs

```
docker logs -f my-nutch
```
