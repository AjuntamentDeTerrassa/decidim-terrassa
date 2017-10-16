web: bundle exec passenger start -p ${PORT:-3000} --max-pool-size ${WEB_CONCURRENCY:-2}
worker: bundle exec sidekiq -e ${RACK_ENV:-development} -C config/sidekiq.yml
release: bundle exec rake db:migrate
