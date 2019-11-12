function messageId = getMessageId(obj)
% GETMESSAGEID returns the messageId of the message
% The messageId is returned as a character vector.

% Copyright 2019 The MathWorks, Inc.

messageId = char(obj.Handle.getMessageId());

end
