{%- if pillar.apt-cacher is defined %}
include:
{%- if pillar.apt-cacher.server is defined %}
- apt-cacher.server
{%- endif %}
{%- endif %}
