module StaticPagesHelper

  def stub_text(string, count)
    #string.match(/^.{0,#{count}}\b/)[0] + "..."
    string[0..count]
  end

  def text_no_stub(string, count)
    string[(count + 1)..-1]
  end
end
