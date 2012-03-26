# desc "Explaining what the task does"
# task :activeadmin-cms do
#   # Task goes here
# end

desc 'Test task'
task :cms do
end

namespace :active_admin do
  namespace :cms do
    namespace :recipe do
      desc 'Enables the specified recipe'
      task :enable, [:recipe_name] do |t, args|
        "puts enabling #{args.recipe_name}"
      end
    end
  end
end
  
