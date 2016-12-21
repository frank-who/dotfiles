module Dotfiles
  class ConfigFiles

    def self.run
      message('Config Files:'.bold, indent: 0)
      newsyslog
    end

    private

      def self.newsyslog
        config_dir = '/etc/newsyslog.d'
        message("#{config_dir}:".bold, indent: 2)
        Dir["#{ROOT_PATH}#{config_dir}/*"].each do |file|
          basename = file_basename(file)

          system("sudo \\cp -rf #{ROOT_PATH}#{config_dir}/#{basename} #{config_dir}/")
          message(basename, indent: 4)
        end
      end

  end
end
