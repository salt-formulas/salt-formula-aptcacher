
include:
{%- if pillar.apt_cacher_ng.server is defined %}
- apt_cacher_ng.server
{%- endif %}
