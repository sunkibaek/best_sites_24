module SiteHelper
  def tag_label(tag)
    content_tag :span, class: 'label label-default' do
      link_to tags_path(tag: tag) do
        (content_tag :span, '', class: 'fa fa-tag') +
          tag
      end
    end
  end
end
