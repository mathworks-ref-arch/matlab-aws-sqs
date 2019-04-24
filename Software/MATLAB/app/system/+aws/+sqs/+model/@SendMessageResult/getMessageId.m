function messageId = getMessageId(obj)
% GETMESSAGEID returns the messageId of the message
% The messageId is returned as a character vector.

messageId = char(obj.Handle.getMessageId());

end
