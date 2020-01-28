# What image to use
FROM ruby:2.6.3

# Update the repo listins in the container
RUN apt-get update
# Install these packages into the container
RUN apt-get install --assume-yes --no-install-recommends build-essential postgresql-client ca-certificates nodejs

# Specify the environment variable APP with the path
ENV APP /usr/src/app

# This makes the directory for the app
RUN mkdir -p $APP

# This tells the container where we will be working from
WORKDIR $APP

# This copies the gemfile and gemfile.lock to the app folder
COPY Gemfile* $APP/

# This tells it to run install on as many threads as it has available
RUN bundle install --jobs=$(nproc)

# Copy our code to the app folder
COPY . $APP/

# This tells the container to create(?) your migrations
CMD ["bin/rails", "db:create"]

# This tells the container to run your migrations
CMD ["bin/rails", "db:migrate"]

# This tells the container to start the rails server on port 3000 and bind to wildcard IP
CMD ["bin/rails", "server", "-p", "3000", "-b", "0.0.0.0"]