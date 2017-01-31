
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

Read more
=========

* https://www.unix-ag.uni-kl.de/~bloch/acng/ 
