{%- from "apt_cacher_ng/map.jinja" import server with context %}
{%- if server.enabled %}

apt_cacher_ng_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

/etc/apt-cacher-ng:
  file.directory:
  - mode: 755
  - makedirs: true

/etc/apt-cacher-ng/acng.conf:
  file.managed:
  - source: salt://apt_cacher_ng/files/acng.conf.{{ grains.os_family }}
  - template: jinja
  - require:
    - file: /etc/apt-cacher-ng
    - pkg: apt_cacher_ng_packages

apt_cacher_ng_services:
  service.running:
  - enable: true
  - names: {{ server.services }}
  - watch:
    - file: /etc/apt-cacher-ng/acng.conf

{%- endif %}
