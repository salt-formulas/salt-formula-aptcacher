aptcacher:
  server:
    enabled: true
    bind:
      address: 127.0.0.1
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
