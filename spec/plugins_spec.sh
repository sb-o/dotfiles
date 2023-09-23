Describe 'zsh-autosuggestions'
    It 'runs _zsh_autosuggest_escape_command successfully'
        When call _zsh_autosuggest_escape_command "test"
        The output should eq "test"
    End
End
Describe 'zsh-syntax-highlighting'
    It 'runs _zsh_highlight successfully'
        When call command -v _zsh_highlight
        The output should eq "_zsh_highlight"
    End
End