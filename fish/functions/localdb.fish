function localdb --description 'alias localdb=mysql -u presto -h localhost -pPassword123!'
    mysql -u presto -h localhost $argv -pPassword123! 
end
