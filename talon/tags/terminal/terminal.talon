tag: terminal
-
# tags should be activated for each specific terminal in the respective talon file

lisa: user.terminal_list_directories()
lisa all: user.terminal_list_all_directories()
ellis: user.terminal_list_directories()
katie [dir] [<user.text>]: user.terminal_change_directory(text or "")
katie root: user.terminal_change_directory_root()
katie (up | back): user.terminal_change_directory("..")
go <user.system_path>: insert('cd "{system_path}"\n')
path <user.system_path>: insert('"{system_path}"')
clear screen: user.terminal_clear_screen()
run last: user.terminal_run_last()
rerun [<user.text>]: user.terminal_rerun_search(text or "")
rerun search: user.terminal_rerun_search("")
kill all: user.terminal_kill_all()
vim: insert("vim ")
vim [<user.text>]: insert('vim {text}')
python: insert("python ")
python [<user.text>]: insert('python {text}')
rough: insert("ruff ")
rough [<user.text>]: insert('ruff {text}')
my pie: insert("mypy ")
my pie [<user.text>]: insert('mypy {text}')


copy paste:
    edit.copy()
    sleep(50ms)
    edit.paste()
