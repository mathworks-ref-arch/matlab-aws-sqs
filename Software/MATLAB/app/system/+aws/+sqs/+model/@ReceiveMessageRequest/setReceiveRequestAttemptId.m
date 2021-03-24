function setReceiveRequestAttemptId(obj, receiveRequestAttemptId)
% SETRECEIVEREQUESTATTEMPTID Applies only to FIFO (first-in-first-out) queues
% Set to provide the receive request deduplication Id
%
% Example:
%   receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%   receiveMessageRequest.setReceiveRequestAttemptId('1');

% Copyright 2021 The MathWorks, Inc.

if ~ischar(receiveRequestAttemptId)
    logObj = Logger.getLogger();
    write(logObj,'error','Expected receiveRequestAttemptId of type character vector');
end

obj.Handle.setReceiveRequestAttemptId(receiveRequestAttemptId);

end