# amavisd-new puppet module

This module targets Ubuntu (12.04 onwards) Postfix setups.

## Usage

class {amavisd: ensure => 'latest'}
class {amavisd::files:}

### amavisd class options

* ensure: absent / present / latest

### amavisd::files class options

* database options
** dbistr: DBI connect string (like: "mysql:database=databasename;host=hostname;port=3306")
** dbname: database username
** dbpass: database password
** domains\_table: which table contains domain info (default: domains)
** domains\_domain: which column contains domain name in domains table (default: domain)
* Spam / AV filter options:
** virus\_checking: true uses ClamAV (default: false)
** spam\_checking: true uses spamassassin (default: false)

## Copyright

Copyright &copy; Balazs Nagy, released under the MIT license
