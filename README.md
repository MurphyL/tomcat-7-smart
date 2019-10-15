### 运行环境

- OpenJDK 7
- Tomcat 8.5.47


### run

> 端口号：8080

```sh
docker run -d -p 9966:8080 --name=web -v $PWD:/webapps murphyl/smart-tomcat:v0.7
```

### build
```sh
docker build -t murphyl/smart-tomcat:v0.7 .
```

### restart

``` sh
docker start -i web
```

### remote debug

> 默认端口号：8000

```sh
docker run -d -p 9968:8080 -p 9969:8000 --name=web -v $PWD:/webapps murphyl/smart-tomcat:v0.1

```