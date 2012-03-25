shared_examples 'a content type' do |opts = {}|
  
  opts[:text_allowed?] ||= false
  opts[:markdown_allowed?] ||= false
  opts[:text_required?] ||= false
  opts[:image_allowed?] ||= false
  opts[:image_required?] ||= false
  opts[:file_allowed?] ||= false
  opts[:file_required?] ||= false

  opts[:input_field] ||= :text
  opts[:input_opts] ||= {:as => :string}
  opts[:partial] ||= nil
  
  opts[:display_preview?] ||= false
  opts[:preview_options] ||= {}
  
  opts[:options] ||= {}

  # since it doesn't make sense to require text/image/file without allowing it, we automatically set the expected values
  opts[:text_allowed?] = true if opts[:text_required?]
  opts[:image_allowed?] = true if opts[:image_required?]
  opts[:file_allowed?] = true if opts[:file_required?]

  subject {described_class}

  opts.each_pair do |key, value|  
    describe ".#{key}" do
      its(key) {should == value}
    end
  end

end
