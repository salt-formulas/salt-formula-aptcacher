{%- from "apt-cacher/map.jinja" import server with context %}
{%- if server.enabled %}

aptcacher_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

/etc/apt-cacher-ng/apt-cacher.conf:
  file.managed:
  - source: salt://apt-cacher-ng/files/acng.conf.{{ grains.os_family }}
  - template: jinja
  - require:
    - pkg: aptcacher_packages

aptcacher_services:
  service.running:
  - enable: true
  - names: {{ server.services }}
  - watch:
    - file: /etc/apt-cacher/acng.conf

{%- endif %}
