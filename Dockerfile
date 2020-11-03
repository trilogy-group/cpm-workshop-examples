FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir -p /app
WORKDIR /app
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN mv /root/.yarn /app
RUN rm -f /usr/bin/yarn
RUN ln -s /app/.yarn/bin/yarn /usr/bin/yarn
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler -v '2.1.4' && bundle install --jobs 20 --retry 5
RUN bundle install && yarn install
COPY . /app
RUN bundle exec rake db:migrate RAILS_ENV=development
RUN bundle exec rake assets:precompile

EXPOSE 5000

# Start the main process.
CMD ls
