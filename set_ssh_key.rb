AUTH_KEYS_FILE = "/home/gitpod/.ssh/authorized_keys"

def write_key_to_file
    open(AUTH_KEYS_FILE, 'w') { |f|
        f.write ENV['MY_PUBLIC_KEY']
    }
    puts "Wrote public key to file #{AUTH_KEYS_FILE}"
end

if File.exist? AUTH_KEYS_FILE
    key_file = File.new(AUTH_KEYS_FILE)
    file_data = key_file.read
    if file_data.length == 0
        puts "authorized_keys file exists but is empty"
        write_key_to_file
    else
        puts "authorized_keys file already populated."
        puts "Not doing anything."
    end
else
    puts "Going to populate the file"
    write_key_to_file
end

puts " "
puts "Done!"