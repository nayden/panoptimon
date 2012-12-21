default['panoptimon']['collectors'] = {
  'cpu'        => {'interval' => '1'},
  'disk'       => {'interval' => '1'},
  'disk_free'  => {},
  'files'      => {
    'description' => 'count/stat some files',
    'paths'       => {
      '/ writable dirs' => {
        'path'    =>  '/', 
        'only'    =>  %w[bin boot dev etc home lib usr],
        'skip'    =>  %w[tmp],
        'filters' => %w[directory world_writable]
      }
    }
  },
  'interfaces' => {},
  'load'       => {},
  'iostat'     => {'interval' => '1'},
  'memcached'  => {
    'hosts' => {
      'jim' => '10.0.0.1:11211',
      'bob' => '10.0.0.2:11211'
    },
    'memstat' => "/usr/bin/memstat"
  },
  'memory' => {'interval' => '1'},
  'mysql_status' => {
    'description' =>  'mysql status and slave status collector. Config must provide some valid combination of hostname,username,password,database,port,socket to connect.',
    'socket'      => "/tmp/mysql.socket"
  },
  'network' => {
    'report' => {
      'gemserver' => {
        'localaddr' => '127.0.0.1',
        'localport' => '8808'
      },
      'ssh' => {
        'localport' => '22',
        'state'     => 'ESTABLISHED'
      },
      'daemons' => {'state' => 'LISTEN'},
      'servers' => {'state' => 'LISTEN', 'localaddr' => '0.0.0.0'},
      'self'    => {'state' => 'ESTABLISHED', 'remoteaddr' => '127.0.0.1'},
      'east'    => {'remoteaddr' => "66\\.225\\.\\d+\\.\\d+"},
      'west'    => {'remoteaddr' => "173.194.*.*"}
    },
    'interval' => '1'
  },
  'processes' => {
    'checks' => {
      'sshd' => {
        'full' => '^/usr/sbin/sshd'
      },
      'root_shells' => {
        'pattern' => '^(ba)?sh',
        'user'    => 'root'
      },
      'daemons' => {
        'user' => ['daemon', 'nobody', 'www-data']
      }
    }
  },
  'service' => {
    'interval' => '60',
    'flaptime' => '30',
    'since'    => '900',
    'services' => {'daemontools' => {'-monitor' =>  '[/service/*]'}}
  }
}    
