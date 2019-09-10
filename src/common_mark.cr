require "./lib_cmark"

# Crystal wrapper for libcmark, the reference CommonMark C library.
#
# ```
# md = CommonMark.new(text)
# ```
#
# Render to another format:
# ```
# md.to_html  # => HTML
# md.to_man   # => man page
# ```
class CommonMark
  # The original markdown text.
  getter text : String

  # Initializes a new CommonMark parser.
  #
  # ```
  # md = CommonMark.new(text, smart: true)
  # md.to_html
  # ```
  #
  # Options:
  # * `hardbreak` — render `softbreak` elements as hard line breaks.
  # * `unsafe` — keep raw HTML and unsafe links (`javascript:`, `vbscript:`, `file:`, and `data:`, except for `image/png`, `image/gif`, `image/jpeg`, or `image/webp` mime types). Raw HTML is replaced by a placeholder HTML comment. Unsafe links are replaced by empty strings.
  # * `sourcepos` — include a `data-sourcepos` attribute on all block elements.
  # * `smart` — convert straight quotes to curly, `---` to em dashes, `--` to en dashes.
  # * `normalize` — normalize tree by consolidating adjacent text nodes.
  # * `validate_utf8` — Validate UTF-8 in the input before parsing, replacing illegal sequences with the replacement character U+FFFD.
  def initialize(@text, sourcepos = false, hardbreaks = false, normalize = false, validate_utf8 = false, smart = false, unsafe = false)
    @options  = LibCmark::OPT_DEFAULT
    @options |= LibCmark::OPT_SOURCEPOS if sourcepos
    @options |= LibCmark::OPT_HARDBREAKS if hardbreaks
    @options |= LibCmark::OPT_NORMALIZE if normalize
    @options |= LibCmark::OPT_VALIDATE_UTF8 if validate_utf8
    @options |= LibCmark::OPT_SMART if smart
    @options |= LibCmark::OPT_UNSAFE if unsafe
  end

  {% for option in %w(sourcepos hardbreaks normalize smart unsafe validate_utf8)%}
    # Returns true if the `{{ option.id }}` option was set.
    def {{ option.id }}?
      @options & LibCmark::OPT_{{ option.upcase.id }} == LibCmark::OPT_{{ option.upcase.id }}
    end
  {% end %}

  {% for export in %w(html xml) %}
    # Renders `#text` as {{ export.upcase.id }}.
    def to_{{ export.id }}
      parse do |document|
        result = LibCmark.render_{{ export.id }}(document, @options)
        String.new(result)
      end
    end
  {% end %}

  {% for export in %w(commonmark latex man) %}
    # Renders `#text` as a {{ export.id }} page.
    def to_{{ export.id }}(width = 80)
      parse do |document|
        result = LibCmark.render_{{ export.id }}(document, @options, width)
        String.new(result)
      end
    end
  {% end %}

  def parse
    document = LibCmark.parse_document(text, text.bytesize, @options)
    yield document
  ensure
    LibCmark.node_free(document) if document
  end
end
