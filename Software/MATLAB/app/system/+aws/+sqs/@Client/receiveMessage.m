function receiveMessageResult = receiveMessage(obj, queueUrl)
% RECEIVEMESSAGE Receives up to 10 messages from an SQS queue
% If the number of messages in the queue is very small, there is no
% guarantee that you will receive any messages in a particular
% response. If this happens, repeat the request. A ReceiveMessageResult object
% is returned, from which the messages can be obtained.
%
% Example:
%    receiveMessageResult = sqs.receiveMessage(queueUrl);
%    messages = receiveMessageResult.getMessages();
%    messageBody = messages{1}.getBody();

% Copyright 2019 The MathWorks, Inc.

if ~ischar(queueUrl)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected queue name of type character vector');
end

% Call the API to receive the messages
receiveMessageResultJ = obj.Handle.receiveMessage(queueUrl);
receiveMessageResult = aws.sqs.model.ReceiveMessageResult(receiveMessageResultJ);

end % function
