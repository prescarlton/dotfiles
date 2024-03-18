function localdb --description 'alias localdb=mysql -u db_admin -h localhost -pPassword123!'
    mysql -u db_admin -h localhost $argv -pPassword123! 
end
