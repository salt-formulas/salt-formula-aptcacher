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
    - module: aptcacher_limits_override

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
{%- else %}
    - file: /etc/init.d/apt-cacher-ng

aptcacher_init:
  file.managed:
  - name: /etc/init.d/apt-cacher-ng
  - source: salt://aptcacher/files/apt-cacher-ng-init
  - mode: 755
  - template: jinja
{%- endif %}

{%- endif %}
