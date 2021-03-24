function setQueueUrl(obj, queueUrl)
% SETQUEUEURL Set URL of SQS queue from which messages are received
%
% Example:
%   receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%   receiveMessageRequest.setQueueUrl(queueUrl);

% Copyright 2021 The MathWorks, Inc.

if ~ischar(queueUrl)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected queue name of type character vector');
end

obj.Handle.setQueueUrl(queueUrl);

end