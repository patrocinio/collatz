FROM ruby

ARG version
ARG component

COPY $component/$version/Gemfile /
RUN bundle install
COPY $component/$version/* /
CMD ["ruby", "/Collatz.rb"]