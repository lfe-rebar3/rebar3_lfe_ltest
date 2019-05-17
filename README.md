# lfe-test

[![Build Status][travis badge]][travis] [![LFE Versions][lfe badge]][lfe] [![Erlang Versions][erlang badge]][versions] [![Tags][github tags badge]][github tags] [![Downloads][hex downloads]][hex package]

*The LFE rebar3 test plugin*

[![][lr3-logo]][lr3-logo]


## Build


```bash
    $ rebar3 compile
```


## Use

Add the plugin to your ``rebar.config``:

```erlang
{plugins, [
  {'lfe-test', ".*",
    {git, "https://github.com/lfe-rebar3/test.git",
      {branch, "master"}}}
]}.
```

Then just call your plugin directly from your project directory:

```bash
$ rebar3 help lfe test
...
```

```bash
$ rebar3 lfe test
...
```

<!-- Named page links below: /-->

[lr3-logo]: priv/images/logo.png
[org]: https://github.com/lfe-rebar3
[github]: https://github.com/lfe-rebar3/test
[gitlab]: https://gitlab.com/lfe-rebar3/test
[travis]: https://travis-ci.org/lfe-rebar3/test
[travis badge]: https://img.shields.io/travis/lfe-rebar3/test.svg
[lfe]: https://github.com/rvirding/lfe
[lfe badge]: https://img.shields.io/badge/lfe-1.3.0-blue.svg
[erlang badge]: https://img.shields.io/badge/erlang-17.5%20to%2022.0-blue.svg
[versions]: https://github.com/lfe-rebar3/test/blob/master/.travis.yml
[github tags]: https://github.com/lfe-rebar3/test/tags
[github tags badge]: https://img.shields.io/github/tag/lfe-rebar3/test.svg
[hex badge]: https://img.shields.io/hexpm/v/rebar3_lfe_test.svg?maxAge=2592000
[hex package]: https://hex.pm/packages/rebar3_lfe_test
[hex downloads]: https://img.shields.io/hexpm/dt/rebar3_lfe_test.svg
