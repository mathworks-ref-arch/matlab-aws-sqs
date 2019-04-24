function body  = getBody(obj)
% GETBODY returns the body of the message
% The body is returned as a character vector.

body = char(obj.Handle.getBody());

end
