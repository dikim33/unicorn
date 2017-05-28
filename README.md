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

