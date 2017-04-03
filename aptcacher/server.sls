{%- from "aptcacher/map.jinja" import server with context %}
{%- if server.enabled %}

aptcacher_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

/etc/apt-cacher-ng:
  file.directory:
  - mode: 755
  - makedirs: true

/etc/apt-cacher-ng/acng.conf:
  file.managed:
  - source: salt://aptcacher/files/acng.conf.{{ grains.os_family }}
  - template: jinja
  - require:
    - file: /etc/apt-cacher-ng
    - pkg: aptcacher_packages

aptcacher_services:
  service.running:
  - enable: true
  - names: {{ server.services }}
  - watch:
    - file: /etc/apt-cacher-ng/acng.conf

{%- if grains.get('init', None) == 'systemd' %}
aptcacher_limits_override:
  file.managed:
  - name: /etc/systemd/system/apt-cacher-ng.service.d/override.conf
  - source: salt://aptcacher/files/systemd_override.conf
  - makedirs: true
  - template: jinja
  module.run:
  - name: service.systemctl_reload
  - onchanges:
    - file: /etc/systemd/system/apt-cacher-ng.service.d/override.conf
  - watch_in:
      - service: aptcacher_services
{%- else %}

aptcacher_init:
  file.managed:
  - name: /etc/default/apt-cacher-ng
  - source: salt://aptcacher/files/apt-cacher-ng-default
  - mode: 644
  - template: jinja
  - watch_in:
    service: aptcacher_services
{%- endif %}

{%- endif %}
