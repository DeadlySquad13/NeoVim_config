" # Better comments.
" - Danger.
syn match CommentDanger #"!!.*# | hi specialComment guifg=red
" Examples for settings this for special filetypes
" (or better place the command above into ~/.vim/after/syntax/c.vim)
"au! BufEnter *.c syn match specialComment #//!!.*#  " C files (*.c)
"hi specialComment ctermfg=red guifg=red

" * Semantic Indents (descending order).
syn match CommentSemanticIndent1 #" \# .*#| hi CommentSemanticIndent1 guifg=blue
syn match CommentSemanticIndent2 #" \* .*#| hi CommentSemanticIndent2 guifg=green
syn match CommentSemanticIndent3 #" - .*#| hi CommentSemanticIndent3 guifg=green

" * Reminders.
" - Fix.
syn match CommentFix #" \<[Ff]ix:\?\>.*#| hi CommentFix guifg=blue gui=underline
" - Todo.
syn match CommentTodo #" \<[Tt]odo:\?\>.*#| hi CommentTodo guifg=orange

" - Question.
syn match CommentQuestion #" ? .*#| hi CommentQuestion guifg=blue
