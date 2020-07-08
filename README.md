1. Get the Dockerfile and some test files from my forked github
```bash
git clone https://github.com/dikim33/unicorn.git uck 
``` 
2. Build a docker image with the given Dockerfile
```bash
cd uck
docker build -t <image_name> .
```
3. Run the challenge file
```bash
docker run --rm -it <image_name> uck/challenge.py uck/challenge.asm
docker run --rm -it <image_name> python uck/example_capstone.py
docker run --rm -it <image_name> python uck/example_keystone.py
docker run --rm -it <image_name> python uck/example_unicorn.py
```

If you would like to build another docker image for radare2 on top of the unicorn image
```bash
cd radare2
./build_docker_image.sh <your_temporary_private_ssh_key>
```
Please make sure that your public ssh key is already added to your github profile and 
the public key is paired with your temporary private ssh key.


This is a test texing.
