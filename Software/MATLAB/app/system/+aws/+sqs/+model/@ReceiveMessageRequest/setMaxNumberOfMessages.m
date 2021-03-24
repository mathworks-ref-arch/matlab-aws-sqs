function setMaxNumberOfMessages(obj, maxNumberOfMessages)
% setMaxNumberOfMessages Set the maximum number of messages to return
% SQS never returns more messages than this value however, fewer messages might
% be returned). Valid values: 1 to 10. Default: 1. 
%
% Example:
%   receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%   receiveMessageRequest.setQueueUrl(queueUrl);
%   % Receive from 1 to 10 messages
%   % The number of messages returned may be less than the number requested
%   receiveMessageRequest.setMaxNumberOfMessages(3);
%   receiveMessageResult = sqs.receiveMessage(receiveMessageRequest);

% Copyright 2021 The MathWorks, Inc.

logObj = Logger.getLogger();
if ~isscalar(maxNumberOfMessages)
    write(logObj,'error','Expected maxNumberOfMessages to be scalar');
end
if ~(isfloat(maxNumberOfMessages) || isinteger(maxNumberOfMessages))
    write(logObj,'error','Expected maxNumberOfMessages to be a float or integer');
end

if (maxNumberOfMessages < 1) || (maxNumberOfMessages > 10)
    write(logObj,'error','Expected maxNumberOfMessages to be an integer value in the range 1 to 10');
end

obj.Handle.setMaxNumberOfMessages(java.lang.Integer(int32(maxNumberOfMessages)));

end