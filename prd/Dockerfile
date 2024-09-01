FROM ruby:3.1.2
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle install
ADD . /app
EXPOSE 3000

RUN mkdir -p /app/tmp/pids /app/log
RUN chmod -R 755 /app/tmp /app/log

CMD ["/bin/sh", "-c", "bundle exec rails db:create && bundle exec rails db:migrate && bundle exec unicorn -p 3000 -c /app/config/unicorn.rb -E production"]


