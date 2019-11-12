# MATLAB Interface *for AWS SQS*

MATLAB® interface for the Amazon Web Services SQS™ service.

## Requirements
### MathWorks products
* Requires MATLAB release R2017a or later.
* AWS Common utilities found at https://github.com/mathworks-ref-arch/matlab-aws-common
* (Recommended) MATLAB Interface *for AWS SNS™* found at https://github.com/mathworks-ref-arch/matlab-aws-sns

### 3rd party products
* Amazon Web Services account   

To build a required JAR file:   
* [Maven](https://maven.apache.org/)
* JDK 7
* [AWS SDK for Java](https://aws.amazon.com/sdk-for-java/) (version 1.11.367 or later)

## Getting Started
Please refer to the [Documentation](Documentation/README.md) to get started.
The [Installation Instructions](Documentation/Installation.md) and [Getting Started](Documentation/GettingStarted.md) documents provide detailed instructions on setting up and using the interface. The easiest way to
fetch this repo and all required dependencies is to clone the top-level repository using:

```bash
git clone --recursive https://github.com/mathworks-ref-arch/mathworks-aws-support.git
```

### Build the AWS SDK for Java components
The MATLAB code uses the AWS SDK for Java and can be built using:
```bash
cd Software/Java
mvn clean package
```

Once built, use the ```/Software/MATLAB/startup.m``` function to initialize the interface which will use the
AWS Credentials Provider Chain to authenticate. Please see the [relevant documentation](Documentation/Authentication.md)
on how to specify the credentials.

### SQS Example
```matlab
% Create the client called sqs
sqs = aws.sqs.Client();
% use a JSON credentials file
sqs.useCredentialsProviderChain = false;
sqs.initialize();

% create a Queue, note AWS provides naming guidelines
QueueName = 'com-example-myQueue';
createQueueResult = sqs.createQueue(QueueName);
queueUrl = createQueueResult.getQueueUrl();

% get a list of the Queues and see that com-example-myQueue appears
listQueueResult = sqs.listQueues();
urlList = listQueueResult.getQueueUrls();

% send a message to the queue
sendMessageResult = sqs.sendMessage(queueUrl, 'My SQS Message');
sentMessageId = sendMessageResult.getMessageId();

% Receive messages from the queue
receiveMessageResult = sqs.receiveMessage(queueUrl);
messages = receiveMessageResult.getMessages();

% Get Id, receiptHandle and body of each message
for n = 1:numel(messages)
  messageId = messages{n}.getMessageId();
  receiptHandle = messages{n}.getReceiptHandle();
  body = messages{n}.getBody();
end

% cleanup by deleting the Queue and shutting down the client
deleteQueueResult = sqs.deleteQueue(queueUrl);
sqs.shutdown;
```

## Supported Products:
1. [MATLAB](https://www.mathworks.com/products/matlab.html) (R2017a or later)
2. [MATLAB Compiler™](https://www.mathworks.com/products/compiler.html) and [MATLAB Compiler SDK™](https://www.mathworks.com/products/matlab-compiler-sdk.html) (R2017a or later)
3. [MATLAB Production Server™](https://www.mathworks.com/products/matlab-production-server.html) (R2017a or later)
4. [MATLAB Parallel Server™](https://www.mathworks.com/products/distriben.html) (R2017a or later)

## License
The license for the MATLAB Interface *for AWS SQS* is available in the [LICENSE.TXT](LICENSE.TXT) file in this GitHub repository. This package uses certain third-party content which is licensed under separate license agreements. See the [pom.xml](Software/Java/pom.xml) file for third-party software downloaded at build time.

## Enhancement Request
Provide suggestions for additional features or capabilities using the following link:   
https://www.mathworks.com/products/reference-architectures/request-new-reference-architectures.html

## Support
Email: `mwlab@mathworks.com` or please log an issue.    

[//]: #  (Copyright 2018 The MathWorks, Inc.)
