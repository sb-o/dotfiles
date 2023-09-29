Describe 'prepend_to_path'
    setup() {
        export RANDOM_DIR=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 50 | head -n 1); # https://www.markusdosch.com/2022/05/generating-a-random-string-on-linux-macos/

        # If it fails to generate random directory, then fall back
        if [ -z "$RANDOM_DIR" ]; then
            export RANDOM_DIR=a839sfu983uf8s9u39suf89s3uf98su3f
            
        # Or if directory already exists
        elif [ -d "/tmp/$RANDOM_DIR" ]; then
            export RANDOM_DIR=a839sfu983uf8s9u39suf89s3uf98su3f   
        fi

        mkdir /tmp/$RANDOM_DIR
    }
    cleanup() {
        export PATH="${PATH#/tmp/$RANDOM_DIR:}"
        if [ -d "/tmp/$RANDOM_DIR" ]; then
            rmdir /tmp/$RANDOM_DIR
        fi
    }
    BeforeAll 'setup'
    AfterAll 'cleanup'
    It 'successfully prepends to path'
        When call prepend_to_path /tmp/$RANDOM_DIR && [[ "$PATH" == "/tmp/$RANDOM_DIR"* ]]
        The output should eq ""
    End
End