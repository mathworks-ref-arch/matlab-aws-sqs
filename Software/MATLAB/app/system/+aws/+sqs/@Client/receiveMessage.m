function receiveMessageResult = receiveMessage(obj, requestOrURL)
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
%
%  Or
%
%    receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%    % The Queue URL should always be set
%    receiveMessageRequest.setQueueUrl(queueUrl);
%    % Receive from 1 to 10 messages
%    % The number of messages returned may be less than the number requested
%    receiveMessageRequest.setMaxNumberOfMessages(3);
%    receiveMessageResult = sqs.receiveMessage(receiveMessageRequest);
%    messages = receiveMessageResult.getMessages();
%    messageBody = messages{1}.getBody();


% Copyright 2019-2021 The MathWorks, Inc.

if ischar(requestOrURL)
    receiveMessageResultJ = obj.Handle.receiveMessage(requestOrURL);
elseif isa(requestOrURL,'aws.sqs.model.ReceiveMessageRequest')
    receiveMessageResultJ = obj.Handle.receiveMessage(requestOrURL.Handle);
else
    logObj = Logger.getLogger();
    write(logObj,'error','Expected argument of type character vector or aws.sqs.model.ReceiveMessageRequest');
end

receiveMessageResult = aws.sqs.model.ReceiveMessageResult(receiveMessageResultJ);

end % function
