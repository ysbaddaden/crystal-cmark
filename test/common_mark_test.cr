require "./test_helper"

class CommonMarkTest < Minitest::Test
  TEXT = <<-MARKDOWN
  # title

  some
  body

  * item 1
  * <strong>item 2</strong>
  MARKDOWN

  def test_options
    md = CommonMark.new("")
    refute md.sourcepos?
    refute md.hardbreaks?
    refute md.normalize?
    refute md.smart?
    refute md.unsafe?

    md = CommonMark.new("", sourcepos: true, hardbreaks: true, normalize: true,
                        smart: true, unsafe: true, validate_utf8: true)
    assert md.sourcepos?
    assert md.hardbreaks?
    assert md.normalize?
    assert md.smart?
    assert md.unsafe?
    assert md.validate_utf8?
  end

  def test_to_commonmark
    commonmark = CommonMark.new(TEXT).to_commonmark
    assert_equal "# title\n\nsome body\n\n  - item 1\n  - <strong>item 2</strong>\n", commonmark
  end

  def test_to_html
    html = CommonMark.new(TEXT).to_html
    assert_match "<h1>title</h1>", html
    assert_match "<p>some\nbody</p>", html
    assert_match "<li>item 1</li>", html
    assert_match "<li><!-- raw HTML omitted -->item 2<!-- raw HTML omitted --></li>", html

    unsafe_html = CommonMark.new(TEXT, unsafe: true).to_html
    assert_match "<li><strong>item 2</strong></li>", unsafe_html
  end

  def test_to_latex
    latex = CommonMark.new(TEXT).to_latex
    assert_match "\\section{title}", latex
    assert_match "some body", latex
    assert_match "begin{itemize}\n\\item item 1", latex
  end

  def test_to_man
    man = CommonMark.new(TEXT).to_man
    assert_match ".SH\ntitle", man
    assert_match ".PP\nsome body", man
    assert_match ".IP \\[bu] 2\nitem 1", man
  end

  def test_to_xml
    xml = CommonMark.new(TEXT, unsafe: true).to_xml
    assert_match %(<heading level=\"1\">\n    <text xml:space="preserve">title</text>\n  </heading>), xml
  end
end
