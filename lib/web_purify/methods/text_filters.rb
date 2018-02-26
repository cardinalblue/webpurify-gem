module WebPurify
  
  # WebPurify::TextFilters
  #
  # Handles methods related to determining/filtering profane text
  module TextFilters
    
    # Check for existence of profanity
    #
    # @param  text    [String]  Text to test for profanity
    # @param  options [Hash]    Options hash, used to set additional parameters
    # @return         [Boolean] True if text contains profanity, false if not
    def check(text, options={})
      params = {
        :method => WebPurify::Constants.methods[:check]
      }
      form_data = {
        :text => text
      }
      parsed = WebPurify::Request.query_with_post(text_request_base, @query_base, params.merge(options), form_data)
      return parsed[:found] == '1'
    end


    # Check for existence of profanity and return number of profane words found
    #
    # @param  text    [String]  Text to test for profanity
    # @param  options [Hash]    Options hash, used to set additional parameters
    # @return         [Integer] The number of profane words found in text 
    def check_count(text, options={})
      params = {
        :method => WebPurify::Constants.methods[:check_count]
      }
      form_data = {
        :text => text
      }
      parsed = WebPurify::Request.query_with_post(text_request_base, @query_base, params.merge(options), form_data)
      return parsed[:found].to_i
    end


    # Replace any matched profanity with provided symbol
    #
    # @param  text    [String]  Text to test for profanity
    # @param  symbol  [String]  The symbol to replace each character of matched profanity
    # @param  options [Hash]    Options hash, used to set additional parameters
    # @return         [String]  The original text, replaced with the provided symbol
    def replace(text, symbol, options={})
      params = {
        :method        => WebPurify::Constants.methods[:replace],
        :replacesymbol => symbol
      }
      form_data = {
        :text => text
      }
      parsed = WebPurify::Request.query_with_post(text_request_base, @query_base, params.merge(options), form_data)
      return parsed[:text]
    end
    
    
    # Return an array of matched profanity
    #
    # @param  text    [String]  Text to test for profanity
    # @param  options [Hash]    Options hash, used to set additional parameters
    # @return         [Array]   The array of matched profane words
    def return(text, options={})
      params = {
        :method => WebPurify::Constants.methods[:return],
      }
      form_data = {
        :text => text
      }
      parsed = WebPurify::Request.query_with_post(text_request_base, @query_base, params.merge(options), form_data)
      if parsed[:expletive].is_a?(String)
        return [] << parsed[:expletive]
      else
        return parsed.fetch(:expletive, [])
      end
    end
    
  end
end