function setVisibilityTimeout(obj, visibilityTimeout)
% SETVISIBILITYTIMEOUT Duration that the received messages are hidden
% Messages are hidden from subsequent retrieve requests after being retrieved by
% a ReceiveMessage request. The visibilityTimeout is given in seconds.
%
% Example:
%   receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%   receiveMessageRequest.setVisibilityTimeout(10);

% Copyright 2021 The MathWorks, Inc.

logObj = Logger.getLogger();
if ~isscalar(visibilityTimeout)
    write(logObj,'error','Expected visibilityTimeout to be scalar');
end
if ~(isfloat(visibilityTimeout) || isinteger(visibilityTimeout))
    write(logObj,'error','Expected maxNumberOfMessages to be a float or integer');
end

if visibilityTimeout < 1
    write(logObj,'error','Expected visibilityTimeout to be positive');
end

obj.Handle.setVisibilityTimeout(java.lang.Integer(int32(visibilityTimeout)));

end