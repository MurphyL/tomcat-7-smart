### 运行环境

- OpenJDK 7
- Tomcat 8.5.47


### run
```sh
docker run -it -p 9966:8080 -v $PWD:/usr/smart/target murphyl/smart-tomcat:v0.7
```

### build
```sh
docker build -t murphyl/smart-tomcat:v0.7 .
```

### 其他

- start_tomcat.sh 暂时无用
- TODO 远程DEBUG