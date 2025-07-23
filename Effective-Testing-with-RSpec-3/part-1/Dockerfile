FROM ruby:2.6

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y build-essential \
  && gem install bundler -v "~> 1.17.3"

RUN bundle install

CMD ["bash"]