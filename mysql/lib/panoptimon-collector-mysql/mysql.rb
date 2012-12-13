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
        @options = default_options.merge!(options)
      end

      def query
        output = []
        response = connect.query(options['query'])
        response.each do |resp|
          resp.each do |k,v|
            output << "{#{k} => #{v}}"
          end
        end
        output
      end
      
      def options
        @options
      end

      def default_options
        {
          :host     => 'localhost',
          :username => 'root',
          :password => '',
          :database => ''
        }
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