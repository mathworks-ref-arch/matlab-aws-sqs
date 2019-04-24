function receiptHandle  = getReceiptHandle(obj)
% GETRECEIPTHANDLE returns the receiptHandle of the message
% The receiptHandle is returned as a character vector. It is required to delete
% a message.

receiptHandle = char(obj.Handle.getReceiptHandle());

end
