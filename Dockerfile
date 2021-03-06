FROM python:3.9

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DockerHOME=/home/app

ARG GITHUB_USER
ARG GITHUB_TOKEN

# User set variables
ENV GITHUB_USER=$GITHUB_USER
ENV GITHUB_TOKEN=$GITHUB_TOKEN
ENV GIT_REPO=github.com/sayga231/DjangoReady.git

# set work directory
RUN mkdir -p $DockerHOME

# where the code lives
WORKDIR $DockerHOME

# Install dependencies
RUN apt-get update -y
RUN apt-get install git -y
# RUN apt-get install gdal-bin --no-install-recommends -y
RUN apt-get clean -y
RUN pip install pipenv

# copy setup file to the docker home directory.
COPY setup.sh $DockerHOME

# port where the Django app runs
EXPOSE 8000

# Run setup that will copy and do all the work
RUN chmod +x setup.sh
ENTRYPOINT ./setup.sh
