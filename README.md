# kpt-it

__kpt-itはKPTによるふりかえりをリアルタイムで共有するアプリケーションです__

[第1回 #p4dhack](https://github.com/prog4designer/hackathon1st/wiki)で[@tyabe](http://twitter.com/tyabe)と[@nishimuu](http://twitter.com/nishimuu)が作成しました

see: http://kpt-it.herokuapp.com/

## Application details
* based on [Padrino](http://www.padrinorb.com/)
* distributed under the [MIT License](http://tyabe.mit-license.org/)
* works with [Pusher](http://pusher.com/)

## Requirements
* ruby 1.9.2+
* SQLite or PostgreSQL

## Usage
```
$ git clone git://github.com/tyabe/kpt-it.git
$ cp kpt-it
$ mv .env.example .env
$ vim .env
$ bundle install
$ padrino rake ar:create
$ foreman start
```

## Contribute
Welcome your help. Please send a pull request. We'll accept good pull requests.
