require('jdtls').start_or_attach({
  cmd = { 'jdtls', '--jvm-arg=-javaagent:' .. require('nix').lombok_path },
  root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),
})
