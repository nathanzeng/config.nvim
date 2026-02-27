Graphql LSP not fully working it is like 10% working on the branch vim-nathan
https://www.npmjs.com/package/graphql-language-service-server#user-content-graphql-configuration-file
:LspLog gives some useful information
https://www.reddit.com/r/neovim/comments/1d0xj9k/help_needed_with_graphql_lsp_and_linter_for/

Duplicate code fragment linting? I tried this jscpd thing but it didn't work with nvim-lint out of the box
There is also sonar, but be careful not to mess up your existing dev env

Closing the file wide git blame is a little bit annoying, can we toggle it?

In neovim 11 do I even need nvim lsp config anymore
We need some way to make the lsp file more maintainable
ideas would be to break the diagnostics into a separate file
or to put the server configs into their own file
see maria solano config

Add my own custom snippets

see if we can make the git line blame not have the diff... I think there are passthrough options to blame

Fork diffview.nvim ???

try out gray for the diagnostic hint color

Camel cased spell check
Thinking about printing to the console when you toggle spellcheck

php linter? slightly concerned that php storm gave me a diagonostic when I forgot the & in CreateMobileAppDevice.php but neovim did not

git changed color to blue

it would be sick if unnest stayed in the toggle terminal

The LSP signature help is backward

todo-comments is not highlighting in diffview
