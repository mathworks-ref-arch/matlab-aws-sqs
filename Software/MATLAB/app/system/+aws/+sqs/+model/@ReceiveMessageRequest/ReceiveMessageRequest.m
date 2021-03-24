classdef ReceiveMessageRequest < aws.Object
% RECEIVEMESSAGEREQUEST Object to represent request using a receiveMessage call
% This class can be used to configure a message receive request for example to
% retrieve more than the default one message per call.
%
% Example:
%   receiveMessageRequest = aws.sqs.model.ReceiveMessageRequest();
%   % The Queue URL should always be set
%   receiveMessageRequest.setQueueUrl(queueUrl);
%   % Receive from 1 to 10 messages
%   % The number of messages returned may be less than the number requested
%   receiveMessageRequest.setMaxNumberOfMessages(3);
%   receiveMessageResult = sqs.receiveMessage(receiveMessageRequest);

% Copyright 2021 The MathWorks, Inc.

methods
    function obj = ReceiveMessageRequest(varargin)
        if nargin == 0
            obj.Handle = com.amazonaws.services.sqs.model.ReceiveMessageRequest();
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.ReceiveMessageRequest')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.ReceiveMessageRequest');
            else
                obj.Handle = varargin{1};
            end
        else
            logObj = Logger.getLogger();
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
