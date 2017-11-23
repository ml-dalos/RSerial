# RSerial
Serial port chat on Ruby and Shoes
# How to use
#### 1. Install socat using 'sudo apt-get install socat'
#### 2. Type in terminal 'socat -d -d pty,raw,echo=0 pty,raw,echo=0'
#### 3. Type in terminal 'PORT=/dev/pts/X ruby main.rb' 
Where X is available port from second command.
You need to start two applications with ports printed in second command.
