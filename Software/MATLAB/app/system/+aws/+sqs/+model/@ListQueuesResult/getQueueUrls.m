function queueUrls = getQueueUrls(obj)
% GETQUEUEURLS Returns a list of queue URLs
% The URLs are returned as a cell array of character vectors. If not queue are
% listed then an empty cell array is returned.
%
% Example:
%    listQueuesResult = sqs.listQueues();
%    urlList = listQueuesResult.getQueueUrls();

% Copyright 2018 The MathWorks, Inc.

% get a Java list of topics, type com.amazonaws.internal.SdkInternalList<T>
queuesListJ = obj.Handle.getQueueUrls();

queueUrls = {};

listSize = queuesListJ.size();
arrayJ = queuesListJ.toArray();

for n = 1:listSize
    queueUrls{end+1} = char(arrayJ(n)); %#ok<AGROW>
end

end
