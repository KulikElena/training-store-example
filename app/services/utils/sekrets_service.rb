module Utils
  class SekretsService
    %i[development test production].each do |env|
      define_singleton_method(env) do
        load_sekrets(env)
      end
    end

    class << self
      def load_sekrets(stage)
        YAML.safe_load(read(stage))
      end

      def read(stage)
        Sekrets.read(sekret_path(stage), key: fetch_key(stage))
      end

      def write(stage, sekrets)
        Sekrets.write(sekret_path(stage), sekrets, key: fetch_key(stage))
      end

      def exists?(stage)
        Rails.root.join(sekret_path(stage)).exist?
      end

      private

      def fetch_key(stage)
        ENV["ENV_KEY_#{stage.to_s.upcase}"] || read_key_from_file(stage)
      end

      def read_key_from_file(env)
        key_env_file = ".sekrets.key.#{env}"
        key_file = File.exist?(key_env_file) ? key_env_file : '.sekrets.key'
        File.read(key_file).strip
      end

      def sekret_path(env)
        "config/sekrets/sekrets.#{env}.yml.enc"
      end
    end
  end
end
