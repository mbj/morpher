require 'devtools'
Devtools.init_rake_tasks

namespace :metrics do
  task :mutant => :coverage do
  end
end

Rake.application.load_imports
task('metrics:mutant').clear

namespace :metrics do
  task :mutant => :coverage do
    $stderr.puts 'Mutant on CI is curently disable for this repo'
  end
end
