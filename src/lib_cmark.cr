@[Link(ldflags: "-L#{__DIR__}/../ext -lcmark")]
lib LibCmark
  type CmarkNode = Void*
  fun node_free = cmark_node_free(node : CmarkNode)
  fun parse_document = cmark_parse_document(buffer : LibC::Char*, len : LibC::SizeT, options : LibC::Int) : CmarkNode
  fun render_xml = cmark_render_xml(root : CmarkNode, options : LibC::Int) : LibC::Char*
  fun render_html = cmark_render_html(root : CmarkNode, options : LibC::Int) : LibC::Char*
  fun render_man = cmark_render_man(root : CmarkNode, options : LibC::Int, width : LibC::Int) : LibC::Char*
  fun render_commonmark = cmark_render_commonmark(root : CmarkNode, options : LibC::Int, width : LibC::Int) : LibC::Char*
  fun render_latex = cmark_render_latex(root : CmarkNode, options : LibC::Int, width : LibC::Int) : LibC::Char*
  OPT_DEFAULT = 0
  OPT_SOURCEPOS = (1 << 1)
  OPT_HARDBREAKS = (1 << 2)
  OPT_NORMALIZE = (1 << 8)
  OPT_SMART = (1 << 10)
  OPT_VALIDATE_UTF8 = (1 << 9)
  OPT_UNSAFE = (1 << 17)
  VERSION = (((0 << 16) | (29 << 8)) | 0)
  VERSION_STRING = "0.29.0"
end

