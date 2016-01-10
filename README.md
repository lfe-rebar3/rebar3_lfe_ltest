# lfe-test

*The LFE rebar3 test plugin*

<img src="resources/images/logo.png" />


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
