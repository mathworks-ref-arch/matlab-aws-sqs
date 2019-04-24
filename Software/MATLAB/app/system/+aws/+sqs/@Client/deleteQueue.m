function deleteQueueResult = deleteQueue(obj, queueUrl)
% DELETEQUEUE Delete an AWS SQS queue
% Deletes the SQS queue specified by the queue URL, regardless of the queue's
% contents. If the specified queue does not exist, SQS throws a
% QueueDoesNotExistException. The deletion process takes up to 60 seconds and
% a user must wait at least 60 seconds before creating another queue with the
% same name. A DeleteQueueResult object is returned.
%
% Example:
%    deleteQueueResult = sqs.deleteQueue(queueUrl);
%    tf = strcmp(deleteQueueResult.toString(), '{}'));

% Copyright 2018 The MathWorks, Inc.

% Return error if input is not character vector
if ~ischar(queueUrl)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected queueUrl of type character vector');
end

% Call the API to delete a queue
deleteQueueResultJ = obj.Handle.deleteQueue(queueUrl);
deleteQueueResult = aws.sqs.model.DeleteQueueResult(deleteQueueResultJ);

end % function
