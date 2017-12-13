class testmodule {

  notify { 'notify1': }

  notify { 'notify2':
    require => Notify['notify1']
  }

  dummy { 'Test':
    path => 'test',
  }
}
