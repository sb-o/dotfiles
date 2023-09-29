Describe 'On load'
    It 'displays no warnings or errors'
        When call source $HOME/.zshrc
        The output should eq ""
    End
End