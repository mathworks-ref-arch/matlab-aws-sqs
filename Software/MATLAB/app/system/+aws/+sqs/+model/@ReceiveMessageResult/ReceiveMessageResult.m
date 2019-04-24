classdef ReceiveMessageResult < aws.Object
% RECEIVEMESSAGERESULT Object to represent the result of a receiveMessage call
%
% Example:
%    receiveMessageResult = sqs.receiveMessage(queueUrl);
%    messages = receiveMessageResult.getMessages();

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = ReceiveMessageResult(varargin)
        if nargin == 0
            % do nothing, don't set handle
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.ReceiveMessageResult')
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.ReceiveMessageResult');
            end
            obj.Handle = varargin{1};
        else
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
