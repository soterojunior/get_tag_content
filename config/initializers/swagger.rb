GrapeSwaggerRails.options.url      = '/v1/swagger_doc'
GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
GrapeSwaggerRails.options.doc_url = "/swagger"
GrapeSwaggerRails.options.api_key_name = 'token'
GrapeSwaggerRails.options.api_key_type = 'query'
GrapeSwaggerRails.options.app_name = 'Tag Content API'
