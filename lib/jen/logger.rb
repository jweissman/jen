module Jen
  module Log
    DEFAULT_LEVEL = :warn

    def self.bright_colors
      @bright_colors ||= Logging.color_scheme 'bright', levels: {
	  info:  :green,
	  warn:  :yellow,
	  error: :red,
	  fatal: [:white, :on_red]
        },
	date:    :blue,
	logger:  :blue,
	message: :cyan
    end

    def self.stdout_appender
      bright_colors
      @stdout_appender ||= Logging.appenders.stdout( 'stdout', layout: Logging.layouts.pattern( pattern: '[%d] %-5l %c: %m\n', color_scheme: 'bright'))
    end

    def self.stdout(level=nil)
      stdout_appender
      log = Logging.logger['Jen']
      log.add_appenders 'stdout'
      log.level = level || DEFAULT_LEVEL
      log
    end
  end

  def logger
    @logger ||= Log.stdout
  end
end
