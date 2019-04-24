classdef CreateQueueResult < aws.Object
% CREATEQUEUERESULT Object to represent the result of a createQueue call
% The queue URL is obtained from this class.
%
% Example:
%    createQueueResult = sqs.createQueue(uniqName);
%    queueUrl = createQueueResult.getQueueUrl();

% Copyright 2018 The MathWorks, Inc.

methods
    function obj = CreateQueueResult(varargin)
        if nargin == 0
            % do nothing, don't set handle
        elseif nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.CreateQueueResult')
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.CreateQueueResult');
            end
            obj.Handle = varargin{1};
        else
            write(logObj,'error','Invalid number of arguments');
        end
    end
end

end
