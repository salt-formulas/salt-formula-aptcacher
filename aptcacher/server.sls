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

{%- endif %}
