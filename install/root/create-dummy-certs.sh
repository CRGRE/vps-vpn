#!/usr/bin/env bash

openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 36500 -keyout localhost.key -out localhost.crt -subj "//CN=localhost"