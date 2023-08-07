# 1. DevOPS Training Assignment 1
## Step 1 Identify a Sample Application
	
	Example "Hello World" is chosen from https://fastapi.tiangolo.com/ simply return API response(Hello World).
```Python3
	from typing import Union

	from fastapi import FastAPI

	app = FastAPI()


	@app.get("/")
	def read_root():
		return {"Hello": "World"}


	@app.get("/items/{item_id}")
	def read_item(item_id: int, q: Union[str, None] = None):
		return {"item_id": item_id, "q": q}
		
```

**Created a runner app to run FastAPI Server on Port 3000**

```Python3
	import uvicorn

	from main import app

	uvicorn.run(app, host="0.0.0.0", port=3000)
```


## Step 2 Identify the Dependencies
	*  Python3.8
	*  fastapi
	*  uvicorn
	
	pip is used to install all required dependencies. Once done following command is used to generate all dependencies in one file.
	
	**pip freeze >requirement.txt**
	
## Step 3 Create a Docker file
```Dockerfile
	FROM python:3.8-slim # base python image

	MAINTAINER Faisal "faisalriaz@hotmail.com" # maintainer info

	ADD . /fastapi # creating directory name <fastapi>

	WORKDIR /fastapi # Set the working directory to <fastapi>
	COPY . /fastapi # copying all files from current directory to container 
	RUN pip install -r requirement.txt # installing dependencies

	ENTRYPOINT python3 run.py # running sample app after container is inititated.
```
## Step 4 Build the Docker Image
  
  **docker build . --tag faisalriaz/sample_fastapi:v1**

Above command will build the image with name "username/image name with tag.
Here the Username should be the Docker Hub username.
```txt
$ docker build .  -t faisalriazz/sample_fastapi:latest
[+] Building 2.3s (10/10) FINISHED                                  docker:default
 => [internal] load .dockerignore                                             0.1s
 => => transferring context: 2B                                               0.0s 
 => [internal] load build definition from Dockerfile                          0.0s 
 => => transferring dockerfile: 226B                                          0.0s 
 => [internal] load metadata for docker.io/library/python:3.8-slim            1.2s 
 => [1/5] FROM docker.io/library/python:3.8-slim@sha256:36ebeb57d8f126c0dfd4  0.0s
 => [internal] load build context                                             0.6s 
 => => transferring context: 168.65kB                                         0.6s 
 => CACHED [2/5] ADD . /fastapi                                               0.0s
 => CACHED [3/5] WORKDIR /fastapi                                             0.0s 
 => CACHED [4/5] COPY . /fastapi                                              0.0s 
 => CACHED [5/5] RUN pip install -r requirement.txt                           0.0s 
 => exporting to image                                                        0.0s
 => => exporting layers                                                       0.0s 
 => => writing image sha256:f025f201355b3086cef0dc7b38d25c3baf7693918aedf566  0.0s 
 => => naming to docker.io/faisalriazz/sample_fastapi:v1                      0.0s 

What's Next?
  View summary of image vulnerabilities and recommendations → docker scout quickview
```
**Run container from docker desktop to verify**

logs
```
2023-08-07 15:30:39 INFO:     Started server process [7]
2023-08-07 15:30:39 INFO:     Waiting for application startup.
2023-08-07 15:30:39 INFO:     Application startup complete.
2023-08-07 15:30:39 INFO:     Uvicorn running on http://0.0.0.0:3000 (Press CTRL+C to quit)
```
terminal

```
# pwd
/fastapi
# ls -ltra
total 48
drwxr-xr-x 1 root root 4096 Aug  7 06:02 venv
-rwxr-xr-x 1 root root  277 Aug  7 06:08 main.py
drwxr-xr-x 1 root root 4096 Aug  7 06:10 __pycache__
-rwxr-xr-x 1 root root   85 Aug  7 06:19 run.py
-rwxr-xr-x 1 root root  504 Aug  7 06:22 requirement.txt
-rwxr-xr-x 1 root root  187 Aug  7 06:46 Dockerfile
drwxr-xr-x 1 root root 4096 Aug  7 08:17 .git
drwxr-xr-x 1 root root 4096 Aug  7 10:17 .
drwxr-xr-x 1 root root 4096 Aug  7 10:30 ..
# python --version
Python 3.8.17
# pip list
Package           Version
----------------- -------
annotated-types   0.5.0
anyio             3.7.1
click             8.1.6
colorama          0.4.6
exceptiongroup    1.1.2
fastapi           0.101.0
h11               0.14.0
idna              3.4
pip               23.0.1
pydantic          2.1.1
pydantic_core     2.4.0
setuptools        57.5.0
sniffio           1.3.0
starlette         0.27.0
typing_extensions 4.7.1
uvicorn           0.23.2
wheel             0.41.0

[notice] A new release of pip is available: 23.0.1 -> 23.2.1
[notice] To update, run: pip install --upgrade pip

```
## Step 5 Push the Docker Image to Docker Hub
  
   Create a repository <sample_fastapi> in dockur hub
*  docker push faisalriazz/sample_fastapi:v1
```
docker push faisalriazz/sample_fastapi:v1
The push refers to repository [docker.io/faisalriazz/sample_fastapi]
a4b21fb47ea8: Pushed
950f68c544ef: Pushed
5f70bf18a086: Layer already exists
4211e7043899: Layer already exists
761fcd36e14e: Layer already exists
7185f4b9403a: Layer already exists
5f77f286226c: Layer already exists
c6e34807c2d5: Layer already exists
v1: digest: sha256:d9336fbd957905cd4462849c39862a1bdccc37b8ba560f81bf5f5c79c3ffc999 size: 2209

```
*  Using Docker Pull command to verify 
   docker pull faisalriazz/sample_fastapi:v1
```
v1: Pulling from faisalriazz/sample_fastapi
Digest: sha256:d9336fbd957905cd4462849c39862a1bdccc37b8ba560f81bf5f5c79c3ffc999
Status: Image is up to date for faisalriazz/sample_fastapi:v1
docker.io/faisalriazz/sample_fastapi:v1

What's Next?
  View summary of image vulnerabilities and recommendations → docker scout quickview faisalriazz/sample_fastapi:v1
 docker images
REPOSITORY                   TAG       IMAGE ID       CREATED          SIZE
faisalriazz/sample_fastapi   v1        f025f201355b   40 minutes ago   217MB
faisalriazz/sample_fastapi   latest    95a5cd02d5cb   4 hours ago      216MB

```
image can be accessed via public repository 
https://hub.docker.com/repository/docker/faisalriazz/sample_fastapi/general

## Step 6 Running the container
   **docker run -d -p 3000:3000 faisalriazz/sample_fastapi:v1 --name FastApiServer**
d2c0dc3b160aca56f2ad2643a0fd863fab11cec6240323bacc1c9613149e5b1f


	Above command will run container in detach mode at localhost port 3000 with container name "FastApiServer"

Verifying the server is running using curl
```
curl http://localhost:3000
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    17  100    17    0     0   1236      0 --:--:-- --:--:-- --:--:--  1416{"Hello":"World"}

```
## Step 7 Create Github repository
Git hub repository is created and can be accessed at

https://github.com/faisalriazz/DevOps_Assignment1




