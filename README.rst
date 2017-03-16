
=============
apt-cacher-ng
=============

Apt-Cacher NG is a caching HTTP proxy intended for use with download clients of system distribution's package managers.

Sample pillars
==============

Single apt-cacher service

.. code-block:: yaml

    apt-cacher:
      server:
        enabled: true
        bind:
          address: 0.0.0.0
          port: 3142


More advanced setup with Proxy and passthru patterns

.. code-block:: yaml
		aptcacher:
			server:
				enabled: true
				bind:
					address: 0.0.0.0
					port: 3142
				proxy: 'http://proxy-user:proxy-pass@proxy-host:9999'
				passthruurl:
					- 'repos.influxdata.com'
					- 'packagecloud.io'
					- 'packagecloud-repositories.s3.dualstack.us-west-1.amazonaws.com'
					- 'launchpad.net'
					- 'apt.dockerproject.org'
				passhthrupattern:
					- '\.key$'
					- '\.gpg$'
					- '\.pub$'
					- '\.jar$'

Read more
=========

* https://www.unix-ag.uni-kl.de/~bloch/acng/ 
