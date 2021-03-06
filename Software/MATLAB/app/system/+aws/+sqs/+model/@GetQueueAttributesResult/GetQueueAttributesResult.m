classdef GetQueueAttributesResult < aws.Object
% GETQUEUEATTRIBUTESRESULT Object to represent the result of a getQueueAttributes call
%
% Example:
%    getQueueAttributesResult = sqs.getQueueAttributes(queueUrl, keySet);
%    attributes = getQueueAttributesResult.getAttributes();

% Copyright 2018 The MathWorks, Inc.

methods
    function obj = GetQueueAttributesResult(varargin)
        if nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.GetQueueAttributesResult')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.GetQueueAttributesResult');
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
