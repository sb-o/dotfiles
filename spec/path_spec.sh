Describe 'prepend_to_path'
    setup() {
        if [ ! -d "$HOME/.ges9geu0sgue" ]; then
            mkdir $HOME/.ges9geu0sgue
        fi
    }
    cleanup() {
        export PATH="${PATH#$HOME/.ges9geu0sgue:}"
        if [ -d "$HOME/.ges9geu0sgue" ]; then
            rmdir $HOME/.ges9geu0sgue
        fi
    }
    BeforeAll 'setup'
    AfterAll 'cleanup'
    It 'successfully prepends to path'
        When call prepend_to_path $HOME/.ges9geu0sgue && [[ "$PATH" == "$HOME/.ges9geu0sgue"* ]]
        The output should eq ""
    End
End