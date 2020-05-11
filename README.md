# Butter

![Swift](https://github.com/erd-s/Butter/workflows/Swift/badge.svg)

A lightweight networking library.

# Requirements
- Swift 5.2.0
- Xcode 11.4

# Running the Sample

To run the sample change to the ButterSample directory and open ButterSample.xcodeproj.
The sample endpoints point to a local server which can be run by following the instructions in ButterLocalServer/README.md.

You can configure the endpoints to point to whatever you'd like, you may need to make changes to how the data is returned in `setOutputTextViewText(jsonData:)`.

# Running Tests for Butter

You can either open the sample and use the Butter scheme to run the tests or open the swift package itself and run them directly from there.

# Starting the server

## Prerequisites:

```
Python 3.8 runtime
pip3
```

## Install required packages:

`pip3 install -r requirements.txt`

## Start the server:

`python3 main.py`

## Shut down the server:

`Ctrl+C`

## Changing IP or server Port:

Edit `main.py` to use the IP and port of your choice, make sure your SampleEndpointA B and C are updated as well. 
