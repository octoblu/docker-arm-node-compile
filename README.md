# docker-arm-node-compile
Docker image that compiles node packages for ARM v7

To run:

```shell
docker run \
  --rm \
  --volume /local/path:/export \
  octoblu/arm-node-compile \
    ./compile.sh <git-repository> <git-tag> <additional-apt-dependencies>

# Example for meshblu-connector-blink1
docker run \
  --rm \
  --volume ./dist:/export octoblu/arm-node-compile \
    ./compile.sh "https://github.com/octoblu/meshblu-connector-blink1" "v2.0.8"
```
