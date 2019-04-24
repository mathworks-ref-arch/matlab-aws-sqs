function queueUrl = getQueueUrl(obj)
% GETQUEUEURL Returns the URL of the queue
% The URL is returned as a character vector

queueUrl = char(obj.Handle.getQueueUrl());

end
