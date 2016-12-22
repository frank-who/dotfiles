![more dots](https://raw.githubusercontent.com/franks921/dotfiles/master/assets/dots.jpg)

## Postgres

### Upgrading

```
initdb /usr/local/var/postgres9.6 -E utf8

pg_upgrade \
  -d /usr/local/var/postgres \
  -D /usr/local/var/postgres_old \
  -b /usr/local/Cellar/postgresql/9.5.0/bin/ \
  -B /usr/local/Cellar/postgresql/9.6.1/bin/ \
  -v

mv /usr/local/var/postgres /usr/local/var/postgres9.5
mv /usr/local/var/postgres9.6 /usr/local/var/postgres

gem uninstall pg
gem install pg
```

## Disclaimer

If you break your shit, it is not my fault.
