node default {
  exec {'docker-curl':
    command => 'curl -L https://get.docker.com -o /tmp/get-docker.sh',
    path    => '/usr/bin',
    creates => '/tmp/get-docker.sh'
  }

  ~> exec {'docker-bash':
    command => 'sh /tmp/get-docker.sh',
    path    => ['/bin', '/usr/bin']
  }

  -> exec {'docker-users':
    command => 'usermod -aG docker crichmond',
    path    => '/usr/sbin'
  }

  class {'docker::compose':
    ensure  => present,
    version => 'latest'
  }

  exec {'vscode-curl':
    command => "curl -o /tmp/code.deb -L 'http://go.microsoft.com/fwlink/?LinkID=760868'",
    path    => '/usr/bin'
  }

  -> package {'vscode-dpkg':
    ensure   => latest,
    provider => dpkg,
    source   => '/tmp/code.deb'
  }
}
