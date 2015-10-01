FROM ruby:2.2.3
MAINTAINER nick@nickpellant.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --assume-yes \
  build-essential \
  nodejs \
  locales

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV APP_HOME /wedfest_api
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME

RUN cd $APP_HOME && bundle install --jobs 20 --retry 5

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
