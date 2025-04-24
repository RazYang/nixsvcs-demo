``` shell
$ nix build 'github:razyang/nixsvcs-demo#hello210-musl64-image'
$ docker load -i ./result
$ docker run -it --rm hello210:latest /bin/init
Hello, world!
Hello, world!
Hello, world!
...
```

or with interactive image:
``` shell
$ nix build 'github:razyang/nixsvcs-demo#hello210-image-interactive'
$ docker load -i ./result
$ docker run -it --rm hello210:latest
```
