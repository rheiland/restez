

# TODO:

problem_files <- c('gbinv17.seq', 'gbpln118.seq', 'gbpln12.seq')
restez_path_set('.')
for (problem_file in problem_files) {
  file_download(problem_file)
}

db_create()

devtools::load_all('.')

db_delete(everything = TRUE)
restez_path_set('.')
db_download()

restez_connect()
db_create(min_length = 10, max_length = 1000)
restez_status()
db_delete()
restez_connect()
db_create()
restez_status()
restez_disconnect()


