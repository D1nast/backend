FROM ruby:3.1.2

#依存関係のインストール 公式ドキュメントに書いてあったからとりあえず入れた
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  build-essential \
  curl

#rbenvのインストール　インストール理由は上に同じく
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

# 上に同じく
ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"
RUN rbenv install 3.1.2 && rbenv global 3.1.2

WORKDIR /var/www

#Copy Gemfile
COPY Gemfile /var/www/Gemfile
COPY Gemfile.lock /var/www/Gemfile.lock
RUN gem install bundler && bundle install

#Copy my portfolio
COPY . /var/www/

#Setting Docker listen on port
EXPOSE 3001

#runnnig rails
CMD ["rails", "server", "-b", "0.0.0.0"]