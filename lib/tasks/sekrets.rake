namespace :sekrets do
  desc 'show secrets'
  task :decrypt, [:env] => [:environment] do |_, args|
    with_env(args) do |stage|
      sekrets = Utils::SekretsService.read(stage)
      File.write(decrypt_path(stage), sekrets)
    end
  end

  desc 'save secrets to encripted_file'
  task :encrypt, [:env] => [:environment] do |_, args|
    with_env(args) do |stage|
      decrypted = File.read(decrypt_path(stage))
      Utils::SekretsService.write(stage, decrypted)
    end
  end

  desc 'save secrets to encripted_file'
  task :sort, [:env] => [:environment] do |_, args|
    with_env(args) do |stage|
      sekrets = Utils::SekretsService.read(stage)
      sorted = sekrets.split("\n").sort.join("\n")
      Utils::SekretsService.write(stage, sorted)
    end
  end
end

def with_env(args, &block)
  env = (args[:env] || 'development').to_sym
  env = %w[development test production] if env == :all

  Array(env).each(&block)
end

def decrypt_path(env)
  "config/sekrets/sekrets.#{env}.yml"
end
