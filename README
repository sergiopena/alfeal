# Alfeal
## Arabic conjugation study tool

This script starts a webservice showing a random Arabic verb, a tense, a number, a person and its conjugated form hidden. Allowing the user to check for the correct answer.

It relays on [qutrub](https://github.com/linuxscout/qutrub) from @linuxscout to get the correct conjugated verb.

# Installation

- git clone
- cd alfeal
- gem install bundler
- bundler install

It comes ready with Puma exposing a unix socket to run behind nginx.

### Run it standalone:
- ./main.rb

It will start listening on port 4567

### Run it behing nginx

- Uncomment `Elfeal.run!` at the end of mair.rb file
- Run puma -C puma.rb
- Proxy from http to unix socket on nginx, there is an example [here](./distrib/nginx_alfeal.conf)
