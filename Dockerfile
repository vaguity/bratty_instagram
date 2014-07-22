FROM ubuntu:12.04
MAINTAINER Sean Connolly "sc@skift.com"

# Set shell to noninteractive
# ENV DEBIAN_FRONTEND noninteractive

# Installing: wget, git, ruby
# These are dependencies for compiling certain gems with native extensions

RUN apt-get update
RUN apt-get install -y make
RUN apt-get install -y gcc
RUN apt-get install -y wget git-core
RUN apt-get install -y build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
RUN apt-get install -y libxslt-dev libxml2-dev
RUN apt-get install -y ruby
RUN apt-get install -y ruby1.9.1-dev

# Update repos
RUN apt-get update

# Add bundler
RUN gem install -y bundler --no-rdoc --no-ri

RUN git clone https://github.com/dannguyen/bratty_instagram.git /home/bratty_instagram

# Setup project environment
RUN cd /home/bratty_instagram; bundle install

# Open port
EXPOSE 80

# Run daemon
CMD ["/usr/local/bin/foreman","start","-d","/home/bratty_instagram"]
# ENTRYPOINT ["/usr/local/bin/foreman","start","-d","/home/sinatra"]

# Finished
