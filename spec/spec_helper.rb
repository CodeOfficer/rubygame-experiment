require "rubygems"
require 'test/unit'
require "spec"
require "pp"

# $LOAD_PATH << File.expand_path(File.join('..', 'lib'), File.dirname(__FILE__))

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }

__END__
