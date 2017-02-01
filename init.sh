#!/bin/bash

# Start nutch webserver for controlling with REST API
/nutch/runtime/local/bin/nutch nutchserver &
# Start nutch web gui
/nutch/runtime/local/bin/nutch webapp
