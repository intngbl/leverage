class FakeInput < SimpleForm::Inputs::StringInput
  def input
    # Creates a basic input without reading any attribute from object
    template.text_field_tag(attribute_name, nil, input_html_options)
  end
end
