class Tagcontent::V1::Content < Grape::API

  resource :save_tag_content do
    desc 'Send URL Page and Save Content inside of the Tags (h1,h2,h3)' do
      detail "
              Default route:

              ```
              http POST http://localhost:3000/v1/index_content/save_tag_content
              ```

              Query Parameters:
              ```
              url: 'http://www.example.com.br/'

              * The query params 'URL' is required. It`s necessary add an url valid. Example: 'http://xxxx.xxx'. because there is a validation.
              ```

              Structure Response Body when 'SUCCESS', Response Code (200):
              -----------

              ```
              {\"status\": 'SUCCESS',\"message\": 'Saved.' }

              Response Code:
              200 or 201 - 'OK'
              ```

              Structure Response Body when 'ERROR', Response Code (401,404,500):
              -----------

              ```
              {\"status\": 'ERROR' ,\"message\": 'Return a Message Error'}

              Response Code:
              401 - 'Unauthorized'
              404 - 'Not Found'
              500 - 'Internal Server Error'
              ```

            "
    end
    params do
      requires :url, type: String, desc: "Add an page URL"
    end

    post '' do
      begin
        ApplicationService.analyze_page_url(params[:url])
      rescue => error
        error!({status: 'ERROR', message:"#{$!}"}, 401)
      end
    end
  end

  resource :list_tag_content do

    desc 'List All tag content saved.' do
      detail "
              Default route:

              ```
              http GET http://localhost:3000/v1/index_content/list_tag_content
              ```

              Structure Response Body, Response Code (200):
              -----------

              ```
              Example JSON return:
              [
                {
                  url_page: 'http://www.example.com/',
                  total_h1_content: 1,
                  total_h2_content: 0,
                  total_h3_content: 5,
                  created_at: '2018-04-19T05:21:53.000Z',
                  tag_contents: [
                    {
                    tag: 'h1',
                    content: 'Content inside Tag h1'
                    },
                    {
                    tag: 'h3',
                    content: 'Content inside Tag h3'
                    },
                    {
                    tag: 'h3',
                    content: 'Content inside Tag h3 again.'
                    }
                    {
                    tag: 'h2',
                    content: 'Content inside Tag h2'
                    }
                  ]
                }
              ]

              Response Code:
              200 or 201 - 'OK'
              ```

              Structure Response Body when 'ERROR', Response Code (401,404,500):
              -----------

              ```
              {\"status\": 'ERROR' ,\"message\": 'Return a Message Error'}

              Response Code:
              401 - 'Unauthorized'
              404 - 'Not Found'
              500 - 'Internal Server Error'
              ```

            "
    end

    params do
    end

    get '' do
      begin
        ApplicationService.list_tag_contents
      rescue => error
        error!({status: 'ERROR', message:"#{$!}"}, 401)
      end
    end
  end

end
