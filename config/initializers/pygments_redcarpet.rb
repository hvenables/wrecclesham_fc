class PygmentsHTML < Redcarpet::Render::HTML
  def initialize(render_options = {})
    super({hard_wrap: true}.merge(render_options))
  end

  def block_code(code, language)
    Pygments.highlight code, lexer: language
  end
end
