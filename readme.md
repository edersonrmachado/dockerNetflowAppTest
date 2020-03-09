#### RUN ONLY APP DEPLOYMENT TEST
#### 1. DOWNLOAD GIT FILES FROM GITHUB
```
sudo git clone https://github.com/edersonrmachado/dockerNetflowAppTest.git
cd dockerNetflowAppTest
```
#### 2. PERMISSIONS TO FILES BE EXECUTABLES
```
sudo chmod +x onlyApp.sh sequenceOfTests.sh 
```
#### 2. START DOCKER
```
service docker start
```
#### 3. PULLING IMAGES FROM DOCKER HUB
```
docker image pull mysql:5.7 
docker image pull wordpress:php7.3 
```

#### 4. DEPLOY APPLICATION WITH SOLUTION TEST

```
sudo bash onlyApp.sh 3 2 onlyApp3x.csv
```  
first argument: number of app  to deploy
second argument: number of times that test will be run
third argument: name of csv file to store results
#### 5. DEPLOY MULTIPLES TESTS WITH BASH FILE
```
sudo bash sequenceOfTests.sh 
``` 