# encoding: utf-8

##
# Backup Generated: alaveteli_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t alaveteli_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:alaveteli_backup, 'Daily backup for the IL Alaveteli server') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250
  ##
  # Archive [Archive]
  #
  # For more details, please see:
  # https://github.com/meskyanichi/backup/wiki/Archives
  #
  archive :mail_archive do |archive|
    # Run the `tar` command using `sudo`
    # archive.use_sudo
    # If a `root` path is set, relative paths will be relative to the
    # given `root` path and will not be expanded when added to the archive.
    #
    archive.root '/home/alaveteli/alaveteli'
    # backup raw emails (including sub-directories):
    archive.add "files/raw_emails"
  end

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = "foi_development"
    db.username           = "foi"
    db.password           = "replace_with_db_password"
    db.host               = "localhost"
    db.port               = 5432
    # db.socket             = "/tmp/pg.sock"
    db.additional_options = ["-xc", "-E=utf8"]
  end

  ##
  # Dropbox File Hosting Service [Storage]
  #
  # Access Type:
  #
  #  - :app_folder (Default)
  #  - :dropbox
  #
  # Note:
  #
  #  Initial backup must be performed manually to authorize
  #  this machine with your Dropbox account.
  #
  store_with Dropbox do |db|
    db.api_key     = "replace_with_api_key"
    db.api_secret  = "replace_with_api_secret"
    db.access_type = :app_folder
    db.path        = "/development"
    db.keep        = 25
  end

  ##
  # GPG [Encryptor]
  #
  # Setting up #keys, as well as #gpg_homedir and #gpg_config,
  # would be best set in config.rb using Encryptor::GPG.defaults
  #
  encrypt_with GPG do |encryption|
    # Setup public keys for #recipients
    encryption.keys = {}
    encryption.keys['alaveteli.il@gmail.com'] = <<-KEY
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.10 (GNU/Linux)

mQENBFFyxQUBCAC+V+nhQ1xnKDeyAiqKczrNYTUt/NYMWgdczZrv039THbOmi0lH
nMszEg9EIw97eBoBtWICKrqT+LqsBelQKI4iGV4JIUIjY2/n+joA+fyKT7zxJXqA
52e77BndV8yAGCBfVdLaEpBj5Ooc6vGXvZFNi3hYevckveIWilOVy9Ve+DemrH7V
YDW/c3qi3p0AAQIyBr0av9bhsLmOCiM1O/oBn/WvkxPGVDCQV21WuoPzWefaWk8b
4gEexlm9gvfDx1MM+uU/1mh79nzqTmhfup5zP+Ri+Y0DuH1ZYWKG8ZAWFoLvL/nT
IBQc/l/g2aVhkTshyGydEwwOT3YYc6Q2VN2PABEBAAG0MUFsYXZldGVsaSBJbCAo
QWxhdmV0ZWxpKSA8YWxhdmV0ZWxpLmlsQGdtYWlsLmNvbT6JATgEEwECACIFAlFy
xQUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEA4iZCBH+uPuB6sH/1HW
t09KHsLVuCSMHimSOEyPpxVLdwN26lGirFfp2dTMOZzmM/8VhwS+DE5nI1KeZ7Lv
bWl3YZtPiZpdJ2EBCNnYY+7t6QWTJM94kZqBm7qGXi2dKKfxpiGWEQyRuQgYvwG/
a/uDPEEySReGi1MbIa+am06EJHV7rUOTNflnlWL9fK3hdj//nRNbNtKSDNMTzN9U
rCRVclJzh00af/p7snwYVz8oSq2dai7ahiOCBePLV34CB2S+BbmAwZgLy3nR0+IC
+zfyUZ+wCY6b5RkJ/X2Y0a8LhuNSoZpdbiKQfFuvpxonk3le63fLjZY8WOsCYS3D
HEqVN7nqn4aHI3UnVWa5AQ0EUXLFBQEIALN66rOhdyM6ye+gkEBvzMP3AE8+B4zl
Ko+qrPKR4fthjsCQ5/eNtJwL/2t0ZatZSbUSrxiQXjHZV01nifZGA3838noOhvoE
JW9dvzaecCRTLneQi4k7IOomeYGNIbEz7bvi5ab122+r2L/P78CyX3rdj20rrOfZ
1qPHQvaHOowbRWEZC2H6g3vMS8a0i6bcORPs7Ghg3XSTYYWaF7o7w3js7ERTwG8I
ACAllUuglDrySv6hbm5H9SzeCjYXvxfoRSD1t0FBC6HR6izr3fB3RVPTjREVxLPI
T7kAKq/4ECjtkWsm+AQqOTbBYBf05E4CMA0qYp3S4v/FivRc48vnXdsAEQEAAYkB
HwQYAQIACQUCUXLFBQIbDAAKCRAOImQgR/rj7hIQB/9QTp9xJ9VAqcRqw+qWlj+j
cDZ3d0FsBWeCYxct0LCmXpJ1cBz8dRBu2pYLO2YqkA1NS2+nYb+soGtUMu0B5TJe
D1lNwHqEdKWzBD0JVgf2wczdwj3Q32yoQ5Qdxo25H7LfriIMtvQFqpspianeTnzv
9MVSB/EmJOmqz//UyTM3lTc6L3boS1Rgm+AGCjP7yPpM8X4IzwOqOuHzy4jV3Ysp
7jMGjfEUDGff8SgYdakOUKPMVZKWc0OpvMXTNWossHH73o9v6eJjYrqF88HZD6z4
AUX2P+6WL3qs20604bSy7XXwqEn//ViSsptsKGvpBVrCgQ9IpYDX9FsZh4iI1DvD
=M3FF
-----END PGP PUBLIC KEY BLOCK-----
    KEY

    # Specify mode (:asymmetric, :symmetric or :both)
    encryption.mode = :asymmetric

    # Specify recipients from #keys (for :asymmetric encryption)
    encryption.recipients = 'alaveteli.il@gmail.com'

  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  #notify_by Mail do |mail|
    #mail.on_success           = true
    #mail.on_warning           = true
    #mail.on_failure           = true

    #mail.from                 = "sender@email.com"
    #mail.to                   = "receiver@email.com"
    #mail.address              = "smtp.gmail.com"
    #mail.port                 = 587
    #mail.domain               = "your.host.name"
    #mail.user_name            = "sender@email.com"
    #mail.password             = "my_password"
    #mail.authentication       = "plain"
    #mail.encryption           = :starttls
  #end

end
