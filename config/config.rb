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

REE_PATH = "/usr/local/rvm/rubies/ruby-1.9.3-p392"
RVM_BASE = "/usr/local/rvm/"
PASSENGER_VERSION = '4.0.2'
USER_TO_ADD = 'deploy'

# emial that will be provided to ssh-keygen for pubkey of deploy user
SSH_KEY_EMAIL = 'user@gmail.com'