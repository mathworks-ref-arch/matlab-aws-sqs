function shutdown(obj)
% SHUTDOWN Method to shutdown an SQS client and release resources.
% This method should be called to cleanup a client which is no longer
% required.
%
% Example:
%    sqs = aws.sqs.Client;
%    % Perform operations using Client
%    sqs.shutdown;

% Copyright 2019 The MathWorks, Inc.

obj.Handle.shutdown();

end %function
