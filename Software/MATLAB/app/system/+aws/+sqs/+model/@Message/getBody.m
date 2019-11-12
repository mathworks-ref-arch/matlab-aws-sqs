function body  = getBody(obj)
% GETBODY returns the body of the message
% The body is returned as a character vector.

% Copyright 2019 The MathWorks, Inc.

body = char(obj.Handle.getBody());

end
