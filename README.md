# C unit testing environment with Ceedling and friends

It also includes other useful tools like static code analyzers and code formatters.

## Setup environment

### Build Docker image

```sh
docker build -t embedded-cleancode:latest \
    --build-arg user=<user> --build-arg group=<group> \
    -f Dockerfile .
```

### Manage Docker as a non-root user

The Docker daemon binds to a Unix socket, not a TCP port. By default it's the  
root user that owns the Unix socket, and other users can only access it using  
sudo. The Docker daemon always runs as the root user.

If you don't want to preface the docker command with sudo, add users to it.
When the Docker daemon starts, it creates a Unix socket accessible by members
of the docker group.

1. Add your user to the docker group

```bash
sudo usermod -aG docker $USER
```

2. Verify that you can run docker commands without sudo

```bash
docker run hello-world
```

## Usage examples

1. Use it interactively

```bash
cd <local/path/to/your/project>
docker run -it --rm \
    -v ~/.bashrc:/root/.bashrc \
    -v $PWD:/usr/project \
    -u <user> \
    embedded-cleancode
root@<image-id>:/usr/project# ceedling --help
```

2. Assuming Ceedling project already exists

```bash
cd <local/path/to/your/project>
docker run -it --rm -v ~/.bashrc:/root/.bashrc \
    -v $PWD:/usr/project \
    -u <user> \
    embedded-cleancode \
    ceedling test:all
```

3. Test a module

```bash
cd <local/path/to/your/project>
$ docker run -it --rm -v ~/.bashrc:/root/.bashrc \
    -v <local/path/to/your/project:/usr/project \
    -w /usr/project/path/to/module \
    -u <user> \
    embedded-cleancode \
    ceedling test:<module>
```
