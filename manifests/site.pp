node default {
  class {'docker':
    version      => 'latest',
    docker_users => ['crichmond']
  }

  class {'docker::compose':
    ensure  => present,
    version => 'latest'
  }

  exec {'vscode-curl':
    command => 'curl -o /tmp/code.deb -L "http://go.microsoft.com/fwlink/?LinkID=760868"',
    path    => '/usr/bin'
  }

  -> package {'vscode-dpkg':
    ensure   => latest,
    provider => dpkg,
    source   => '/tmp/code.deb'
  }

  exec {'chrome-curl':
    command => 'curl -o /tmp/chrome.deb -L "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"',
    path    => '/usr/bin'
  }

  -> package {'chrome-dpkg':
    ensure   => latest,
    provider => dpkg,
    source   => '/tmp/chrome.deb'
  }

  class { 'nodejs': }
}
