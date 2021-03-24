function setWaitTimeSeconds(obj, WaitTimeSeconds)
% SETWAITTIMESECONDS Duration call waits for a message to arrive before returning
% If a message is available, the call returns sooner than WaitTimeSeconds.
% If no messages are available and the wait time expires, the call returns
% successfully with an empty list of messages. The WaitTimeSeconds is given in
% seconds.
%
% Example:
%   receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%   receiveMessageRequest.setWaitTimeSeconds(10);

% Consider following note from AWS API reference:
% To avoid HTTP errors, ensure that the HTTP response timeout for ReceiveMessage
% requests is longer than the WaitTimeSeconds parameter. For example, with the
% Java SDK, you can set HTTP transport settings using the NettyNioAsyncHttpClient
% for asynchronous clients, or the ApacheHttpClient for synchronous clients. 

% Copyright 2021 The MathWorks, Inc.

logObj = Logger.getLogger();
if ~isscalar(WaitTimeSeconds)
    write(logObj,'error','Expected WaitTimeSeconds to be scalar');
end
if ~(isfloat(WaitTimeSeconds) || isinteger(WaitTimeSeconds))
    write(logObj,'error','Expected WaitTimeSeconds to be a float or integer');
end

if WaitTimeSeconds < 1
    write(logObj,'error','Expected WaitTimeSeconds to be positive');
end

obj.Handle.setWaitTimeSeconds(java.lang.Integer(int32(WaitTimeSeconds)));

end