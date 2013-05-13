ENVIRONMENT = :production


#the ip's here don't seem to be used anywhere
CONFIG = {
  :production => {
    :apps => [
      {
        :ip => '127.0.0.1',
        :ram => 500,
      },
    ],
    :db => {
      :ip => '127.0.0.1',
      :ram => 500
    }
  }
}

REE_PATH = "/usr/local/ruby-enterprise"
PASSENGER_VERSION = '4.0.2'
USER_TO_ADD = 'deploy'
