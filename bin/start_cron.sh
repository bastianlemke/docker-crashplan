#!/bin/bash

# Run rsyslogd as that's how cron writes logs. Then save the environment to a file to load in the cron job,
# because cron by default runs jobs with a minimal environment and we want to include the passed in docker
# environment variables. Then just listen on the logs for changes.
rsyslogd && cron && env > /root/env.sh && tail -f /var/log/syslog /var/log/cron.log
