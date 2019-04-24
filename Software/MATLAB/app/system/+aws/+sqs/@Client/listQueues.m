function listQueuesResult = listQueues(obj,varargin)
% LISTQUEUES Lists SQS queues
% The maximum number of queues that can be returned is 1000.
% If you specify a value for the optional queueNamePrefix parameter
% only queues with a name that begins with the specified value are returned.
% If the queue has recently been created it can take up to a minute to
% appear in the list. A ListQueueResult is returned, from which the queue URLs
% can be obtained.
%
% Example:
%    % Without a prefix
%    sqs = aws.sqs.Client();
%    sqs.initialize();
%    listQueueResult = sqs.listQueues(uniqName);
%    urlList = listQueueResult.getQueueUrls();

% Copyright 2018 The MathWorks, Inc.

p = inputParser;
p.CaseSensitive = false;
p.FunctionName = 'listQueues';

% Provide the option of using queue prefix
addOptional(p,'queueNamePrefix','',@ischar);

% Parse and validate input
parse(p,varargin{:});

queueNamePrefix = p.Results.queueNamePrefix;

% Call the API to list the queues
listQueuesResultJ = obj.Handle.listQueues(queueNamePrefix);
listQueuesResult = aws.sqs.model.ListQueuesResult(listQueuesResultJ);

end %function
