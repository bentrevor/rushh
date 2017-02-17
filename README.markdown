## About

RUby SHell Helper

### usage

1) add ruby definitions to `$RUSHH/in.rb`

    def oh
      puts 'yeah'
    end

2) add this to a shell startup file like `.bashrc` to regenerate shell functions and source them:

    $RUSHH/bin/rushh
    source $RUSHH/out.sh

3) now you can call the ruby functions from a shell:

    $ oh
    yeah
    $

### run specs

`bundle exec rspec`

### integration specs

`./spec/integration/rush_spec.bash`
