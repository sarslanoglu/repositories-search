## Description

Basic application to fetch Github public repos

## Install

### Clone the repository

```shell
git clone git@github.com:sarslanoglu/repositories-search.git
cd srepositories-search
```

### Check your Ruby version

```shell
ruby -v
```

The output should be like `ruby 3.0.0`

If not, install the right ruby version using [rvm](https://github.com/rvm/rvm) (it could take a while):

```shell
rvm install 3.0.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```

## Serve

```shell
rails s
```

Just visit http://localhost:3000/ or your configuration of local url

## Testing

For rubocop to run

```shell
rubocop
```

For rspec to run

```shell
rspec
```