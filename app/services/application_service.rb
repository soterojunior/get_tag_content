class ContentError < StandardError; end

class ApplicationService
  class << self

    require 'nokogiri'
    require 'open-uri'
    require 'uri'

    def analyze_page_url(link)
      page_url = link.to_s
      if page_url =~ URI::regexp
        @doc = Nokogiri::HTML(open(page_url).read)
        @title = @doc.at_css("title").text

        p @title

        if IndexContent.exists?(url_page: page_url)
          raise ContentError.new("The page #{page_url} has already exists!")
        else

          index_content = IndexContent.new
          index_content.url_page = page_url
          index_content.save(validate: false)

          @doc.css('h1').each do |content_tag_h1|
            unless content_tag_h1.text.blank?
              tag_content = TagContent.new
              tag_content.type_tag = "h1"
              tag_content.content = content_tag_h1.text
              tag_content.index_content_id = index_content.id
              tag_content.save(validate: false)
            end
          end
          @doc.css('h2').each do |content_tag_h2|
            unless content_tag_h2.text.blank?
              tag_content = TagContent.new
              tag_content.type_tag = "h2"
              tag_content.content = content_tag_h2.text
              tag_content.index_content_id = index_content.id
              tag_content.save(validate: false)
            end
          end
          @doc.css('h3').each do |content_tag_h3|
            unless content_tag_h3.text.blank?
              tag_content = TagContent.new
              tag_content.type_tag = "h3"
              tag_content.content = content_tag_h3.text
              tag_content.index_content_id = index_content.id
              tag_content.save(validate: false)
            end
          end
          {status: 'OK', message:'Saved.'}
        end
      else
        raise ContentError.new("Invalid URL Page!")
      end
    end


    def list_tag_contents
      result_array = Array.new
      index_contents = IndexContent.all

      if index_contents.empty?
        raise ContentError.new("Content empty!")
      else
        index_contents.each do |index_content|
          content_hash = Hash.new
          content_hash[:url_page] = index_content.url_page
          content_hash[:total_h1_content] = index_content.tag_contents.where("tag_contents.type_tag = ?","h1").count
          content_hash[:total_h2_content] = index_content.tag_contents.where("tag_contents.type_tag = ?","h2").count
          content_hash[:total_h3_content] = index_content.tag_contents.where("tag_contents.type_tag = ?","h3").count
          content_hash[:created_at] = index_content.created_at
          content_hash[:tag_contents] = mount_json_tag_contents(index_content.tag_contents)
          result_array << content_hash
        end

        return result_array
      end
    end

    private

      def mount_json_tag_contents(tag_contents)
        tag_content_array = Array.new
        tag_contents.each do |tag|
          tag_content_hash = Hash.new
          tag_content_hash[:tag] = tag.type_tag
          tag_content_hash[:content] = tag.content
          tag_content_array << tag_content_hash
        end
        return tag_content_array
      end

  end
end
