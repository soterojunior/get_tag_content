require 'grape-swagger'

module Tagcontent
  module V1
    class Base < Grape::API
      version 'v1', using: :path

      namespace :index_content do
        mount Content
      end

      add_swagger_documentation :info => {
        title: "Welcome to the API Documentation",
        description: "[Linkedin - Sotero Jr.](https://www.linkedin.com/in/soterojunior/) `RESTful Json API that index a page's content` \n
            This Web Service API will show how work the endpoints with Grape and Swagger Documentation.
            Created in April 19, 2018. by Sotero Junior."
      },
                                :hide_documentation_path => true,
                                :mount_path => "/swagger_doc",
                                api_version: 'v1'

    end
  end
end
