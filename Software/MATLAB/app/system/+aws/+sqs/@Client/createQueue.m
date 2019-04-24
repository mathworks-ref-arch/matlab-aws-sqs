function createQueueResult = createQueue(obj, queueName)
% CREATEQUEUE Creates an AWS SQS queue
% Create a new standard queue, FIFO queues are not currently supported.
% To create a queue, provide a queue name that adheres to queue name
% restrictions and is unique within the queue scope.
% If a user attempts to create a queue that already exists, SQS will revert
% to that queue instead of creating one with the same name.
% More details on queue limits can be found at:
% https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-limits.html#limits-queues
% A CreateQueueResult object is returned.
%
% Example:
%    sqs = aws.sqs.Client;
%    sqs.intialialize();
%    createQueueResult = sqs.createQueue('MyQueueName');
%    queueUrl = createQueueResult.getQueueUrl();

% Copyright 2018 The MathWorks, Inc.

if ~ischar(queueName)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected queueName of type character vector');
end

% Call the API to create a queue
createQueueResultJ = obj.Handle.createQueue(queueName);
createQueueResult = aws.sqs.model.CreateQueueResult(createQueueResultJ);

end % function
