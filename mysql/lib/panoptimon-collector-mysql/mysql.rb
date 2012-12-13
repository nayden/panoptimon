module Panoptimon
  module Collector
    # == Panoptimon::Collector::MySQL
    #
    # Return the output of a given query
    #
    # == Attributes
    #
    # * +options+ - hash containing MySQL environment definitions.
    # 
    class MySQL
      
      def initialize(options={})
      	@options = options
      end

      def query 
        connect.query(options['query'])
	output
      end

      def output
	query_response = []
	query.each do |response|
	  response.each do |k,v|
	    query_response << "{\"#{k.downcase}\": \"#{v}\"}"
	  end
	end
      end
      
      def options
      	@options
      end

      private
      
      def host
        options['host'] ||= 'localhost'
      end
      
      def username
      	options['username'] ||= 'root'
      end
      
      def password
      	options['password'] ||= ''
      end
      
      def database
      	options['database'] ||= ''
      end

      def connect
        ::Mysql2::Client.default_query_options.merge!(:as => :json)
      	@connect ||= ::Mysql2::Client.new(
		                  :host     => host,
				  :username => username,
				  :password => password,
				  :port     => socket,
				  :database => database
			         )
      end

      def socket
      	(tcp || unix) ? (tcp ? options['port'] : options[:socket]) : 'socket undefined!'
      end
      
      def tcp
      	options.has_key?('port')
      end

      def unix
      	options.has_key?('socket')
      end
    end
  end
end
