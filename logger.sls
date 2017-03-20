/usr/local/bin/logger.sh:
  file.managed:
    - source: salt://logger.sh
    - mode: 755
    - user: root
    - group: root
  cron.present:
    - user: root
    - minute: 30
