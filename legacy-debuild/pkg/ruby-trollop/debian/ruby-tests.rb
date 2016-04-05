$: << 'lib' << 'test' << '.'
Dir['test/*.rb'].each { |f| require f }
