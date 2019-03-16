# Deployer

Warning: beta version

## Arguments

`USER_ID` - User UID, default `1000`

## Usage

```sh
docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa deployer init
docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa deployer deploy production
```

### Specify another UID

```sh
docker build --build-arg USER_ID=$(id -u) -t deployer:latest .
```

### Specify Deployer version

Use tag like `deployer:6.4.3`

## Example alias

```sh
dep=docker run --rm -it -v `pwd`:/app -v $HOME/.ssh/id_rsa:/home/deployer/.ssh/id_rsa deployer
```
