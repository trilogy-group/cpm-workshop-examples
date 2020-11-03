FROM ruby:2.6.6
RUN apt remove cmdtest && apt-get update -qq && apt-get install -y nodejs && apt-get install -y yarn
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler -v '2.1.4' && bundle install --jobs 20 --retry 5
RUN bundle install
RUN yarn install
COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 5000

# Start the main process.
CMD ls
