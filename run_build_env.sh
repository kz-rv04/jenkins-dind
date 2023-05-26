cd /repo
docker build -f Dockerfile.build_env -t build_env:v1 .
docker run --rm -it build_env:v1