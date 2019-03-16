# Deployer

[Deployer](https://deployer.org/) Docker image.

## Usage

Make sure you have added the deploy.php file to your project.

### Using docker hub

```sh
cd /your/project/path
docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa vertoo/deployer init
docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa vertoo/deployer deploy production
```

### Using local cloned repository

```sh
git clone git@github.com:vertoo/docker-deployer.git
cd docker-deployer
docker build -t deployer:latest .

# or use another UID
# to docker build add --build-arg like:
docker build --build-arg USER_ID=$(id -u)  -t deployer:latest .

# deploy your project
cd /your/project/path
docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa deployer init
docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa deployer deploy production
```

### Specify Deployer version

Use tag like `deployer:6.4.3`

## Example aliases

```sh
dep=docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa vertoo/deployer

# or using local image
dep=docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa deployer
```
