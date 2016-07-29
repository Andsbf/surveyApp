# An APi interface for Pandabot
Provide endpoints to create merchant triggers and fetch user metrics.

# Running development environment

```
# Seed database
rake integrations:upsert  # Integrations
rake templates:upsert     # Automation Workflows
```


```
export REDIS_HOST=localhost
export REDIS_PORT=6379

bundle exec rails s -p 3008
bundle exec sidekiq -C config/sidekiq.yml
```
