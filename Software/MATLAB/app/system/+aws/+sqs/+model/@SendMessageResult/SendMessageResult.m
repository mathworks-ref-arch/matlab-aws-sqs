classdef SendMessageResult < aws.Object
% SENDMESSAGERESULT Object to represent the result of a sendMessage call
%
% Example:
%    sendMessageResult = sqs.sendMessage(queueUrl, messageBody);
%    sentMessageId = sendMessageResult.getMessageId();

% Copyright 2018 The MathWorks, Inc.

methods
    function obj = SendMessageResult(varargin)
        if nargin == 0
            % do nothing, don't set handle
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.SendMessageResult')
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.SendMessageResult');
            end
            obj.Handle = varargin{1};
        else
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
