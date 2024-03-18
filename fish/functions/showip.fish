function showip --wraps='ifconfig |grep "inet "' --description 'alias showip=ifconfig |grep "inet "'
  ifconfig |grep "inet " $argv; 
end
