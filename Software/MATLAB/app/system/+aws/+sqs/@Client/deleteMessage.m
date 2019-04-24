function deleteMessageResult = deleteMessage(obj, queueUrl, receiptHandle)
% DELETEMESSAGE Deletes the specified message from the specified SQS queue
% Specify the message using the message's receipt handle, not the message ID
% received when the message was sent.
% The receipt handle is an identifier provided when a message is received from a
% queue. A DeleteMessageResult object is returned.
%
% Example:
%    receiveMessageResult = sqs.receiveMessage(queueUrl);
%    messages = receiveMessageResult.getMessages();
%    receiptHandle = messages{1}.getReceiptHandle();
%    deleteMessageResult = sqs.deleteMessage(queueUrl, receiptHandle);
%    tf = strcmp(deleteMessageResult.toString(), '{}');

% Copyright 2018 The MathWorks, Inc.

% Return error if queue name is not character vector
if ~ischar(receiptHandle)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected receiptHandle of type character vector');
end

if ~ischar(queueUrl)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected queueURL of type character vector');
end

% Delete the specified message from the specified queue
deleteMessageResultJ = obj.Handle.deleteMessage(queueUrl, receiptHandle);
deleteMessageResult = aws.sqs.model.DeleteMessageResult(deleteMessageResultJ);

end % function
