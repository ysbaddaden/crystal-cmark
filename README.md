# CommonMark

Crystal wrapper for libcmark, the reference CommonMark C library.

## Install

Add the dependency to `shard.yml` then run `shards install`:

```yaml
dependencies:
  common_mark:
    github: ysbaddaden/crystal-cmark
```

This will automatically download and compile libcmark.

## Usage

```crystal
require "common_mark"
html = CommonMark.new(text).to_html
```

## License

Distributed under the [BSD 2 Clause](http://opensource.org/licenses/BSD-2-Clause) license.
