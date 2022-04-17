FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y libpq-dev nodejs yarn
RUN mkdir /redmine
WORKDIR /redmine
COPY ./src /redmine
COPY ./redmine/Gemfile /redmine/Gemfile
COPY ./redmine/Gemfile.lock /redmine/Gemfile.lock
COPY ./redmine/config/database.yml /redmine/config/database.yml
COPY ./redmine/config/environments/development.rb /redmine/config/environments/development.rb
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000 1234 26162

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]