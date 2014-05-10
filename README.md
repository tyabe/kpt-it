# kpt-it

__kpt-itはKPTによるふりかえりをリアルタイムで共有するアプリケーションです__

[第1回 #p4dhack](https://github.com/prog4designer/hackathon1st/wiki)で[@tyabe](http://twitter.com/tyabe)と[@nishimuu](http://twitter.com/nishimuu)が作成しました

see: https://kpt-it.herokuapp.com/

[![Build Status](https://travis-ci.org/tyabe/kpt-it.png?branch=master)](https://travis-ci.org/tyabe/kpt-it)
[![Coverage Status](https://coveralls.io/repos/tyabe/kpt-it/badge.png?branch=master)](https://coveralls.io/r/tyabe/kpt-it?branch=master)
[![Dependency Status](https://gemnasium.com/tyabe/kpt-it.png)](https://gemnasium.com/tyabe/kpt-it)

## Application details
* based on [Padrino](http://www.padrinorb.com/)
* distributed under the [MIT License](http://tyabe.mit-license.org/)
* works with [Pusher](http://pusher.com/)

## Requirements
* ruby 2.1.1
* SQLite or PostgreSQL

## Usage
```
$ git clone git://github.com/tyabe/kpt-it.git
$ cp kpt-it
$ mv .env.example .env
$ vim .env # Edit your pusher settings
$ bundle install
$ bundle exec rake db:create
$ foreman start
```

## Contribute
Welcome your help. Please send a pull request. We'll accept good pull requests.
