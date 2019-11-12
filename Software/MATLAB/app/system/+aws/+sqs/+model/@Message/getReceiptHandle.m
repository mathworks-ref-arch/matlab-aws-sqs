function receiptHandle  = getReceiptHandle(obj)
% GETRECEIPTHANDLE returns the receiptHandle of the message
% The receiptHandle is returned as a character vector. It is required to delete
% a message.

% Copyright 2019 The MathWorks, Inc.

receiptHandle = char(obj.Handle.getReceiptHandle());

end
