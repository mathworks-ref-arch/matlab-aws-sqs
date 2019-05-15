classdef SetQueueAttributesResult < aws.Object
% SETQUEUEATTRIBUTESRESULT Object to represent the result of a setQueueAttributes call
%
% Example:
%    setQueueAttributesResult = sqs.setQueueAttributes(queueUrl, M);
%    tf = strcmp(setQueueAttributesResult.toString(), '{}');

% Copyright 2019 The MathWorks, Inc.

methods
    function obj = SetQueueAttributesResult(varargin)
        if nargin == 1
            if ~isa(varargin{1}, 'com.amazonaws.services.sqs.model.SetQueueAttributesResult')
                logObj = Logger.getLogger();
                write(logObj,'error','argument not of type com.amazonaws.services.sqs.model.SetQueueAttributesResult');
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
