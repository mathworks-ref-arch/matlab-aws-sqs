function sendMessageResult = sendMessage(obj, queueUrl, messageBody)
% SENDMESSAGE Delivers a message to the specified queue
% A message can include only XML, JSON, and unformatted text. The following
% Unicode characters are allowed:
%
% #x9 | #xA | #xD | #x20 to #xD7FF | #xE000 to #xFFFD | #x10000 to #x10FFFF
%
% Any characters not included in this list will be rejected.
% Duplicate messages are allowed. A SendMessageResult object is returned.
% The upper limit and default maximum message size is 262144 bytes.
%
% Example:
%    messageBody = 'SQS test message';
%    sendMessageResult = sqs.sendMessage(queueUrl, messageBody);
%    sentMessageId = sendMessageResult.getMessageId();

% Copyright 2019 The MathWorks, Inc.

if ~ischar(queueUrl)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected queueURL of type character vector');
end
if ~ischar(messageBody)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected messageBody of type character vector');
end

% get the size in bytes to allow for unicode conversion of 2-byte characters
% A queue may have a reduced message size, however this requires a change to
% defaults it can be check based on queue attributes if required.
W = whos('messageBody');
if W.bytes > 262144
    write(logObj,'error','Max. message length (262144 bytes) exceeded');
end

% send a message to the specified queue
sendMessageResultJ = obj.Handle.sendMessage(queueUrl, messageBody);
sendMessageResult = aws.sqs.model.SendMessageResult(sendMessageResultJ);

end %function
